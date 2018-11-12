package com.jhta.netflix.point_info.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.point_info.dao.Point_infoDao;
import com.jhta.netflix.point_info.vo.Point_infoVo;
import com.jhta.netflix.point_info.vo.User_pointVo;

@Service
public class Point_infoService {
	@Autowired
	private Point_infoDao dao;
	
	public int insert(Point_infoVo vo) {
		return dao.insert(vo);
	}
	
	public List<Point_infoVo> list(){
		return dao.list();
	}
	
	public Point_infoVo selectone(int num) {
		return dao.selectone(num);
	}
	
	public int delete(int num) {
		return dao.delete(num);
	}
	
	public List<User_pointVo> userpoint(int num){
		return dao.userpoint(num);
	}
	
	public int listCount(HashMap<String, Object> map) {
		return dao.listCount(map);
	}
}
