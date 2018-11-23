package com.jhta.netflix.chart.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.chart.dao.ChartDao;
import com.jhta.netflix.chart.vo.GnameCountVo;

@Service
public class ChartService {
	@Autowired
	private ChartDao dao;
	
	public int thisMonthTotal() {
		return dao.thisMonthTotal();
	}
	public int nextMonthTotal(HashMap<String, Object> map) {
		return dao.nextMonthTotal(map);
	}
	public int mPayThisMonthSum() {
		return dao.mPayThisMonthSum();
	}
	public int mPayNextMonthSum(HashMap<String, Object> map) {
		return dao.mPayNextMonthSum(map);
	}
	public int pointThisMonthPay() {
		return dao.pointThisMonthPay();
	}
	public int pointNextMonthPay(HashMap<String, Object> map) {
		return dao.pointNextMonthPay(map);
	}
	public int pointMemThisMonthSum() {
		return dao.pointMemThisMonthSum();
	}
	public int pointMemNextMonthSum(HashMap<String, Object> map) {
		return dao.pointMemNextMonthSum(map);
	}
	public List<GnameCountVo> gradeThisNameCount() {
		return dao.gradeThisNameCount();
	}
	public List<GnameCountVo> gradeNextNameCount(HashMap<String, Object> map) {
		return dao.gradeNextNameCount(map);
	}
}
