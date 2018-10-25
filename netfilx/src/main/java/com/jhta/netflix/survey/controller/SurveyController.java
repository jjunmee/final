package com.jhta.netflix.survey.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jhta.netflix.survey.service.SurveyService;

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
	public String survey() {
		return ".survey.home";
	}
	
}
