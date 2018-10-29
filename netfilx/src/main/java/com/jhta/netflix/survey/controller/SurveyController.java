 package com.jhta.netflix.survey.controller;


import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
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
	
	@RequestMapping(value="/survey/home", method=RequestMethod.GET)
	public String surveyHome() {
		return ".survey.home";
	}
	
	@RequestMapping(value="/survey/surveyInsert", method=RequestMethod.GET)
	public String surveyForm() {
		return ".survey.surveyForm";
	}
	
	@RequestMapping(value="/survey/surveyInsert",method=RequestMethod.POST)
	public String survey(SurveyVo surveyVo,@ModelAttribute SurveyQuestionDto sqDto,
			@ModelAttribute SurveyAnswerDto saDto,MultipartFile file1,HttpSession session,int choiceType) {	
		//설문테이블 insert
		surveyVo.setSurveyEnd(surveyVo.getSurveyEnd().replaceAll("/", "-"));
		service.surveyInsert(surveyVo);
		
		//설문번호 가져와서 설문영상테이블 insert하고 질문테이블 insert하기
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("usersNum", surveyVo.getUsersNum());
		map.put("surveyName", surveyVo.getSurveyName());
		int surveyNum=service.surveyNumSelect(map);		
		//설문영상테이블 insert
		if(file1!=null) {//파일이 넘어왔으면
			String uploadPath=session.getServletContext().getRealPath("/resources/survey/surveyVideo");
			String orgsrc=file1.getOriginalFilename();
			String savesrc=UUID.randomUUID()+"_"+orgsrc;
			try {
				InputStream is=file1.getInputStream();
				FileOutputStream fos=new FileOutputStream(uploadPath+"\\"+savesrc);
				FileCopyUtils.copy(is, fos);
				is.close();
				fos.close();
				System.out.println(uploadPath+"경로에 파일업로드 ok");
				long filesize=file1.getSize();
				System.out.println("파일크기 : " + filesize);
				SurveyVideoVo svVo=new SurveyVideoVo(0, surveyNum, orgsrc, savesrc);
				service.surveyVideoInsert(svVo);
				
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			
			
		}else {//파일이 넘어오지 않았으면
			
		}
		
		
		List<SurveyQuestionDto> qlist = sqDto.getQlist();
		List<SurveyAnswerDto> salist=saDto.getSalist();	
		for(SurveyQuestionDto sq:qlist) {
			String sqTitle=sq.getSqTitle();
			SurveyQuestionVo sqVo=new SurveyQuestionVo(0, surveyNum, sqTitle, sq.getSqType());
			service.surveyQuestionInsert(sqVo);
			
			//질문번호가져오기
			Map<String, Object> map1=new HashMap<String, Object>();
			map1.put("surveyNum", surveyNum);
			map1.put("sqTitle", sqTitle);
			int sqNum=service.sqNumSelect(map1);
			//가져온 질문번호로 답안테이블 insert하기
			if(choiceType==1) {//객관식그리드일때
				for(int i=0;i<salist.size();i++) {
					SurveyAnswerDto alist=salist.get(i);
					for(String answer:alist.getAlist()) {
						SurveyAnswerVo saVo=new SurveyAnswerVo(0, sqNum, answer);
						service.surveyAnswerInsert(saVo);
					}						
				}					
			}else if(choiceType==2) {//복합질문형일때
				int qtime=0;//설문의 질문횟수구하기						
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
