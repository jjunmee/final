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
import org.springframework.web.multipart.MultipartFile;

import com.jhta.netflix.survey.service.SurveyService;
import com.jhta.netflix.survey.vo.SurveyAnswerDto;
import com.jhta.netflix.survey.vo.SurveyAnswerVo;
import com.jhta.netflix.survey.vo.SurveyQuestionDto;
import com.jhta.netflix.survey.vo.SurveyQuestionVo;
import com.jhta.netflix.survey.vo.SurveyVideoVo;
import com.jhta.netflix.survey.vo.SurveyVo;

@Controller
public class SurveyController {
	@Autowired private SurveyService service;
	
	@RequestMapping(value="/survey/list", method=RequestMethod.GET)
	public String surveyList(int code,Model model) {
		String state="";
		
		if(code==1) {//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½
			state="ï¿½ï¿½Ï¿Ï·ï¿½";			
		}else if(code==2){//ï¿½Ï·ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½(code:2)
			state="ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½";
		}			
		List<SurveyVo> list= service.surveyListSelect(state);
		model.addAttribute("list",list);
		model.addAttribute("code",code);
		return ".survey.surveyList";
	}
	@RequestMapping(value="/survey/mySurvey",method=RequestMethod.GET)
	public String mySurvey(Model model) {
		//String userId=(String)request.getSession().getAttribute("userId");
		String userId="alsl";
		int userNum=service.userSelect(userId).getUsersNum();
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("userNum", userNum);
		map.put("state", "ÀúÀåÁß");
		List<SurveyVo> list1= service.mySurveyListSelect(map);
		map.replace("state", "µî·Ï¿Ï·á");
		List<SurveyVo> list2= service.mySurveyListSelect(map);
		map.replace("state", "¼³¹®Á¾·á");
		List<SurveyVo> list3= service.mySurveyListSelect(map);
		model.addAttribute("list1",list1);
		model.addAttribute("list2",list2);
		model.addAttribute("list3",list3);
		
		return ".survey.mySurvey";
	}
	@RequestMapping(value="/survey/update",method=RequestMethod.GET)
	public String detail1(int surveyNum, Model model) {
		SurveyVo surveyVo=service.surveySelect(surveyNum);
		List<SurveyQuestionVo> sqList= service.surveyQuestionSelect(surveyNum);
		//Áú¹®¹øÈ£¸¸ µû·Î ¹è¿­·Î ´ã°í 
		int[] sqNumList=null;
		int i=0;
		for(SurveyQuestionVo sqVo:sqList) {
			sqNumList[i]=sqVo.getSqNum();
			i++;
		}
		//´ã±ä¹è¿­µ¹·Á¼­	´ä¾È¸®½ºÆ®¿¡ ´ã±â
		List<SurveyAnswerVo> saVoList=null;
		String[] aList=null;
		List<String[]> saList=null;		
		for(int j=0;j<sqNumList.length;j++) {			
			saVoList=service.surveyAnswerSelect(sqNumList[i]);
			for(SurveyAnswerVo vo:saVoList) {
				aList[j]=vo.getSaAnswer();
			}
			saList.add(aList);
		}		
		model.addAttribute("surveyVo",surveyVo);
		model.addAttribute("sqList",sqList);
		model.addAttribute("saList",saList);
		return ".survey.myDetail";
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
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ìºï¿½ ï¿½Î¼ï¿½Æ®ï¿½ï¿½ï¿½ï¿½ï¿½Ï¸ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ìºï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½Æ® ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Å°ï¿½ï¿½
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
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ìºï¿½ insert
		//String userId=(String)session.getAttribute("userId");
		String userId="alsl";
		int userNum=service.userSelect(userId).getUsersNum();
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("userNum", userNum);
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½Ô·Â½ï¿½Å³ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½Ô·Â½ï¿½Å³ï¿½ï¿½ï¿½ï¿½ È­ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½Ù½ï¿½ï¿½Øºï¿½ï¿½ï¿½!
		map.put("state", "ï¿½ï¿½ï¿½ï¿½ï¿½Ï·ï¿½");
		int surveyNum=service.surveyNumSelect(map);
		surveyVo.setSurveyNum(surveyNum);
		surveyVo.setSurveyEnd(surveyVo.getSurveyEnd().replaceAll("/", "-"));
		service.surveyUpdate(surveyVo);
		
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ìºï¿½ insert
		try {
			if(!file1.isEmpty()) {//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½Ñ¾ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
				String uploadPath=session.getServletContext().getRealPath("/resources/upload/survey");
				String orgsrc=file1.getOriginalFilename();
				String savesrc=UUID.randomUUID()+"_"+orgsrc;
				InputStream is=file1.getInputStream();
				FileOutputStream fos=new FileOutputStream(uploadPath+"\\"+savesrc);
				FileCopyUtils.copy(is, fos);
				is.close();
				fos.close();
				System.out.println("ï¿½ï¿½ï¿½Ï¾ï¿½ï¿½Îµï¿½ ï¿½ï¿½ï¿½ : "+uploadPath);
				long filesize=file1.getSize();
				System.out.println("ï¿½ï¿½ï¿½ï¿½Å©ï¿½ï¿½ : " + filesize);
				SurveyVideoVo svVo=new SurveyVideoVo(0, surveyNum, orgsrc, savesrc);
				service.surveyVideoInsert(svVo);
			}		
		}catch(NullPointerException npe) {//ï¿½ï¿½ï¿½Ï°ï¿½ï¿½ï¿½ï¿½ï¿½ npeï¿½ï¿½ ï¿½ß»ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½×³ï¿½ ï¿½Ñ±ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½?!
			System.out.println("ï¿½Ñ¾ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		}catch(IOException ie) {
			ie.printStackTrace();
		}
		
		List<SurveyQuestionDto> qlist = sqDto.getQlist();
		List<SurveyAnswerDto> salist=saDto.getSalist();	
		int qtime=0;//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½È½ï¿½ï¿½ï¿½ï¿½ï¿½Ï±ï¿½		
		for(SurveyQuestionDto sq:qlist) {
			String sqTitle=sq.getSqTitle();
			SurveyQuestionVo sqVo=new SurveyQuestionVo(0, surveyNum, sqTitle, sq.getSqType());
			service.surveyQuestionInsert(sqVo);
			
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½È£ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			Map<String, Object> map1=new HashMap<String, Object>();
			map1.put("surveyNum", surveyNum);
			map1.put("sqTitle", sqTitle);
			int sqNum=service.sqNumSelect(map1);
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½È£ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ìºï¿½ insertï¿½Ï±ï¿½
			
			if(choiceType==1) {//ï¿½ï¿½ï¿½ï¿½ï¿½Ä±×¸ï¿½ï¿½ï¿½ï¿½Ï¶ï¿½
				for(int i=0;i<salist.size();i++) {
					SurveyAnswerDto alist=salist.get(i);
					for(String answer:alist.getAlist()) {
						SurveyAnswerVo saVo=new SurveyAnswerVo(0, sqNum, answer);
						service.surveyAnswerInsert(saVo);
					}						
				}					
			}else if(choiceType==2) {//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ï¶ï¿½								
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
		return ".survey.home";
	}
	
}
