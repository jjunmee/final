 package com.jhta.netflix.survey.controller;


import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.jhta.netflix.lib.PageUtil;
import com.jhta.netflix.survey.service.SurveyService;
import com.jhta.netflix.survey.vo.SurveyAnswerDto;
import com.jhta.netflix.survey.vo.SurveyAnswerVo;
import com.jhta.netflix.survey.vo.SurveyInVo;
import com.jhta.netflix.survey.vo.SurveyQuestionDto;
import com.jhta.netflix.survey.vo.SurveyQuestionVo;
import com.jhta.netflix.survey.vo.SurveyResultDto;
import com.jhta.netflix.survey.vo.SurveyResultVo;
import com.jhta.netflix.survey.vo.SurveyVideoVo;
import com.jhta.netflix.survey.vo.SurveyVo;

@Controller
public class SurveyController {
	@Autowired private SurveyService service;
	
	@RequestMapping(value="/survey/list")
	public String surveyList(@RequestParam(value="pageNum",defaultValue="1")int pageNum,String field,String keyword,int code,Model model) {
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
		int totalRowCount=service.listCountSelect(map);
		PageUtil pageUtil=new PageUtil(pageNum, totalRowCount, 10, 10);
		map.put("startRow", pageUtil.getMysqlStartRow());
		map.put("rowBlockCount", pageUtil.getRowBlockCount());
		
		List<SurveyVo> list= service.surveyListSelect(map);
		
		model.addAttribute("list",list);
		model.addAttribute("code",code);
		model.addAttribute("pageUtil",pageUtil);
		model.addAttribute("field",field);
		model.addAttribute("keyword",keyword);
		return ".survey.surveyList";
	}
	@RequestMapping(value="/survey/mySurvey",method=RequestMethod.GET)
	public String mySurvey(Model model) {
		//String userId=(String)request.getSession().getAttribute("userId");
		String userId="alsl";
		int userNum=service.userSelect(userId).getUsersNum();
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("userNum", userNum);
		map.put("state", "저장중");
		List<SurveyVo> list1= service.mySurveyListSelect(map);
		map.replace("state", "등록완료");
		List<SurveyVo> list2= service.mySurveyListSelect(map);
		map.replace("state", "설문종료");
		List<SurveyVo> list3= service.mySurveyListSelect(map);
		model.addAttribute("list1",list1);
		model.addAttribute("list2",list2);
		model.addAttribute("list3",list3);
		
		return ".survey.mySurvey";
	}
	@RequestMapping(value="/survey/surveyDetail",method=RequestMethod.GET)
	public String detail1(int surveyNum, Model model) {
		SurveyVo surveyVo=service.surveySelect(surveyNum);//넘어온 설문번호로 설문정보가져오기
		SurveyVideoVo videoVo=service.surveyVideoSelect(surveyNum);//설문번호로 영상정보가져오기
		List<SurveyQuestionVo> sqVoList=service.surveyQuestionSelect(surveyNum);//해당 설문번호갖는 질문리스트가져오기
		List<List<SurveyAnswerVo>> saList=new ArrayList<List<SurveyAnswerVo>>();//질문에대한답안리스트들을 담는리스트
		for(SurveyQuestionVo sqVo:sqVoList) {//해당 질문에 대한 답안보기들 가져오려고함
			List<SurveyAnswerVo> aList=service.surveyAnswerSelect(sqVo.getSqNum());//질문하나당답안리스트
			saList.add(aList);
		}
		model.addAttribute("surveyVo",surveyVo);
		model.addAttribute("videoVo",videoVo);
		model.addAttribute("sqVoList",sqVoList);
		model.addAttribute("saList",saList);		
		
		
		
		
		return ".survey.surveyDetail";
	}
	@RequestMapping(value="/survey/surveyInsert1", method=RequestMethod.GET)
	public String surveyForm1(Model model,HttpServletRequest request) {
		//String userId=(String)request.getSession().getAttribute("userId");
		String userId="alsl";
		int point=service.userSelect(userId).getPoint();
		model.addAttribute("userId",userId);
		model.addAttribute("userPoint",point);
		return ".survey.surveyForm1";
	}
	@RequestMapping(value="/survey/surveyInsert1",method=RequestMethod.POST)
	public String surveyForm1ok(SurveyVo vo,HttpServletRequest request,Model model) {
		//String userId=(String)request.getSession().getAttribute("userId");
		String userId="alsl";
		int userNum=service.userSelect(userId).getUsersNum();
		vo.setUserNum(userNum);
		if(service.surveyInsert(vo)>0) {
			//�������̺� �μ�Ʈ�����ϸ� �������̺��� ����Ʈ ������Ű��
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("userNum", userNum);
			map.put("point", vo.getSpoint());
			service.userPointUpdate(map);
		}
		return ".survey.surveyForm2";
	}
	
	@RequestMapping(value="/survey/surveyInsert2",method=RequestMethod.POST)
	public String survey(SurveyVo surveyVo,@ModelAttribute SurveyQuestionDto sqDto,
			@ModelAttribute SurveyAnswerDto saDto,MultipartFile file1,HttpSession session,int choiceType) {	
		//설문테이블 insert
		//String userId=(String)session.getAttribute("userId");
		String userId="alsl";
		int userNum=service.userSelect(userId).getUsersNum();
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("userNum", userNum);
		//설문번호 가져와서 설문테이블 업데이트하기
		map.put("state", "결제완료");
		int surveyNum=service.surveyNumSelect(map);
		surveyVo.setSurveyNum(surveyNum);
		service.surveyUpdate(surveyVo);
		
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
			
			//질문번호가져오기
			Map<String, Object> map1=new HashMap<String, Object>();
			map1.put("surveyNum", surveyNum);
			map1.put("sqTitle", sqTitle);
			int sqNum=service.sqNumSelect(map1);
			//������ ������ȣ�� ������̺� insert�ϱ�
			
			if(choiceType==1) {//객관식 그리드
				for(int i=0;i<salist.size();i++) {
					SurveyAnswerDto alist=salist.get(i);
					for(String answer:alist.getAlist()) {
						SurveyAnswerVo saVo=new SurveyAnswerVo(0, sqNum, answer);
						service.surveyAnswerInsert(saVo);
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
		return "redirect:/survey/list?code=1";
	}
	
	@RequestMapping(value="/survey/resultInsert",method=RequestMethod.POST)
	public String resultInsert(int surveyNum,@ModelAttribute SurveyResultDto resultDto, Model model) {
		//SurveyIn테이블에 userId가 없으면 insert 시키기
		//String userId=(String)session.getAttribute("userId");
		String userId="alsl";
		int userNum=service.userSelect(userId).getUsersNum();
		if(service.surveyInSelect(userNum)==null) {
			return "redirect:/survey/list?code=1";
		}		
		SurveyInVo siVo=new SurveyInVo(0, userNum, surveyNum);
		service.surveyInInsert(siVo);
		//SurveyResult테이블에 insert시키기
		List<SurveyResultDto> resultList= resultDto.getResultList();
		for(int i=0;i<resultList.size();i++) {
			SurveyResultDto srDto=resultList.get(i);
			SurveyResultVo srVo=new SurveyResultVo(0,srDto.getSqNum(),srDto.getSrAnswer());
			service.resultInsert(srVo);
		}
		//users테이블에서 해당 유저id에 포인트넣어주기
		SurveyVo surveyVo=service.surveySelect(surveyNum);
		int point=(int)Math.floor(surveyVo.getSpoint()/surveyVo.getJoinNum());
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("userNum", userNum);
		map.put("point", point);
		service.userPointUpdate1(map);
		//참여인원수가 다찼으면 설문상태를 '설문종료'로 만들기!
		int surveyCnt=service.joinCntSelect(surveyNum);
		if(surveyCnt==surveyVo.getJoinNum()) {
			Map<String, Object> map1=new HashMap<String, Object>();
			map1.put("surveyNum", surveyNum);
			map1.put("state", "설문종료");
			service.surveyStateUpdate(map);
		}
		
		return "redirect:/survey/list?code=1";
	}
}
