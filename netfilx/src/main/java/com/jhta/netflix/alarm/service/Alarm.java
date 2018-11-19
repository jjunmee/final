package com.jhta.netflix.alarm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.alarm.dao.AlarmImpl;

@Service
public class Alarm {
	@Autowired private AlarmImpl dao;
}
