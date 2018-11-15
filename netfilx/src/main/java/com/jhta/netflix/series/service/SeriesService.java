package com.jhta.netflix.series.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.series.dao.SeriesDao;
import com.jhta.netflix.series.vo.SeriesVo;

@Service
public class SeriesService {
	@Autowired
	private SeriesDao dao;
	
	public int insert(SeriesVo vo) {
		return dao.insert(vo);
	}
	public int update(SeriesVo vo) {
		return dao.update(vo);
	}
	public int delete(int num) {
		return dao.delete(num);
	}
	public List<SeriesVo> list(HashMap<String, Object> map){
		return dao.list(map);
	}
	public SeriesVo find(int num) {
		return dao.find(num);
	}
	public int count(String keyword) {
		return dao.count(keyword);
	}
}
