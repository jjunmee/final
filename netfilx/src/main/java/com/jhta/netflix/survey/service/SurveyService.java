package com.jhta.netflix.survey.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.survey.dao.SurveyDao;

@Service
public class SurveyService {
	@Autowired private SurveyDao dao;
	
}
