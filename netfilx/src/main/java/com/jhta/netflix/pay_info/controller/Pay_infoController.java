package com.jhta.netflix.pay_info.controller;

import java.sql.Date;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.netflix.grade.service.GradeService;
import com.jhta.netflix.grade.vo.GradeVo;
import com.jhta.netflix.lib.PageUtil;
import com.jhta.netflix.pay_info.service.Pay_infoService;
import com.jhta.netflix.pay_info.vo.Pay_gradeVo;
import com.jhta.netflix.pay_info.vo.Pay_infoVo;
import com.jhta.netflix.point_info.service.Point_infoService;
import com.jhta.netflix.point_info.vo.Point_infoVo;
import com.jhta.netflix.user.service.UserService;
import com.jhta.netflix.user.vo.UserVo;

@Controller
public class Pay_infoController {
	@Autowired
	private Pay_infoService service;
	@Autowired
	private UserService uservice;
	@Autowired
	private Point_infoService pservice;
	@Autowired
	private GradeService gservice;
	
	@RequestMapping(value="/pay/payform",method=RequestMethod.GET)
	public ModelAndView payform(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		String id = (String)session.getAttribute("id");
		UserVo uvo = uservice.userInfo(id);
		mv.addObject("userPoint", uvo.getPoint());
		mv.setViewName(".pay.payform");
		return mv;
	}
	
	@RequestMapping(value="/pay/payment",method=RequestMethod.POST)
	public ModelAndView payment(HttpSession session,@RequestParam(value="pointPrice",defaultValue="-1")int pointPrice,@RequestParam(value="cardPrice",defaultValue="-1")int cardPrice, int grade_num) {
		ModelAndView mv = new ModelAndView();
		String id = (String)session.getAttribute("id");
		UserVo uvo = uservice.userInfo(id);
		Point_infoVo pvo = new Point_infoVo();
		//pay_info insert
		String payment = "";
		String result = "";
		if(pointPrice > 0 && cardPrice > 0) {
			payment = "point + card";
			//point_info insert
			pvo = new Point_infoVo(0,null,"멤버십결제-사용-" + pointPrice,"point",uvo.getUsers_num());
		}else if(pointPrice > 0 && cardPrice < 0) {
			payment = "point";
			//point_info insert
			pvo = new Point_infoVo(0,null,"멤버십결제-사용-" + pointPrice,"point",uvo.getUsers_num());
		}else if(pointPrice < 0 && cardPrice > 0) {
			payment = "card";
		}
		Pay_infoVo vo = new Pay_infoVo(0,null,null,payment,uvo.getUsers_num(),grade_num);
		int n = service.insert(vo);
		if(n > 0) {
			//user point update
			HashMap<String, Object> map = new HashMap<String, Object>();
			int userPoint = uvo.getPoint() - pointPrice;
			map.put("point", userPoint);
			map.put("users_num", vo.getUsers_num());
			uservice.pointUpdate(map);
			pservice.insert(pvo);
			result = ".pay.payOk";
		}else {
			mv.addObject("code", "요청실패");
			result = ".pay.payErr";
		}
		mv.setViewName(result);
		return mv;
	}
	
	@RequestMapping("/pay/userInfo")
	public ModelAndView infolist(@RequestParam(value="pageNum",defaultValue="1")int pageNum,String keyword,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		String id = (String)session.getAttribute("id");
		UserVo uvo = uservice.userInfo(id);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("users_num", uvo.getUsers_num());
		map.put("keyword", keyword);
		int totalRowCount = service.listCount(map);
		PageUtil pu = new PageUtil(pageNum,totalRowCount,10,10);
		map.put("startRow",pu.getMysqlStartRow());
		map.put("rowBlockCount", pu.getRowBlockCount());
		List<Pay_gradeVo> list = service.userselect(map);
		if(list != null) {
			mv.addObject("list", list);
			mv.addObject("pu", pu);
			mv.addObject("keyword", keyword);
			mv.setViewName(".pay.userInfo");
		}else {
			Pay_infoVo vo = service.selectone(uvo.getUsers_num());
			if(vo != null) {
				//결제한게 있느냐 있으면
				Calendar cal = Calendar.getInstance();
				Date today = new Date(cal.getTimeInMillis());
				Date pay_end = vo.getPay_end();
				long today_d = today.getTime();
				long pay_end_d = pay_end.getTime();
				GradeVo gvo = gservice.selectone(vo.getGrade_num());
				//만료일이 남아있느냐 있으면
				if(pay_end_d >= today_d) {
					String gradeName = gvo.getGrade_name();
					String[] part = gradeName.split("-");
					mv.addObject("grade_name", part[0]);
					mv.addObject("grade_person", part[1]);
					mv.addObject("pay_end", pay_end);
				}
			}
			mv.addObject("pwd", uvo.getPwd());
			mv.addObject("birth", uvo.getBirth());
			mv.addObject("point", uvo.getPoint());
			mv.addObject("code", "포인트 내역이 없습니다.");
			mv.setViewName(".mypage.myinfo");
		}
		return mv;
	}
	
}
