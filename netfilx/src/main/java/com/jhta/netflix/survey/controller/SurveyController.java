package com.jhta.netflix.survey.controller;

import java.io.File;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jhta.netflix.survey.service.SurveyService;
import com.jhta.netflix.survey.vo.SurveyAnswerVo;
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
	public String survey(HttpServletRequest request,HttpServletResponse response) {		
		String surveyName=request.getParameter("surveyName");
		String surveyContent=request.getParameter("surveyContent");
		String end=request.getParameter("surveyEnd");
		Date surveyEnd=Date.valueOf(end);
		SurveyVo surveyVo=new SurveyVo(0, null, surveyName, surveyContent, null, surveyEnd);
		service.insert();
		
		
		System.out.println(surveyName);

		
		
		
		return ".survey.home";
	}
	
	
}
