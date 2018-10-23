package com.jhta.netflix.survey.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SurveyDao {
	@Autowired private SqlSession session;
	private final static String NAMESPACE="mapper.SurveyMapper";
}
