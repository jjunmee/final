package com.jhta.netflix.survey.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.survey.dao.SurveyDao;
import com.jhta.netflix.survey.vo.SrCntDto;
import com.jhta.netflix.survey.vo.SurveyAnswerVo;
import com.jhta.netflix.survey.vo.SurveyInVo;
import com.jhta.netflix.survey.vo.SurveyQuestionVo;
import com.jhta.netflix.survey.vo.SurveyResultVo;
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
	public int resultInsert(SurveyResultVo vo) {
		return dao.resultInsert(vo);
	}
	public int surveyInInsert(SurveyInVo vo) {
		return dao.surveyInInsert(vo);
	}
	////////////////////////////////////////////////////////////////////////////
	public int surveyDelete(int surveyNum) {
		return dao.surveyDelete(surveyNum);
	}
	public int surveyQuestionDelete(int surveyNum) {
		return dao.surveyQuestionDelete(surveyNum);
	}
	public int surveyVideoDelete(int svNum) {
		return dao.surveyVideoDelete(svNum);
	}
	
	
	
	///////////////////////////////////////////////////////////////////////////
	public int surveyUpdate(SurveyVo vo) {
		return dao.surveyUpdate(vo);
	}
	public int surveyStateUpdate(Map<String, Object> map) {
		return dao.surveyStateUpdate(map);
	}
	public int userPointUpdate(Map<String, Object> map) {
		return dao.userPointUpdate(map);
	}
	public int userPointUpdate1(Map<String, Object> map) {
		return dao.userPointUpdate1(map);
	}
	
	//////////////////////////////////////////////////////////////////////////
		
	
	public int surveyNumSelect(Map<String, Object> map) {
		return dao.surveyNumSelect(map);
	}
	public int sqNumSelect(Map<String, Object> map) {
		return dao.sqNumSelect(map);
	}
	public int joinCntSelect(int surveyNum) {
		return dao.joinCntSelect(surveyNum);
	}
	public int getTypeSelect(int sqNum) {
		return dao.getTypeSelect(sqNum);
	}	
	public UserVo userSelect(String userId) {
		return dao.userSelect(userId);
	}
	public int leftPoint(int surveyNum) {
		return dao.leftPoint(surveyNum);
	}
	//////////////////////////////////////////////////////////////////////////////
	public SurveyVo surveySelect(int surveyNum) {
		return dao.surveySelect(surveyNum);
	}
	public SurveyVideoVo surveyVideoSelect(int surveyNum) {
		return dao.surveyVideoSelect(surveyNum);
	}
	public SurveyInVo surveyInSelect(Map<String, Object> map) {
		return dao.surveyInSelect(map);
	}
	public List<Integer> surveyInSelect1(int userNum){
		return dao.surveyInSelect1(userNum);
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
	public List<SurveyVo> toUpdateSurveyVoSelect(){
		return dao.toUpdateSurveyVoSelect();
	}
	public List<SrCntDto> srAnswerCnt(int sqNum){
		return dao.srAnswerCnt(sqNum);
	}
	public List<SurveyResultVo> surveyResultSelect(int sqNum){
		return dao.surveyResultSelect(sqNum);
	}
	public int surveyInCnt(int surveyNum) {
		return dao.surveyInCnt(surveyNum);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	///////////////////////////////////////////////////////////////////////////////
}
