package com.jhta.netflix.chart.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.netflix.chart.service.ChartService;
import com.jhta.netflix.chart.vo.GnameCountVo;

@Controller
public class ChartController {
	@Autowired
	private ChartService service;
	
	@RequestMapping("/admin/paychart")
	public ModelAndView paychart() {
		ModelAndView mv = new ModelAndView();
		//4개월동안의 매출현황 가져오기
		for(int i=1; i<=4; i++) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("n1", 1);	map.put("n2", 2);
			int nextMonthTotal = service.nextMonthTotal(map);
			int limitNext = service.thisGradeCount();
			for(int n=0; n < limitNext; n++) {
				map.put("limitNext", n);
				GnameCountVo gradeNextNameCount = service.gradeNextNameCount(map);
				mv.addObject("gradeNextNameCount"+n, gradeNextNameCount);
			}
			mv.addObject("nextMonthTotal"+i,nextMonthTotal);
		}
		int limitThis = service.thisGradeCount();
		int thisMonthTotal = service.thisMonthTotal();
		for(int n=0; n < limitThis; n++) {
			GnameCountVo gradeThisNameCount = service.gradeThisNameCount(n);
			mv.addObject("gradeThisNameCount"+n, gradeThisNameCount);
		}
		mv.addObject("thisMonthTotal", thisMonthTotal);
		mv.setViewName(".admin.paychart");
		return mv;
	}
}
