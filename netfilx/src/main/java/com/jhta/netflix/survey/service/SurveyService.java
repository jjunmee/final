package com.jhta.netflix.survey.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.survey.dao.SurveyDao;
import com.jhta.netflix.survey.vo.SurveyVo;

@Service
public class SurveyService {
	@Autowired private SurveyDao dao;
	
	public int insert(SurveyVo vo) {
		
	}
	
}
