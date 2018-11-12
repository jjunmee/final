package com.jhta.netflix.grade.controller;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.netflix.grade.service.GradeService;
import com.jhta.netflix.grade.vo.GradeVo;

@Controller
public class GradeController {
	@Autowired
	private GradeService service;
	
	@RequestMapping(value="/grade/grade", method=RequestMethod.GET)
	public String gradePage() {
		return ".admin.grade";
	}
	
	//등급 등록
	@RequestMapping(value="/grade/insert",method=RequestMethod.POST)
	public ModelAndView insert(String grade_name,String grade_person,String grade_price) {
		String gradeName = grade_name + "-" + grade_person;
		GradeVo vo = new GradeVo(0,gradeName,grade_price);
		int n = service.insert(vo);
		ModelAndView mv = new ModelAndView();
		String result = ".admin.grade";
		if(n>0) {
			mv.addObject("code", "요청성공");
		}else {
			mv.addObject("code", "요청실패");
		}
		mv.setViewName(result);
		return mv;
	}
	
	//등급 리스트
	@RequestMapping(value="/grade/gradelist",produces="application/json;charset=utf-8")
	@ResponseBody
	public String gradelist() {
		List<GradeVo> list = service.list();
		JSONArray arr = new JSONArray();
		for(GradeVo vo : list) {
			JSONObject json = new JSONObject();
			String gradeName = vo.getGrade_name();
			String[] part = gradeName.split("-");
			json.put("grade_num", vo.getGrade_num());
			json.put("grade_name", part[0]);
			json.put("grade_person", part[1]);
			json.put("grade_price", vo.getGrade_price());
			arr.put(json);
		}
		return arr.toString();
	}
	
	//등급 수정폼
	@RequestMapping(value="/grade/updateForm",produces="application/json;charset=utf-8")
	@ResponseBody
	public String updateForm(int num) {
		GradeVo vo = service.selectone(num);
		JSONObject json = new JSONObject();
		String gradeName = vo.getGrade_name();
		String[] part = gradeName.split("-");
		json.put("grade_num", vo.getGrade_num());
		json.put("grade_name", part[0]);
		json.put("grade_person", part[1]);
		json.put("grade_price", vo.getGrade_price());
		return json.toString();
	}
	
	//등급 수정
	@RequestMapping(value="/grade/update",produces="application/json;charset=utf-8")
	@ResponseBody
	public String update(int grade_num,String grade_name,String grade_person,String grade_price) {
		String gradeName = grade_name + "-" + grade_person;
		GradeVo vo = new GradeVo(grade_num,gradeName,grade_price);
		int n = service.update(vo);
		JSONObject json = new JSONObject();
		if(n>0) {
			json.put("code", "수정성공");
		}else {
			json.put("code", "수정실패");
		}
		return json.toString();
	}
	
	//등급 삭제
	@RequestMapping(value="/grade/delete",produces="application/json;charset=utf-8")
	@ResponseBody
	public String delete(int num) {
		int n = service.delete(num);
		JSONObject json = new JSONObject();
		if(n>0) {
			json.put("code", "삭제성공");
		}else {
			json.put("code", "삭제실패");
		}
		return json.toString();
	}
}
