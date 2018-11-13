package com.jhta.netflix.content_comment.controller;

import java.util.HashMap;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.netflix.bookmark.service.BookmarkService;
import com.jhta.netflix.bookmark.vo.BookmarkVo;
import com.jhta.netflix.content_comment.service.Content_commentService;
import com.jhta.netflix.content_comment.vo.Comment_bookmarkVo;
import com.jhta.netflix.content_comment.vo.Content_commentVo;
import com.jhta.netflix.good.service.GoodService;
import com.jhta.netflix.good.vo.GoodVo;
import com.jhta.netflix.profile.service.ProfileService;
import com.jhta.netflix.profile.vo.ProfileUserVo;
import com.jhta.netflix.profile.vo.ProfileVo;

@Controller
public class Content_commentController {
	@Autowired
	private Content_commentService service;
	@Autowired
	private GoodService goodService;
	@Autowired
	private ProfileService profileService;
	@Autowired
	private BookmarkService bookmarkService;
	
	@RequestMapping(value="/comment/insert",produces="application/json;charset=utf-8")
	@ResponseBody
	public String insert(Content_commentVo vo,
			@RequestParam(value="bookmark_time",defaultValue="0")int bookmark_time) {
		JSONObject json = new JSONObject();
		try {
			int comment_num = service.getMax() + 1;
			vo.setComment_num(comment_num);
			int n = service.insert(vo);
			if(n>0) {
				if (vo.isBookmark()) {
					int n2 = bookmarkService.insert(new BookmarkVo(0, comment_num, bookmark_time));
					if(n2>0) {
						json.put("result", true);
					}else {
						json.put("result", false);
					}
				}else {
					json.put("result", true);
				}
			}else {
				json.put("result", false);
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
			json.put("result", false);
		}
		return json.toString();
	}
	@RequestMapping(value="/comment/list",produces="application/json;charset=utf-8")
	@ResponseBody
	public String list(int content_num,int profile_num,
			@RequestParam(value="sort",defaultValue="new")String sort,
			@RequestParam(value="rowNum",defaultValue="0")int rowNum) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("content_num", content_num);
		map.put("sort", sort);
		map.put("rowNum", rowNum*5);
		List<Comment_bookmarkVo> list= service.list(map);
		JSONArray arr = new JSONArray();
		for(Comment_bookmarkVo vo : list) {
			JSONObject json = new JSONObject();
			json.put("comment_num", vo.getComment_num());
			json.put("comment", vo.getComment());
			json.put("c_lev", vo.getC_lev());
			json.put("c_step", vo.getC_step());
			json.put("content_num", vo.getContent_num());
			json.put("profile_num", vo.getProfile_num());
			ProfileUserVo pvo = profileService.find(vo.getProfile_num());
			json.put("nickname", pvo.getNickname());
			json.put("comment_open", vo.isComment_open());
			json.put("bookmark", vo.isBookmark());
			json.put("bookmark_time", vo.getBookmark_time());
			json.put("good_count", goodService.count(vo.getComment_num()));
			HashMap<String, Object> subMap = new HashMap<String, Object>();
			subMap.put("comment_num", vo.getComment_num());
			subMap.put("profile_num", profile_num);
			GoodVo gvo = goodService.find(subMap);
			if(gvo != null) {
				json.put("good_check", true);
			}else {
				json.put("good_check", false);
			}
			arr.put(json);
		}
		return arr.toString();
	}
	@RequestMapping(value="/comment/subList",produces="application/json;charset=utf-8")
	@ResponseBody
	public String subList(int comment_num,int profile_num) {
		List<Content_commentVo> list= service.subList(comment_num);
		JSONArray arr = new JSONArray();
		for(Content_commentVo vo : list) {
			JSONObject json = new JSONObject();
			json.put("comment_num", vo.getComment_num());
			json.put("comment", vo.getComment());
			json.put("c_lev", vo.getC_lev());
			json.put("c_step", vo.getC_step());
			json.put("content_num", vo.getContent_num());
			json.put("profile_num", vo.getProfile_num());
			ProfileUserVo pvo = profileService.find(vo.getProfile_num());
			json.put("nickname", pvo.getNickname());
			json.put("comment_open", vo.isComment_open());
			json.put("bookmark", vo.isBookmark());
			json.put("good_count", goodService.count(vo.getComment_num()));
			HashMap<String, Object> subMap = new HashMap<String, Object>();
			subMap.put("comment_num", vo.getComment_num());
			subMap.put("profile_num", profile_num);
			GoodVo gvo = goodService.find(subMap);
			if(gvo != null) {
				json.put("good_check", true);
			}else {
				json.put("good_check", false);
			}
			arr.put(json);
		}
		return arr.toString();
	}
	@RequestMapping(value="/comment/count",produces="application/json;charset=utf-8")
	@ResponseBody
	public String count(int content_num) {
		JSONObject json = new JSONObject();
		json.put("count", service.count(content_num));
		return json.toString();
	}
}
