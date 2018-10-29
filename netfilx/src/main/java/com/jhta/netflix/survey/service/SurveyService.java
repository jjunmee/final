package com.jhta.netflix.survey.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.survey.dao.SurveyDao;
import com.jhta.netflix.survey.vo.SurveyAnswerVo;
import com.jhta.netflix.survey.vo.SurveyQuestionVo;
import com.jhta.netflix.survey.vo.SurveyVideoVo;
import com.jhta.netflix.survey.vo.SurveyVo;

@Service
public class SurveyService {
	@Autowired private SurveyDao dao;
	
	public int surveyInsert(SurveyVo vo) {
		return dao.surveyInsert(vo);
	}
	public int surveyQuestionInsert(SurveyQuestionVo vo) {
		return dao.surveyQuestionInsert(vo);
	}
	public int surveyAnswerInsert(SurveyAnswerVo vo) {
		return dao.surveyAnswerInsert(vo);
	}
	public int surveyVideoInsert(SurveyVideoVo vo) {
		return dao.surveyVideoInsert(vo);
	}
	
	//////////////////////////////////////////////////////////////////////////
	
	public int surveyNumSelect(Map<String, Object> map) {
		return dao.surveyNumSelect(map);
	}
	public int sqNumSelect(Map<String, Object> map) {
		return dao.sqNumSelect(map);
	}
	public int userPointSelect(String userId) {
		return dao.userPointSelect(userId);
	}
	//////////////////////////////////////////////////////////////////////////////
}
