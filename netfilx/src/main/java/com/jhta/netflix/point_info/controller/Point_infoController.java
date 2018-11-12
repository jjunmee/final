package com.jhta.netflix.point_info.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.netflix.lib.PageUtil;
import com.jhta.netflix.point_info.service.Point_infoService;
import com.jhta.netflix.point_info.vo.Point_infoVo;
import com.jhta.netflix.point_info.vo.User_pointVo;
import com.jhta.netflix.user.service.UserService;
import com.jhta.netflix.user.vo.UserVo;

@Controller
public class Point_infoController {
	@Autowired
	private Point_infoService service;
	@Autowired
	private UserService uservice;
	
	//충전페이지로 보내기
	@RequestMapping(value="/point/fill",method=RequestMethod.GET)
	public String fillform() {
		return ".point.fill";
	}
	
	//충전금액 update, 포인트내역 insert
	@RequestMapping(value="/point/fill",method=RequestMethod.POST)
	public String fill(int pointPrice,HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String result = null;
		String id = (String)session.getAttribute("id");
		UserVo uvo = uservice.userInfo(id);
		int users_num = uvo.getUsersNum();
		String usage = "포인트충전-충전-" + pointPrice;
		String point_payment = "card";
		int point = uvo.getPoint() + pointPrice;
		System.out.println("usage" + usage + "point_payment" + point_payment + "users_num" + users_num);
		Point_infoVo vo = new Point_infoVo(0,null,usage,point_payment,users_num);
		int n = service.insert(vo);
		if(n > 0) {
			map.put("point", point);
			map.put("users_num", users_num);
			uservice.pointUpdate(map);
			result = ".point.fillOk";
		}else {
			result = ".point.fillErr";
		}
		return result;
	}
	
	@RequestMapping("/point/userInfo")
	public ModelAndView infolist(@RequestParam(value="pageNum",defaultValue="1")int pageNum,String field,String keyword,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		String id = (String)session.getAttribute("id");
		UserVo uvo = uservice.userInfo(id);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("field", field);
		map.put("keyword", keyword);
		// V 인덱스 갯수 가져오기
		int totalRowCount = service.listCount(map);
		// 페이징처리할 함수 넘겨주기
		PageUtil pu = new PageUtil(pageNum,totalRowCount,10,10);
		//pageUtil에서 넘어온값 가져와서 넣어주기
		map.put("startRow", pu.getMysqlStartRow());
		map.put("rowBlockCount", pu.getRowBlockCount());
		List<User_pointVo> list = service.userpoint(uvo.getUsersNum());
		mv.addObject("list", list);
		mv.addObject("pu", pu);
		mv.addObject("field", field);
		mv.addObject("keyword", keyword);
		return mv;
	}
}
