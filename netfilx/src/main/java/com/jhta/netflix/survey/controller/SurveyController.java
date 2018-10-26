 package com.jhta.netflix.survey.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jhta.netflix.survey.service.SurveyService;
import com.jhta.netflix.survey.vo.SurveyAnswerDto;
import com.jhta.netflix.survey.vo.SurveyAnswerVo;
import com.jhta.netflix.survey.vo.SurveyQuestionDto;
import com.jhta.netflix.survey.vo.SurveyQuestionVo;
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
			@ModelAttribute SurveyAnswerDto saDto) {	
		//설문테이블 insert
		surveyVo.setSurveyEnd(surveyVo.getSurveyEnd().replaceAll("/", "-"));
		service.surveyInsert(surveyVo);
		
		//설문번호 가져와서 질문테이블 insert
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("usersNum", surveyVo.getUsersNum());
		map.put("surveyName", surveyVo.getSurveyName());
		int surveyNum=service.surveyNumSelect(map);		
		List<SurveyQuestionDto> qlist = sqDto.getQlist();
		List<SurveyAnswerDto> salist=saDto.getSalist();
		for(SurveyQuestionDto sq:qlist) {
			String sqTitle=sq.getSqTitle();
			SurveyQuestionVo sqVo=new SurveyQuestionVo(0, surveyNum, sqTitle, sq.getSqType());
			service.surveyQuestionInsert(sqVo);
			
			//질문번호 가져와서 답안테이블 insert
			Map<String, Object> map1=new HashMap<String, Object>();
			map1.put("surveyNum", surveyNum);
			map1.put("sqTitle", sqTitle);
			int sqNum=service.sqNumSelect(map1);
			
			//데이터가 중복 insert 되고 있음
			//salist[0];
			for(SurveyAnswerDto alist:salist) {
				for(String answer:alist.getAlist()) {
					SurveyAnswerVo saVo=new SurveyAnswerVo(0, sqNum, answer);
					service.surveyAnswerInsert(saVo);
				}
			}
		}

		
		
		
		return ".survey.home";
	}
	
	
}
