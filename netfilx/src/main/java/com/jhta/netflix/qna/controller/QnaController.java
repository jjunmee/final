package com.jhta.netflix.qna.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.netflix.lib.PageUtil;
import com.jhta.netflix.qna.service.QnaService;
import com.jhta.netflix.qna.vo.QnaVo;

@Controller
public class QnaController {
	@Autowired
	private QnaService service;
	
	@RequestMapping("/qna/list")
	public ModelAndView list(@RequestParam(value="pageNum",defaultValue="1")int pageNum,
			String field,String keyword) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String result = ".qna.list";
		map.put("field", field);
		map.put("keyword", keyword);
		// V 인덱스 갯수 가져오기
		int totalRowCount = service.listCount(map);
		// 페이징처리할 함수 넘겨주기
		PageUtil pu = new PageUtil(pageNum,totalRowCount,10,10);
		//pageUtil에서 넘어온값 가져와서 넣어주기
		map.put("startRow", pu.getMysqlStartRow());
		map.put("rowBlockCount", pu.getRowBlockCount());
		List<QnaVo> list = service.list(map);
		//mv에 리스트 뿌려주기
		ModelAndView mv = new ModelAndView();
		mv.addObject("list",list);
		mv.addObject("pu",pu);
		mv.addObject("field", field);
		mv.addObject("keyword", keyword);
		mv.setViewName(result);
		return mv;
	}
	
	@RequestMapping(value="/qna/insert",method=RequestMethod.GET)
	public ModelAndView insertform(@RequestParam(value="qna_num",defaultValue="0")int qna_num) {
		ModelAndView mv = new ModelAndView();
		String result = "";
		mv.addObject("qna_num",qna_num);
		result = ".qna.insert";
		mv.setViewName(result);
		return mv;
	}
	
	@RequestMapping(value="/qna/insert",method=RequestMethod.POST)
	public ModelAndView insert(String qna_title,String qna_content,Boolean qna_open,String id,int qna_num) {
		//String id는 로그인되면 세션에서 가져와서 users_num찾아서 넣어줄꺼야
		int users_num = 1;
		ModelAndView mv = new ModelAndView();
		QnaVo vo = new QnaVo();
		String result = "";
		int lev = 0;
		int step = 0;
		int maxnum = service.maxnum() + 1;
		if(qna_num != 0) {
			lev = qna_num;
			step += 1;
			vo = new QnaVo(maxnum,qna_title,qna_content,null,qna_open,lev,step,users_num);
		}else {
			lev = maxnum;
			vo = new QnaVo(maxnum,qna_title,qna_content,null,qna_open,lev,step,users_num);
		}
		//여기부터 안됨
		int n = service.insert(vo);
		if(n>0) {
			result = "redirect:/qna/list";
		}else {
			mv.addObject("code","등록실패");
			result = "redirect:/qna/insert";
		}
		mv.setViewName(result);
		return mv;
	}
	
}
