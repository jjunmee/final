package com.jhta.netflix.alarm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.alarm.dao.AlarmImpl;
import com.jhta.netflix.alarm.vo.AlarmVo;

@Service
public class Alarm {
	@Autowired private AlarmImpl dao;
	
	public int getCount(int profile_num) {
		return dao.getCount(profile_num);
	}
	public List<AlarmVo> getList(int profile_num){
		return dao.getList(profile_num);
	}
	public int update_state(int au_num) {
		return dao.update_state(au_num);
	}
}
