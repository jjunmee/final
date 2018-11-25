package com.jhta.netflix.alarm.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jhta.netflix.alarm.vo.AlarmVo;

@Repository
public class AlarmImpl implements Alarm {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE = "mapper.Alarm";
	@Override
	public List<AlarmVo> getCount(int profile_num) {
		return sqlSession.selectList(NAMESPACE+".getCount",profile_num);
	}

	@Override
	public List<AlarmVo> getList(int profile_num) {
		return sqlSession.selectList(NAMESPACE+".getList", profile_num);
	}

	@Override
	public int update_state(int au_num) {
		return sqlSession.update(NAMESPACE+".state", au_num);
	}
}
