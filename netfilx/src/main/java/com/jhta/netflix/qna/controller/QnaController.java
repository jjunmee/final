package com.jhta.netflix.qna.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.netflix.lib.PageUtil;
import com.jhta.netflix.qna.service.QnaService;
import com.jhta.netflix.qna.vo.QnaVo;
import com.jhta.netflix.qna_user.vo.Qna_userVo;
import com.jhta.netflix.user.service.UserService;
import com.jhta.netflix.user.vo.UserVo;

@Controller
public class QnaController {
	@Autowired
	private QnaService service;
	@Autowired
	private UserService uservice;
	
	//리스트 뿌리기
	@RequestMapping("/qna/list")
	public ModelAndView list(@RequestParam(value="pageNum",defaultValue="1")int pageNum,
			String field,String keyword,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		UserVo vo = new UserVo();
		String id = (String)session.getAttribute("id");
		String code = (String)session.getAttribute("code");
		session.removeAttribute("code");
		if(id != null && !(id.equals(""))) {
			vo = uservice.login(id);
			mv.addObject("userSts",vo.getSts());
		}else {
			mv.addObject("userSts",0);
		}
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
		List<Qna_userVo> list = service.list(map);
		//mv에 리스트 뿌려주기
		mv.addObject("code",code);
		mv.addObject("list",list);
		mv.addObject("pu",pu);
		mv.addObject("field", field);
		mv.addObject("keyword", keyword);
		mv.setViewName(result);
		return mv;
	}
	
	//글 상세보기
	@RequestMapping(value="/qna/detail",method=RequestMethod.GET)
	public ModelAndView detail(int qna_num,boolean qna_open,HttpSession session) {
		Qna_userVo vo = service.detail(qna_num);
		String id = (String)session.getAttribute("id");
		ModelAndView mv = new ModelAndView();
		UserVo uvo = uservice.login(id);
		Qna_userVo u_vo = new Qna_userVo();
		if(vo.getStep() != 0) {
			//답글일때 답글에 대한 문의 글을 불러와서
			u_vo = service.detail(vo.getLev());
			//문의를 쓴 사람과 같지 않을때
			if(qna_open == false && (id == null  || !(id.equals(u_vo.getId())) && uvo.getSts() != 1)) {
				session.setAttribute("code", "비공개");
				System.out.println("비공개 입니다");
				mv.setViewName("redirect:/qna/list");
				return mv;
			}
		} else if(qna_open == false && (id == null  || !(id.equals(vo.getId())) && uvo.getSts() != 1)) {
			//새글이 비공개일때
			session.setAttribute("code", "비공개");
			System.out.println("비공개 입니다");
			mv.setViewName("redirect:/qna/list");
			return mv;
		}
		if(id != null && !(id.equals(""))) {
			uvo = uservice.login(id);
			mv.addObject("userSts",uvo.getSts());
			mv.addObject("userId",id);
		}else {
			mv.addObject("userSts",0);
		}
		String result = ".qna.detail";
		//내가 쓴 글
		mv.addObject("qna_num",vo.getQna_num());
		mv.addObject("qna_title",vo.getQna_title());
		mv.addObject("qna_content",vo.getQna_content());
		mv.addObject("qna_regdate",vo.getQna_regdate());
		mv.addObject("qna_open",vo.getQna_open());
		mv.addObject("step",vo.getStep());
		mv.addObject("qna_id",vo.getId());
		mv.addObject("qna_state",vo.getQna_state());
		if(vo.getStep() == 0) {
			//유저가 남긴 글중 답변이 완료된것은 같이 보내기
			if(vo.getQna_state().equals("답변완료")) {
				Qna_userVo a_vo = service.a_detail(qna_num);
				mv.addObject("a_qna_num",a_vo.getQna_num());
				mv.addObject("a_qna_content",a_vo.getQna_content());
				mv.addObject("a_qna_regdate",a_vo.getQna_regdate());
			}
		}else {
			//답글일때
			//user가 쓴 글 같이 보내기
			u_vo = service.detail(vo.getLev());
			mv.addObject("u_qna_content",u_vo.getQna_content());
			mv.addObject("u_qna_num",u_vo.getQna_num());
		}
		mv.setViewName(result);
		return mv;
	}
	
	//글수정폼으로 보내기
	@RequestMapping(value="/qna/update",method=RequestMethod.GET)
	public ModelAndView update(int qna_num,boolean qna_open) {
		ModelAndView mv = new ModelAndView();
		String result = ".qna.update";
		Qna_userVo vo = service.detail(qna_num);
		mv.addObject("qna_num",vo.getQna_num());
		mv.addObject("qna_title",vo.getQna_title());
		mv.addObject("qna_content",vo.getQna_content());
		mv.addObject("qna_regdate",vo.getQna_regdate());
		mv.addObject("qna_open",vo.getQna_open());
		mv.addObject("step",vo.getStep());
		mv.addObject("id",vo.getId());
		mv.addObject("qna_state",vo.getQna_state());
		if(vo.getStep() != 0) {
			//답글이라면 같이 보낼 문의 글
			Qna_userVo u_vo = service.detail(vo.getLev());
			mv.addObject("u_qna_content",u_vo.getQna_content());
			mv.addObject("u_qna_num",u_vo.getQna_num());
		}
		mv.setViewName(result);
		return mv;
	}
	
	//글 등록 폼으로 보내기(새글 & 답변)
	@RequestMapping(value="/qna/insert",method=RequestMethod.GET)
	public ModelAndView insertform(@RequestParam(value="qna_num",defaultValue="0")int qna_num) {
		ModelAndView mv = new ModelAndView();
		String result = "";
		if(qna_num != 0) {
			//답변 등록
			Qna_userVo vo = service.detail(qna_num);
			mv.addObject("qna_num",vo.getQna_num());
			mv.addObject("qna_title",vo.getId() + "님 답변입니다.");
			mv.addObject("qna_content",vo.getQna_content());
			mv.addObject("qna_regdate",vo.getQna_regdate());
			mv.addObject("qna_open",vo.getQna_open());
			mv.addObject("id",vo.getId());
		}else {
			//새글 등록
			mv.addObject("qna_num",qna_num);
		}
		result = ".qna.insert";
		mv.setViewName(result);
		return mv;
	}
	
	//DB에 글 저장하기
	@RequestMapping(value="/qna/insert",method=RequestMethod.POST)
	public ModelAndView insert(String qna_title,String qna_content,Boolean qna_open,int qna_num,HttpSession session) {
		//String id는 로그인되면 세션에서 가져와서 users_num찾아서 넣어줄꺼야
		String id = (String)session.getAttribute("id");
		UserVo uvo = uservice.login(id);
		int users_num = uvo.getUsersNum();
		ModelAndView mv = new ModelAndView();
		QnaVo vo = new QnaVo();
		String result = "";
		int lev = 0;
		int step = 0;
		int maxnum = service.maxnum() + 1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(qna_num != 0) {
			//답글일때 lev값을 답변할글번호와 동일하게 함(어떤글에 대한 답변인지), step을 1 올려준다(step으로 답변인지 새글인지 확인)
			lev = qna_num;
			step += 1;
			vo = new QnaVo(maxnum,qna_title,qna_content,null,qna_open,lev,step,users_num,"답변");
			map.put("qna_num", qna_num);
			map.put("qna_state", "답변완료");
			service.update(map);
		}else {
			//새글일때 lev값과 글번호를 동일하게
			lev = maxnum;
			vo = new QnaVo(maxnum,qna_title,qna_content,null,qna_open,lev,step,users_num,"답변대기");
		}
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
	
	//수정DB에 저장
	@RequestMapping(value="/qna/update",method=RequestMethod.POST)
	public ModelAndView update(String qna_title,String qna_content,Boolean qna_open,String id,int qna_num) {
		//String id는 로그인되면 세션에서 가져와서 users_num찾아서 넣어줄꺼야
		int users_num = 1;
		ModelAndView mv = new ModelAndView();
		QnaVo vo = new QnaVo();
		String result = "";
		vo = new QnaVo(qna_num,qna_title,qna_content,null,qna_open,null,null,users_num,null);
		int n = service.update(vo);
		if(n>0) {
			result = "redirect:/qna/list";
		}else {
			mv.addObject("code","등록실패");
			result = "redirect:/qna/update";
		}
		mv.setViewName(result);
		return mv;
	}
	
	//글 삭제
	@RequestMapping(value="/qna/delete",method=RequestMethod.GET)
	public ModelAndView delete(int qna_num, int step) {
		ModelAndView mv = new ModelAndView();
		String result = "";
		int n = 0;
		Qna_userVo vo = service.detail(qna_num);
		if(step != 1) {
			//새글 삭제
			if(vo.getQna_state().equals("답변완료")) {
				//답글이 있을때
				Qna_userVo a_vo = service.a_detail(qna_num);
				int n1 = service.delete(qna_num);
				int n2 = service.delete(a_vo.getQna_num());
				if(n1 > 0 && n2 > 0) {
					result = "redirect:/qna/list";
				}else {
					mv.addObject("code","삭제실패");
					result = "redirect:/qna/list";
				}
				mv.setViewName(result);
				return mv;
			}else {
				//답글이 없을때
				n = service.delete(qna_num);
				if(n > 0) {
					result = "redirect:/qna/list";
				}else {
					mv.addObject("code","삭제실패");
					result = "redirect:/qna/list";
				}
			}
		}else {
			//답변 삭제
			Qna_userVo a_vo = service.detail(qna_num);
			int lev = vo.getLev();
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("qna_num", lev);
			map.put("qna_state", "답변대기");
			service.update(map);
			n = service.delete(qna_num);
			if(n > 0) {
				result = "redirect:/qna/list";
			}else {
				mv.addObject("code","삭제실패");
				result = "redirect:/qna/list";
			}
		}
		mv.setViewName(result);
		return mv;
	}
	
	@RequestMapping(value="/qna/chat",method=RequestMethod.GET)
	public ModelAndView chat() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName(".qna.chat");
		
		//유저 아이디 넘기기
		//mv.addObject("userid", user.getUsername())
		
		return mv;
	}
	
}
