package com.jhta.netflix.point_info.controller;

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
import com.jhta.netflix.pay_info.vo.Pay_infoVo;
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
	@Autowired
	private GradeService gservice;
	@Autowired
	private Pay_infoService paservice;
	
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
	public ModelAndView infolist(@RequestParam(value="pageNum",defaultValue="1")int pageNum,String keyword,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		String id = (String)session.getAttribute("id");
		UserVo uvo = uservice.userInfo(id);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("users_num", uvo.getUsersNum());
		map.put("keyword", keyword);
		// V 인덱스 갯수 가져오기
		int totalRowCount = service.listCount(map);
		// 페이징처리할 함수 넘겨주기
		PageUtil pu = new PageUtil(pageNum,totalRowCount,10,10);
		//pageUtil에서 넘어온값 가져와서 넣어주기
		map.put("startRow", pu.getMysqlStartRow());
		map.put("rowBlockCount", pu.getRowBlockCount());
		List<User_pointVo> list = service.userpoint(map);
		/*if(list != null) {*/
			mv.addObject("list", list);
			mv.addObject("pu", pu);
			mv.addObject("keyword", keyword);
			mv.setViewName(".point.userInfo");
		/*}else {
			Pay_infoVo pavo = paservice.selectone(uvo.getUsersNum());
			if(pavo != null) {
				//결제한게 있느냐 있으면
				Calendar cal = Calendar.getInstance();
				Date today = new Date(cal.getTimeInMillis());
				Date pay_end = pavo.getPay_end();
				long today_d = today.getTime();
				long pay_end_d = pay_end.getTime();
				GradeVo gvo = gservice.selectone(pavo.getGrade_num());
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
		}*/
		return mv;
	}
}
