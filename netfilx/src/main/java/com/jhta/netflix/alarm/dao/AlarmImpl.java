package com.jhta.netflix.alarm.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AlarmImpl implements Alarm {
	@Autowired
	private SqlSession sqlSession;
}
