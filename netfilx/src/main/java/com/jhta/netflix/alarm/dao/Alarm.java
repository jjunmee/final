package com.jhta.netflix.alarm.dao;

import java.util.List;

import com.jhta.netflix.alarm.vo.AlarmVo;

public interface Alarm {
	public List<AlarmVo> getCount(int profile_num);
	public List<AlarmVo> getList(int profile_num);
	public int update_state(int au_num);
}
