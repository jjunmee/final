package com.jhta.netflix.survey.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.survey.vo.SurveyAnswerVo;
import com.jhta.netflix.survey.vo.SurveyInVo;
import com.jhta.netflix.survey.vo.SurveyQuestionVo;
import com.jhta.netflix.survey.vo.SurveyResultVo;
import com.jhta.netflix.survey.vo.SurveyVideoVo;
import com.jhta.netflix.survey.vo.SurveyVo;
import com.jhta.netflix.user.vo.UserVo;

@Repository
public class SurveyDao {
	@Autowired private SqlSession session;
	private final static String NAMESPACE="mapper.SurveyMapper";
	
	public int surveyInsert(SurveyVo vo) {
		return session.insert(NAMESPACE+".surveyInsert",vo);
	}
	public int surveyQuestionInsert(SurveyQuestionVo vo) {
		return session.insert(NAMESPACE+".surveyQuestionInsert",vo);
	}
	public int surveyAnswerInsert(SurveyAnswerVo vo) {
		return session.insert(NAMESPACE+".surveyAnswerInsert",vo);
	}
	public int surveyVideoInsert(SurveyVideoVo vo) {
		return session.insert(NAMESPACE+".surveyVideoInsert",vo);
	}
	public int resultInsert(SurveyResultVo vo) {
		return session.insert(NAMESPACE+".resultInsert",vo);
	}
	public int surveyInInsert(SurveyInVo vo) {
		return session.insert(NAMESPACE+".surveyInInsert",vo);
	}
	//////////////////////////////////////////////////////////////////
	public int surveyDelete(int surveyNum) {
		return session.delete(NAMESPACE+".surveyDelete",surveyNum);
	}
	//////////////////////////////////////////////////////////////////
	public int surveyUpdate(SurveyVo vo) {
		return session.update(NAMESPACE+".surveyUpdate",vo);
	}
	public int surveyStateUpdate(Map<String, Object> map) {
		return session.update(NAMESPACE+".surveyStateUpdate",map);
	}
	public int userPointUpdate(Map<String, Object> map) {
		return session.update(NAMESPACE+".userPointUpdate",map);
	}
	public int userPointUpdate1(Map<String, Object> map) {
		return session.update(NAMESPACE+".userPointUpdate1",map);
	}
	///////////////////////////////////////////////////////////////////
	
	public int surveyNumSelect(Map<String, Object> map) {
		return session.selectOne(NAMESPACE+".surveyNumSelect",map);
	}
	public int sqNumSelect(Map<String, Object> map) {
		return session.selectOne(NAMESPACE+".sqNumSelect",map);
	}
	public int joinCntSelect(int surveyNum) {
		return session.selectOne(NAMESPACE+".joinCntSelect",surveyNum);
	}
	public int getTypeSelect(int sqNum) {
		return session.selectOne(NAMESPACE+".getTypeSelect",sqNum);
	}
	public UserVo userSelect(String userId) {
		return session.selectOne(NAMESPACE+".userSelect",userId);
	}
	
	///////////////////////////////////////////////////////////////////////
	public SurveyVo surveySelect(int surveyNum) {
		return session.selectOne(NAMESPACE+".surveySelect",surveyNum);
	}
	public SurveyVideoVo surveyVideoSelect(int surveyNum) {
		return session.selectOne(NAMESPACE+".surveyVideoSelect",surveyNum);
	}
	public SurveyInVo surveyInSelect(Map<String, Object> map) {
		return session.selectOne(NAMESPACE+".surveyInSelect",map);
	}
	public List<SurveyQuestionVo> surveyQuestionSelect(int surveyNum) {
		return session.selectList(NAMESPACE+".surveyQuestionSelect",surveyNum);
	}
	public List<SurveyAnswerVo> surveyAnswerSelect(int sqNum) {
		return session.selectList(NAMESPACE+".surveyAnswerSelect",sqNum);
	}
	public List<SurveyVo> surveyListSelect(Map<String, Object> map){
		return session.selectList(NAMESPACE+".surveyListSelect",map);
	}
	public List<SurveyVo> mySurveyListSelect(Map<String, Object> map){
		return session.selectList(NAMESPACE+".mySurveyListSelect",map);
	}
	public int listCountSelect(Map<String, Object> map) {
		return session.selectOne(NAMESPACE+".listCountSelect",map);
	}
	
	
	
	
	
	
	
	
	
	
	///////////////////////////////////////////////////////////////////////
}
