package com.jhta.netflix.survey.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.survey.vo.SurveyAnswerVo;
import com.jhta.netflix.survey.vo.SurveyQuestionVo;
import com.jhta.netflix.survey.vo.SurveyVideoVo;
import com.jhta.netflix.survey.vo.SurveyVo;

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
	
	///////////////////////////////////////////////////////////////////
	
	public int surveyNumSelect(Map<String, Object> map) {
		return session.selectOne(NAMESPACE+".surveyNumSelect",map);
	}
	public int sqNumSelect(Map<String, Object> map) {
		return session.selectOne(NAMESPACE+".sqNumSelect",map);
	}
	public int userPointSelect(String userId) {
		return session.selectOne(NAMESPACE+".userPointSelect",userId);
	}
	
	///////////////////////////////////////////////////////////////////////
}
