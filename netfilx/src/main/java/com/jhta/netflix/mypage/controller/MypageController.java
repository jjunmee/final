package com.jhta.netflix.mypage.controller;

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

import com.jhta.netflix.bookmark.service.BookmarkService;
import com.jhta.netflix.bookmark.vo.BookmarkVo;
import com.jhta.netflix.content_comment.service.Content_commentService;
import com.jhta.netflix.content_comment.vo.Content_commentVo;
import com.jhta.netflix.content_comment.vo.Mypage_commentVo;
import com.jhta.netflix.grade.service.GradeService;
import com.jhta.netflix.grade.vo.GradeVo;
import com.jhta.netflix.lib.PageUtil;
import com.jhta.netflix.pay_info.service.Pay_infoService;
import com.jhta.netflix.pay_info.vo.Pay_infoVo;
import com.jhta.netflix.user.service.UserService;
import com.jhta.netflix.user.vo.UserVo;

@Controller
public class MypageController {
	@Autowired
	private UserService service;
	@Autowired
	private Pay_infoService paservice;
	@Autowired
	private GradeService gservice;
	@Autowired
	private Content_commentService ccservice;
	@Autowired
	private UserService uservice;
	@Autowired
	private BookmarkService bservice;
	
	@RequestMapping(value="/mypage/myinfo",method=RequestMethod.GET)
	public ModelAndView userinfo(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		String id = (String)session.getAttribute("id");
		UserVo vo = service.userInfo(id);
		Pay_infoVo pavo = paservice.selectone(vo.getUsersNum());
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
		mv.addObject("birth", vo.getBirth());
		mv.addObject("point", vo.getPoint());
		mv.setViewName(".mypage.myinfo");
		return mv;
	}
	
	@RequestMapping("/mypage/commentlist")
	public ModelAndView commentlist(@RequestParam(value="pageNum",defaultValue="1")int pageNum,HttpSession session,
			String comment_true, String comment_false, String bookmark_true, String bookmark_false) {
		ModelAndView mv = new ModelAndView();
		int profile_num = (Integer)session.getAttribute("profile_num");
		System.out.println("profile_num=================" + profile_num);
		String id = (String)session.getAttribute("id");
		UserVo uvo = uservice.userInfo(id);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("profile_num", profile_num);
		if(comment_false == null && comment_true == null) {
			map.put("comment_open", null);
		}else if(comment_false == null && comment_true.equals("true")) {
			map.put("comment_open", true);
		}else if(comment_true == null && comment_false.equals("false")) {
			map.put("comment_open", false);
		}else {
			map.put("comment_open", null);
		}
		if(bookmark_false == null && bookmark_true == null) {
			map.put("bookmark", null);
		}else if(bookmark_false == null && bookmark_true.equals("true")) {
			map.put("bookmark", true);
		}else if(bookmark_true == null && bookmark_false.equals("false")) {
			map.put("bookmark", false);
		}else {
			map.put("bookmark", null);
		}
		int totalRowCount = ccservice.userCoCount(map);
		PageUtil pu = new PageUtil(pageNum,totalRowCount,10,10);
		map.put("startRow",pu.getMysqlStartRow());
		map.put("rowBlockCount", pu.getRowBlockCount());
		List<Mypage_commentVo> list = ccservice.userCoList(map);
		if(list != null) {
			mv.addObject("list",list);
			mv.addObject("pu",pu);
			if(comment_false == null && comment_true == null) {
				mv.addObject("comment_open", null);
			}else if(comment_false == null && comment_true.equals("true")) {
				mv.addObject("comment_open", true);
				System.out.println("comment_open ============ true");
			}else if(comment_true == null && comment_false.equals("false")) {
				mv.addObject("comment_open", false);
				System.out.println("comment_open ============ false");
			}else {
				mv.addObject("comment_open", null);
				System.out.println("comment_open ============ null");
			}
			if(bookmark_false == null && bookmark_true == null) {
				mv.addObject("bookmark", null);
			}else if(bookmark_false == null && bookmark_true.equals("true")) {
				mv.addObject("bookmark", true);
				System.out.println("bookmark ============ true");
			}else if(bookmark_true == null && bookmark_false.equals("false")) {
				mv.addObject("bookmark", false);
				System.out.println("bookmark ============ false");
			}else {
				mv.addObject("bookmark", null);
				System.out.println("bookmark ============ null");
			}
			mv.setViewName(".mypage.commentlist");
		}else {
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
		}
		return mv;
	}
}
