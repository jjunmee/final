 package com.jhta.netflix.survey.controller;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jhta.netflix.content.vo.ContentVo;
import com.jhta.netflix.lib.PageUtil;
import com.jhta.netflix.point_info.service.Point_infoService;
import com.jhta.netflix.point_info.vo.Point_infoVo;
import com.jhta.netflix.survey.service.SurveyService;
import com.jhta.netflix.survey.vo.SrCntDto;
import com.jhta.netflix.survey.vo.SurveyAnswerDto;
import com.jhta.netflix.survey.vo.SurveyAnswerVo;
import com.jhta.netflix.survey.vo.SurveyInVo;
import com.jhta.netflix.survey.vo.SurveyQuestionDto;
import com.jhta.netflix.survey.vo.SurveyQuestionVo;
import com.jhta.netflix.survey.vo.SurveyResultDto;
import com.jhta.netflix.survey.vo.SurveyResultVo;
import com.jhta.netflix.survey.vo.SurveyVideoVo;
import com.jhta.netflix.survey.vo.SurveyVo;
import com.jhta.netflix.user.service.UserService;
import com.jhta.netflix.user.vo.UserVo;

@Controller
public class SurveyController {
	@Autowired private SurveyService service;
	@Autowired private Point_infoService pointService;
	@Autowired private UserService userService;
	
	@RequestMapping(value="/survey/list")
	public String surveyList(@RequestParam(value="pageNum",defaultValue="1")int pageNum,String field,String keyword,int code,
			@RequestParam(value="sort",defaultValue="surveyStart")String sort,HttpSession session,Model model) {
		String id=(String)session.getAttribute("id");
		UserVo vo=userService.login(id);
		String state="";		
		if(code==1) {//현재진행중인설문
			state="등록완료";			
		}else if(code==2){//종료된 설문
			state="설문종료";
		}		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("state", state);
		map.put("field", field);
		map.put("keyword", keyword);
		map.put("sort", sort);
		int totalRowCount=service.listCountSelect(map);
		PageUtil pageUtil=new PageUtil(pageNum, totalRowCount, 10, 10);
		map.put("startRow", pageUtil.getMysqlStartRow());
		map.put("rowBlockCount", pageUtil.getRowBlockCount());
		
		List<SurveyVo> list= service.surveyListSelect(map);
		
		List<Integer> joinCntList=new ArrayList<Integer>();
		for(SurveyVo surveyVo:list) {
			int joinCnt=service.surveyInCnt(surveyVo.getSurveyNum());
			joinCntList.add(joinCnt);
		}
		model.addAttribute("joinCntList",joinCntList);
		model.addAttribute("list",list);
		model.addAttribute("code",code);
		model.addAttribute("sort",sort);
		model.addAttribute("pageUtil",pageUtil);
		model.addAttribute("field",field);
		model.addAttribute("keyword",keyword);			
		
		if(vo.getSts()==1) {//관리자일경우 
			model.addAttribute("userSts","admin");
		}else {
			model.addAttribute("userSts","user");
		}
		return ".survey.surveyList";
	}
	@RequestMapping(value="/survey/mySurvey",method=RequestMethod.GET)
	public String mySurvey(HttpSession session,Model model) {
		String userId=(String)session.getAttribute("id");
		//String userId="alsl";
		int userNum=service.userSelect(userId).getUsers_num();
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("userNum", userNum);
		map.put("state","결제완료");
		List<SurveyVo> list0=service.mySurveyListSelect(map);		
		map.replace("state", "저장중");
		List<SurveyVo> list1= service.mySurveyListSelect(map);
		map.replace("state", "등록완료");
		List<SurveyVo> list2= service.mySurveyListSelect(map);
		map.replace("state", "설문종료");
		List<SurveyVo> list3= service.mySurveyListSelect(map);
		
		UserVo userVo=userService.login(userId);
		if(userVo.getSts()==1) {//관리자일경우 
			model.addAttribute("userSts","admin");
		}else {
			model.addAttribute("userSts","user");
		}
		model.addAttribute("list0",list0);
		model.addAttribute("list1",list1);
		model.addAttribute("list2",list2);
		model.addAttribute("list3",list3);
		
		return ".survey.mySurvey";
	}
	
	@RequestMapping("/survey/surveyInCheck")
	@ResponseBody
	public List<Integer> surveyInCheck(String userId) {
		int userNum=service.userSelect(userId).getUsers_num();
		List<Integer> surveyNumList=service.surveyInSelect1(userNum);
		return surveyNumList;
	}
	
	@RequestMapping(value="/survey/surveyDetail",method=RequestMethod.GET)
	public String detail1(int surveyNum,HttpSession session ,Model model) {
		SurveyVo surveyVo=service.surveySelect(surveyNum);//넘어온 설문번호로 설문정보가져오기
		SurveyVideoVo videoVo=service.surveyVideoSelect(surveyNum);//설문번호로 영상정보가져오기
		List<SurveyQuestionVo> sqVoList=service.surveyQuestionSelect(surveyNum);//해당 설문번호갖는 질문리스트가져오기
		List<List<SurveyAnswerVo>> saList=new ArrayList<List<SurveyAnswerVo>>();//질문에대한답안리스트들을 담는리스트
		String choiceType="2";//복합질문형일경우
		for(SurveyQuestionVo sqVo:sqVoList) {//해당 질문에 대한 답안보기들 가져오려고함
			if(sqVo.getSqType().equals("0") ) {//객관식그리드로 들어온경우
				choiceType="1";
			}
			List<SurveyAnswerVo> aList=service.surveyAnswerSelect(sqVo.getSqNum());//질문하나당답안리스트
			saList.add(aList);
		}
		
		String userId=(String)session.getAttribute("id");
		UserVo userVo=userService.login(userId);
		if(userVo.getSts()==1) {//관리자일경우 
			model.addAttribute("userSts","admin");
		}else {
			model.addAttribute("userSts","user");
		}
		
		model.addAttribute("surveyVo",surveyVo);
		model.addAttribute("videoVo",videoVo);
		model.addAttribute("sqVoList",sqVoList);
		model.addAttribute("saList",saList);		
		model.addAttribute("choiceType",choiceType);
		
		
		return ".survey.surveyDetail";
	}
	
	@RequestMapping(value="/survey/stats", method=RequestMethod.GET)
	public String statsForm(Model model, int surveyNum, int qNum,HttpSession session) {
		SurveyVo surveyVo=service.surveySelect(surveyNum);
		List<SurveyQuestionVo> sqList=service.surveyQuestionSelect(surveyNum);		
		String userId=(String)session.getAttribute("id");
		UserVo userVo=userService.login(userId);
		if(userVo.getSts()==1) {//관리자일경우 
			model.addAttribute("userSts","admin");
		}else {
			model.addAttribute("userSts","user");
		}
		//객관식그리드일경우
		if(sqList.get(0).getSqType().equals("0")) {
			String stst="";
			String strConcat="";
			for(int i=0;i<sqList.size();i++) {
				strConcat="['',";
				String stConcat="[";
				int sqNum=sqList.get(i).getSqNum();
				stConcat=stConcat+"'"+sqList.get(i).getSqTitle()+"'"+",";
				List<SrCntDto> ansList=service.srAnswerCnt(sqNum);
				List<SurveyAnswerVo> saVoList=service.surveyAnswerSelect(sqNum);
				String st="";
				for(int j=0;j<saVoList.size();j++) {
					String saAnswer=saVoList.get(j).getSaAnswer();	
					strConcat=strConcat+"'"+saAnswer+"',";
					Boolean bool=false;
					for(SrCntDto dto:ansList) {
						String srAnswer=dto.getSrAnswer();
						if(saAnswer.equals(srAnswer)) {
							int cnt=dto.getCnt();
							//int cnt=Integer.parseInt(cnt1);
							//intArr[j]=cnt;
							st=st+cnt+",";
							bool=true;
						}
					}
					if(bool==false) {
						st=st+0+",";
					}
				}			
				st=st.substring(0, st.length()-1);
				stConcat=stConcat+st+"]";
				stst=stst+stConcat+",";
				strConcat=strConcat.substring(0,strConcat.length()-1);
				strConcat=strConcat+"]";
				//strConcat=strConcat+","+stConcat;
				//strList.add(strConcat);
			}
			stst=stst.substring(0,stst.length()-1);
			strConcat=strConcat+","+stst;
			
			model.addAttribute("strConcat",strConcat);
			model.addAttribute("surveyVo",surveyVo);
			return ".survey.surveyStats1";
		//복합질문형타입일경우	
		}else {		
			SurveyQuestionVo sqVo=sqList.get(qNum-1);
			int sqNum=sqVo.getSqNum();
			if(sqVo.getSqType().equals("1") || sqVo.getSqType().equals("2")) {//객관식답안||중복답안
				List<SrCntDto> ansList=service.srAnswerCnt(sqNum);
				List<SurveyAnswerVo> saVoList=service.surveyAnswerSelect(sqNum);
				String str="['','";
				String st="['',";
				for(int i=0;i<saVoList.size();i++) {
					String saAnswer=saVoList.get(i).getSaAnswer();
					str=str+saAnswer+"','";
					Boolean bool=false;
					for(SrCntDto dto:ansList) {
						String srAnswer=dto.getSrAnswer();
						if(saAnswer.equals(srAnswer)) {
							int cnt=dto.getCnt();
							st=st+cnt+",";
							bool=true;
						}
					}
					if(bool==false) {
						st=st+0+",";
					}
				}
				st=st.substring(0,st.length()-1);
				st=st+"]";
				str=str.substring(0,str.length()-2);
				str=str+"],"+st;
				model.addAttribute("strConcat",str);	
				model.addAttribute("surveyVo",surveyVo);
				model.addAttribute("sqTitle",sqVo.getSqTitle());
				model.addAttribute("qNum",qNum);
				model.addAttribute("qNums",sqList.size());
				return ".survey.surveyStats2";
			}else if(sqVo.getSqType().equals("3")){
				List<SurveyAnswerVo> saVoList=service.surveyAnswerSelect(sqNum);
				List<SrCntDto> ansList=service.srAnswerCnt(sqNum);
				String[] ans1=new String[2];
				ans1[0]=saVoList.get(0).getSaAnswer().split("!@#")[0];
				ans1[1]=saVoList.get(0).getSaAnswer().split("!@#")[1];
				String[] ans2=new String[2];
				ans2[0]=saVoList.get(1).getSaAnswer().split("!@#")[0];
				ans2[1]=saVoList.get(1).getSaAnswer().split("!@#")[1];
				
				int num1=Integer.parseInt(ans1[0]);
				int num2=Integer.parseInt(ans2[0]);
				int[] intArr=new int[num2+1];
				for(int i=0;i<=num2;i++) {
					intArr[i]=0;					
				}
				System.out.println("ansList size : "+ansList.size());
				for(int i=0;i<ansList.size();i++) {
					int answer=Integer.parseInt(ansList.get(i).getSrAnswer());
					System.out.println("여기!!!!!!!! answer : "+answer);
					System.out.println("여기1!!!!!!!!!! cnt : "+ ansList.get(i).getCnt());
					intArr[answer]=ansList.get(i).getCnt();
				}
				String str="['','인원수']";
				String st="";
				for(int i=num1;i<=num2;i++) {					
					st=st+"['"+i+"점',"+intArr[i]+"],";
				}
				st=st.substring(0,st.length()-1);
				str=str+","+st;
				model.addAttribute("strConcat",str);
				model.addAttribute("ans1",ans1);
				model.addAttribute("ans2",ans2);
				model.addAttribute("surveyVo",surveyVo);
				model.addAttribute("sqTitle",sqVo.getSqTitle());
				model.addAttribute("qNum",qNum);
				model.addAttribute("qNums",sqList.size());
				return ".survey.surveyStats2";
				
			}else if(sqVo.getSqType().equals("4")){
				List<SurveyResultVo> ansList=service.surveyResultSelect(sqNum);
				//List<SurveyAnswerVo> saVoList=service.surveyAnswerSelect(sqNum);				
				model.addAttribute("ansList",ansList);				
				model.addAttribute("surveyVo",surveyVo);
				model.addAttribute("sqTitle",sqVo.getSqTitle());
				model.addAttribute("qNum",qNum);
				model.addAttribute("qNums",sqList.size());
				return ".survey.surveyStats3";
			}
			
		}
		return null;
		
	}

	
	@RequestMapping(value="/survey/update",method=RequestMethod.GET)
	public String update(int surveyNum,HttpSession session,Model model) {
		SurveyVo surveyVo=service.surveySelect(surveyNum);//넘어온 설문번호로 설문정보가져오기
		SurveyVideoVo videoVo=service.surveyVideoSelect(surveyNum);//설문번호로 영상정보가져오기
		List<SurveyQuestionVo> sqVoList=service.surveyQuestionSelect(surveyNum);//해당 설문번호갖는 질문리스트가져오기
		List<List<SurveyAnswerVo>> saList=new ArrayList<List<SurveyAnswerVo>>();//질문에대한답안리스트들을 담는리스트
		String choiceType="2";//복합질문형일경우
		for(SurveyQuestionVo sqVo:sqVoList) {//해당 질문에 대한 답안보기들 가져오려고함
			if(sqVo.getSqType().equals("0") ) {//객관식그리드로 들어온경우
				choiceType="1";
			}
			List<SurveyAnswerVo> aList=service.surveyAnswerSelect(sqVo.getSqNum());//질문하나당답안리스트
			saList.add(aList);
		}
		String userId=(String)session.getAttribute("id");
		UserVo userVo=userService.login(userId);
		if(userVo.getSts()==1) {//관리자일경우 
			model.addAttribute("userSts","admin");
		}else {
			model.addAttribute("userSts","user");
		}
		model.addAttribute("surveyVo",surveyVo);
		model.addAttribute("videoVo",videoVo);
		model.addAttribute("sqVoList",sqVoList);
		model.addAttribute("salist",saList);		
		model.addAttribute("choiceType",choiceType);
		
		return ".survey.surveyUpdate";
	}
	
	@RequestMapping(value="/survey/update",method=RequestMethod.POST)
	public String updateInsert(SurveyVo surveyVo,@ModelAttribute SurveyQuestionDto sqDto,
			@ModelAttribute SurveyAnswerDto saDto,MultipartFile file1,HttpSession session,int choiceType) {
		int surveyNum=surveyVo.getSurveyNum();
		//surveyTb 업데이트시키기
		service.surveyUpdate(surveyVo);
		//기존에 존재했던 영상을 해당경로에서 지우고 설문영상테이블에서 데이터 지우기
		SurveyVideoVo videoVo = service.surveyVideoSelect(surveyNum);
		if(videoVo!=null) {
			String videoUploadPath = session.getServletContext().getRealPath("/resources/upload/survey");
			File f = new File(videoUploadPath + "\\" + videoVo.getSvSaveSrc());
			f.delete();
			service.surveyVideoDelete(videoVo.getSvNum());
		}
		//설문영상테이블 insert
		try {
			if(!file1.isEmpty()) {//파일이 넘어오면
				String uploadPath=session.getServletContext().getRealPath("/resources/upload/survey");
				String orgsrc=file1.getOriginalFilename();
				String savesrc=UUID.randomUUID()+"_"+orgsrc;
				InputStream is=file1.getInputStream();
				FileOutputStream fos=new FileOutputStream(uploadPath+"\\"+savesrc);
				FileCopyUtils.copy(is, fos);
				is.close();
				fos.close();
				System.out.println("저장경로 : "+uploadPath);
				long filesize=file1.getSize();
				System.out.println("파일사이즈 : " + filesize);
				SurveyVideoVo svVo=new SurveyVideoVo(0, surveyNum, orgsrc, savesrc);
				service.surveyVideoInsert(svVo);
			}		
		}catch(NullPointerException npe) {//���ϰ����� npe�� �߻������� �׳� �ѱ�������?!
			System.out.println("영상없음!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}catch(IOException ie) {
			ie.printStackTrace();
		}
		
		//기존 surveyQuestionTb에 insert되었던 내용 지우고 다시 insert시키기
		service.surveyQuestionDelete(surveyNum);
		List<SurveyQuestionDto> qlist = sqDto.getQlist();
		List<SurveyAnswerDto> salist=saDto.getSalist();	
		int qtime=0;//질문돌리기
		for(SurveyQuestionDto sq:qlist) {
			String sqTitle=sq.getSqTitle();
			SurveyQuestionVo sqVo=new SurveyQuestionVo(0, surveyNum, sqTitle, sq.getSqType());
			service.surveyQuestionInsert(sqVo);
			int sqNum=sqVo.getSqNum();
			
			if(choiceType==1) {//객관식 그리드
				for(int i=0;i<salist.size();i++) {
					SurveyAnswerDto alist=salist.get(i);					
					for(String answer:alist.getAlist()) {
						if(answer.equals(" ")) {
							SurveyAnswerVo saVo=new SurveyAnswerVo(0, sqNum, null);
							service.surveyAnswerInsert(saVo);
						}else {
							SurveyAnswerVo saVo=new SurveyAnswerVo(0, sqNum, answer);
							service.surveyAnswerInsert(saVo);							
						}
					}											
				}					
			}else if(choiceType==2) {//복합질문타입							
				for(int i=0;i<salist.size();i++) {
					if(qtime==i) {
						SurveyAnswerDto alist=salist.get(i);
						for(String answer:alist.getAlist()) {
							SurveyAnswerVo saVo=new SurveyAnswerVo(0, sqNum, answer);
							service.surveyAnswerInsert(saVo);
						}					
					}
				}
				qtime++;
			}
		}		
		
		return "redirect:/survey/mySurvey";
	}
	
	@RequestMapping(value="/survey/surveyInsert1", method=RequestMethod.GET)
	public String surveyForm1(HttpSession session,Model model) {
		String userId=(String)session.getAttribute("id");
		//String userId="alsl";
		int point=service.userSelect(userId).getPoint();
		UserVo userVo=userService.login(userId);
		if(userVo.getSts()==1) {//관리자일경우 
			model.addAttribute("userSts","admin");
		}else {
			model.addAttribute("userSts","user");
		}
		model.addAttribute("userId",userId);
		model.addAttribute("userPoint",point);
		return ".survey.surveyForm1";
	}
	@RequestMapping(value="/survey/surveyInsert1",method=RequestMethod.POST)
	public String surveyForm1ok(SurveyVo vo,HttpSession session,Model model) {
		String userId=(String)session.getAttribute("id");
		//String userId="alsl";
		int userNum=service.userSelect(userId).getUsers_num();
		vo.setUserNum(userNum);
		service.surveyInsert(vo);//surveyNum이 넘어오나 확인해야함!!!!!!!!!!!!
		int surveyNum=vo.getSurveyNum();
		if(surveyNum>0) {
			//surveyTb에 insert되면 userTb에서 포인트 차감
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("userNum", userNum);
			map.put("point", vo.getSpoint());
			service.userPointUpdate(map);
			//pointInfo 테이블에 사용내역인서트
			String usage="설문구매-사용-"+vo.getSpoint();
			Point_infoVo pointVo=new Point_infoVo(0, null, usage, "point", userNum);
			pointService.insert(pointVo);
			
		}	
		UserVo userVo=userService.login(userId);
		if(userVo.getSts()==1) {//관리자일경우 
			model.addAttribute("userSts","admin");
		}else {
			model.addAttribute("userSts","user");
		}
		model.addAttribute("surveyNum",surveyNum);
		return ".survey.surveyForm2";
	}
	
	@RequestMapping(value="/survey/surveyInsert2",method=RequestMethod.GET)
	public String survey(int surveyNum,HttpSession session,Model model) {
		model.addAttribute("surveyNum",surveyNum);
		String userId=(String)session.getAttribute("id");
		UserVo userVo=userService.login(userId);
		if(userVo.getSts()==1) {//관리자일경우 
			model.addAttribute("userSts","admin");
		}else {
			model.addAttribute("userSts","user");
		}
		return ".survey.surveyForm2";
	}
	
	@RequestMapping(value="/survey/surveyInsert2",method=RequestMethod.POST)
	public String survey1(SurveyVo surveyVo,@ModelAttribute SurveyQuestionDto sqDto,
			@ModelAttribute SurveyAnswerDto saDto,MultipartFile file1,HttpSession session,int choiceType) {	
		//설문테이블 insert
		service.surveyUpdate(surveyVo);
		int surveyNum=surveyVo.getSurveyNum();
		//설문영상테이블 insert
		try {
			if(!file1.isEmpty()) {//파일이 넘어오면
				String uploadPath=session.getServletContext().getRealPath("/resources/upload/survey");
				String orgsrc=file1.getOriginalFilename();
				String savesrc=UUID.randomUUID()+"_"+orgsrc;
				InputStream is=file1.getInputStream();
				FileOutputStream fos=new FileOutputStream(uploadPath+"\\"+savesrc);
				FileCopyUtils.copy(is, fos);
				is.close();
				fos.close();
				System.out.println("저장경로 : "+uploadPath);
				long filesize=file1.getSize();
				System.out.println("파일사이즈 : " + filesize);
				SurveyVideoVo svVo=new SurveyVideoVo(0, surveyNum, orgsrc, savesrc);
				service.surveyVideoInsert(svVo);
			}		
		}catch(NullPointerException npe) {//���ϰ����� npe�� �߻������� �׳� �ѱ�������?!
			System.out.println("영상없음!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}catch(IOException ie) {
			ie.printStackTrace();
		}
		
		List<SurveyQuestionDto> qlist = sqDto.getQlist();
		List<SurveyAnswerDto> salist=saDto.getSalist();	
		int qtime=0;//질문돌리기
		for(SurveyQuestionDto sq:qlist) {
			String sqTitle=sq.getSqTitle();
			SurveyQuestionVo sqVo=new SurveyQuestionVo(0, surveyNum, sqTitle, sq.getSqType());
			service.surveyQuestionInsert(sqVo);
			int sqNum=sqVo.getSqNum();
			
			if(choiceType==1) {//객관식 그리드
				for(int i=0;i<salist.size();i++) {
					SurveyAnswerDto alist=salist.get(i);					
					for(String answer:alist.getAlist()) {
						if(answer.equals(" ")) {
							SurveyAnswerVo saVo=new SurveyAnswerVo(0, sqNum, null);
							service.surveyAnswerInsert(saVo);
						}else {
							SurveyAnswerVo saVo=new SurveyAnswerVo(0, sqNum, answer);
							service.surveyAnswerInsert(saVo);							
						}
					}											
				}					
			}else if(choiceType==2) {//복합질문타입							
				for(int i=0;i<salist.size();i++) {
					if(qtime==i) {
						SurveyAnswerDto alist=salist.get(i);
						for(String answer:alist.getAlist()) {
							SurveyAnswerVo saVo=new SurveyAnswerVo(0, sqNum, answer);
							service.surveyAnswerInsert(saVo);
						}					
					}
				}
				qtime++;
			}
		}
		
		return "redirect:/survey/mySurvey";
	}
	
	@RequestMapping(value="/survey/resultInsert",method=RequestMethod.POST)
	public String resultInsert(HttpSession session,int surveyNum,@ModelAttribute SurveyResultDto resultDto, Model model) {
		//SurveyIn테이블에 userId가 없으면 insert 시키기==>jsp에서 ajax로 걸러주기때문에 안해도될듯해서 수정함.
		String userId=(String)session.getAttribute("id");
		int userNum=service.userSelect(userId).getUsers_num();
		SurveyInVo siVo=new SurveyInVo(0, userNum, surveyNum);
		service.surveyInInsert(siVo);
		//SurveyResult테이블에 insert시키기
		List<SurveyResultDto> resultList= resultDto.getResultList();
		for(int i=0;i<resultList.size();i++) {
			SurveyResultDto srDto=resultList.get(i);
			int sqNum=srDto.getSqNum();
			int typeNum=service.getTypeSelect(sqNum);
			if(typeNum==2) {
				String answer=srDto.getSrAnswer();
				String[] answerArr=answer.split(",");
				for(int j=0;j<answerArr.length;j++) {					
					SurveyResultVo srVo=new SurveyResultVo(0,sqNum,answerArr[j]);
					service.resultInsert(srVo);
				}
			}else {				
				SurveyResultVo srVo=new SurveyResultVo(0,srDto.getSqNum(),srDto.getSrAnswer());
				service.resultInsert(srVo);
			}			
		}
		//users테이블에서 해당 유저id에 포인트넣어주기
		SurveyVo surveyVo=service.surveySelect(surveyNum);
		int point=(int)Math.floor(surveyVo.getSpoint()/surveyVo.getJoinNum());
		Map<String, Object> map1=new HashMap<String, Object>();
		map1.put("userNum", userNum);
		map1.put("point", point);
		service.userPointUpdate1(map1);
		
		//pointInfo 테이블에 설문참여 insert
		String usage="설문참여-적립-"+point;
		Point_infoVo pointVo=new Point_infoVo(0, null, usage, "point", userNum);
		pointService.insert(pointVo);
		
		//참여인원수가 다찼으면 설문상태를 '설문종료'로 만들기!
		int surveyCnt=service.joinCntSelect(surveyNum);
		if(surveyCnt==surveyVo.getJoinNum()) {
			Map<String, Object> map2=new HashMap<String, Object>();
			map2.put("surveyNum", surveyNum);
			map2.put("state", "설문종료"); 
			service.surveyStateUpdate(map2);
			//설문이 종료되면 해당설문의 유저번호가져와서 point반환시켜주고 pointinfo테이블에 insert
			int leftPoint=service.leftPoint(surveyNum);			
			int surUserNum=surveyVo.getUserNum();
			Map<String, Object> map3=new HashMap<String, Object>();
			map3.put("point", leftPoint);
			map3.put("userNum", surUserNum);
			service.userPointUpdate1(map3);
			Point_infoVo pointVo1=new Point_infoVo(0, null, "설문종료반환금-반환-"+leftPoint, "point", surUserNum);
			pointService.insert(pointVo1);	
			
		}
		return "redirect:/survey/list?code=1";
	}
	
	@RequestMapping(value="/survey/delete")
	public String delete(String delNumArr,int code,String userSts,HttpSession session,Model model) {
		System.out.println(delNumArr);
		String[] numArr=delNumArr.split(",");
		for(int n=0;n<numArr.length;n++) {
			int surveyNum=Integer.parseInt(numArr[n]);
			SurveyVideoVo videoVo=service.surveyVideoSelect(surveyNum);
			if(videoVo!=null) {
				String videoUploadPath = session.getServletContext().getRealPath("/resources/upload/survey");
				File f = new File(videoUploadPath + "\\" + videoVo.getSvSaveSrc());
				f.delete();
			}
			service.surveyDelete(surveyNum);
		}
		
		if(userSts.equals("admin")) {
			return "redirect:/survey/list?code="+code;
		}else{
			return "redirect:/survey/mySurvey";			
		}
	}
}
