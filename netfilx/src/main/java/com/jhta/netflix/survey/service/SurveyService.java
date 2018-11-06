package com.jhta.netflix.survey.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.survey.dao.SurveyDao;
import com.jhta.netflix.survey.vo.SurveyAnswerVo;
import com.jhta.netflix.survey.vo.SurveyQuestionVo;
import com.jhta.netflix.survey.vo.SurveyVideoVo;
import com.jhta.netflix.survey.vo.SurveyVo;
import com.jhta.netflix.user.vo.UserVo;

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
	///////////////////////////////////////////////////////////////////////////
	public int surveyUpdate(SurveyVo vo) {
		return dao.surveyUpdate(vo);
	}
	public int userPointUpdate(Map<String, Object> map) {
		return dao.userPointUpdate(map);
	}
	
	//////////////////////////////////////////////////////////////////////////
		
	
	public int surveyNumSelect(Map<String, Object> map) {
		return dao.surveyNumSelect(map);
	}
	public int sqNumSelect(Map<String, Object> map) {
		return dao.sqNumSelect(map);
	}
	public UserVo userSelect(String userId) {
		return dao.userSelect(userId);
	}
	
	//////////////////////////////////////////////////////////////////////////////
	public SurveyVo surveySelect(int surveyNum) {
		return dao.surveySelect(surveyNum);
	}
	public List<SurveyQuestionVo> surveyQuestionSelect(int surveyNum) {
		return dao.surveyQuestionSelect(surveyNum);
	}
	public List<SurveyAnswerVo> surveyAnswerSelect(int sqNum) {
		return dao.surveyAnswerSelect(sqNum);
	}
	public List<SurveyVo> surveyListSelect(Map<String, Object> map){
		return dao.surveyListSelect(map);
	}
	public List<SurveyVo> mySurveyListSelect(Map<String, Object> map){
		return dao.mySurveyListSelect(map);
	}
	public int listCountSelect(Map<String, Object> map) {
		return dao.listCountSelect(map);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	///////////////////////////////////////////////////////////////////////////////
}
