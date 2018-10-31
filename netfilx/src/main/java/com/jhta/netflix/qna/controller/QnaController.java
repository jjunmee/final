package com.jhta.netflix.qna.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.netflix.qna.service.QnaService;
import com.jhta.netflix.qna.vo.QnaVo;

@Controller
public class QnaController {
	@Autowired
	private QnaService service;
	
	@RequestMapping(value="/qna/list",method=RequestMethod.GET)
	public String list() {
		return ".qna.list";
	}
	
	@RequestMapping(value="/qna/insert",method=RequestMethod.GET)
	public String insertform() {
		return ".qna.insert";
	}
	
	@RequestMapping(value="/qna/insert",method=RequestMethod.POST)
	public ModelAndView insert(String qna_title,String qna_content,Boolean open,String id,int qna_num) {
		//String id는 로그인되면 세션에서 가져와서 users_num찾아서 넣어줄꺼야
		int users_num = 1;
		ModelAndView mv = new ModelAndView();
		QnaVo vo = new QnaVo();
		String result = "";
		int lev = 0;
		int step = 0;
		int maxnum = service.maxnum() + 1;
		System.out.println("qna_num 는 뭐냐면 = " + qna_num);
		if(qna_num != 0) {
			lev = qna_num;
			step += 1;
			vo = new QnaVo(maxnum,qna_title,qna_content,null,open,lev,step,users_num);
		}else {
			lev = maxnum;
			vo = new QnaVo(maxnum,qna_title,qna_content,null,open,lev,step,users_num);
			System.out.println("새글 등록");
		}
		System.out.println("vo에 담을꺼야");
		int n = service.insert(vo);
		System.out.println("vo에 담았어!!");
		if(n>0) {
			result = ".qna.list";
		}else {
			result = "redirect:/";
			mv.addObject("code","등록실패");
		}
		mv.setViewName(result);
		return mv;
	}
}
