package com.jhta.netflix.alarm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.netflix.alarm.service.Alarm;
import com.jhta.netflix.alarm.vo.AlarmVo;

@Controller
public class AlarmController {
	@Autowired private  Alarm alarm;
	
	//읽지 않은 알람수
	@RequestMapping(value="/alarm/count")
	public String alarm(HttpSession session) {
		int profile_num = (Integer)session.getAttribute("profile_num");
		int row = alarm.getCount(profile_num);
		if(row>5) {
			row = 5;
		}
		session.setAttribute("alarm_count", row);
		return "redirect:/content/userView?profile_num="+profile_num;
	}
	
	@RequestMapping(value="/alarm/list",method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getLsit(HttpSession session){
		int profile_num = (Integer)session.getAttribute("profile_num");
		Map<String, Object> map = new HashMap<String, Object>();
		List<AlarmVo> list = alarm.getList(profile_num);
		map.put("alarm_list", list);
		return map;
	}
	
	@RequestMapping(value="/alarm/content",method=RequestMethod.GET)
	public String au_update(@RequestParam("content_num")String content_num,@RequestParam("au_num")String au_num,HttpSession session) {
		int u_num = Integer.parseInt(au_num);
		int row = alarm.update_state(u_num);
		if(row>0) {
			int s_row = (Integer)session.getAttribute("alarm_count");
			if(s_row>0) {
				session.setAttribute("alarm_count", s_row-1);
			}
		}
		return "redirect:/content/contentPlay?content_num="+content_num;
	}
}
