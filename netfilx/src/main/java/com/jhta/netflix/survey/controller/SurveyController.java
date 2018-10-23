package com.jhta.netflix.survey.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jhta.netflix.survey.service.SurveyService;

@Controller
public class SurveyController {
	@Autowired private SurveyService service;
	@RequestMapping(value="/survey/surveyInsert", method=RequestMethod.GET)
	public String surveyForm() {
		return ".survey.surveyForm";
	}
	@RequestMapping(value="/survey/surveyInsert",method=RequestMethod.POST)
	public String survey() {
		return "ajax써서 alert에 확인 누르면 list페이지로 넘어갈수있나";
	}
	
}
