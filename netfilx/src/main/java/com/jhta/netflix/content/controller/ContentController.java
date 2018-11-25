package com.jhta.netflix.content.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jhta.netflix.bookmark.service.BookmarkService;
import com.jhta.netflix.content.service.ContentService;
import com.jhta.netflix.content.vo.ContentVo;
import com.jhta.netflix.content_comment.service.Content_commentService;
import com.jhta.netflix.content_comment.vo.Content_commentVo;
import com.jhta.netflix.content_genre.service.Content_genreService;
import com.jhta.netflix.content_genre.vo.Content_genreVo;
import com.jhta.netflix.content_staff.service.Content_staffService;
import com.jhta.netflix.content_staff.vo.Content_staffVo;
import com.jhta.netflix.good.service.GoodService;
import com.jhta.netflix.interasts.service.InterastsService;
import com.jhta.netflix.lib.FileUpload;
import com.jhta.netflix.lib.PageUtil;
import com.jhta.netflix.rates.service.RatesService;
import com.jhta.netflix.record.service.RecordService;
import com.jhta.netflix.series.service.SeriesService;
import com.jhta.netflix.series.vo.SeriesVo;

@Controller
public class ContentController {
	@Autowired
	private ContentService contentService;
	@Autowired
	private Content_genreService content_genreService;
	@Autowired
	private Content_staffService content_staffService;
	@Autowired
	private SeriesService seriesService;
	@Autowired 
	private FileUpload ftp;
	@Autowired
	private InterastsService interastsService;
	@Autowired
	private RatesService ratesService;
	@Autowired
	private RecordService recordService;
	@Autowired
	private Content_commentService content_commentService;
	@Autowired
	private GoodService goodService;
	@Autowired
	private BookmarkService bookmarkService;
	
	@RequestMapping(value="/content/insert",method=RequestMethod.GET)
	public String insertForm() {
		return ".content.insert";
	}
	@RequestMapping(value="/content/insert",method=RequestMethod.POST)
	public String insert(HttpSession session,HttpServletRequest request,
			MultipartFile poster,MultipartFile stillcut,MultipartFile trailer,MultipartFile org,
			Date release_date,int watch_age) {
		int content_num = contentService.maxNum() + 1;
		String content_name = request.getParameter("content_name");
		String content_summary = request.getParameter("content_summary");
		String category_num = request.getParameter("category_num");
		String series = request.getParameter("series");
		int series_num = 0;
		if(series != null) {
			series_num = Integer.parseInt(series);
		}
		ArrayList<Integer> genres = new ArrayList<Integer>();
		ArrayList<Integer> staffs = new ArrayList<Integer>();
		Enumeration<String> pn = request.getParameterNames();
		while(pn.hasMoreElements()) {
			String element = pn.nextElement();
			if(element.startsWith("genre")) {
				genres.add(Integer.parseInt(element.replace("genre", "")));
			}else if(element.startsWith("staff")) {
				staffs.add(Integer.parseInt(element.replace("staff", "")));
			}
		}
		
		UUID uuid = UUID.randomUUID();
		String posterUploadPath = "/poster/";
		String posterSaveName = uuid + "_" + poster.getOriginalFilename();
		String content_post1 = posterSaveName;
		String stillcutUploadPath = "/stillcut/";
		String stillcutSaveName = uuid + "_" + stillcut.getOriginalFilename();
		String content_post2 = stillcutSaveName;
		String trailerUploadPath = "/trailer/";
		String trailer_orgsrc = trailer.getOriginalFilename();
		String trailerSaveName = uuid + "_" + trailer_orgsrc;
		String trailer_savesrc = trailerSaveName;
		String orgUploadPath = "/org/";
		String orgsrc = org.getOriginalFilename();
		String orgSaveName = uuid + "_" + orgsrc;
		String savesrc = orgSaveName;
		try {
			ftp.init();
			ftp.upload(posterUploadPath, poster, posterSaveName);
			ftp.upload(stillcutUploadPath, stillcut, stillcutSaveName);
			ftp.upload(trailerUploadPath, trailer, trailerSaveName);
			ftp.upload(orgUploadPath, org, orgSaveName);
			ftp.disconnect();
			long trailer_size = trailer.getSize();
			long content_size = org.getSize();
			ContentVo vo = new ContentVo(content_num, content_name, orgsrc, savesrc, content_summary, 
					trailer_orgsrc, trailer_savesrc, content_size, trailer_size, content_post1, 
					content_post2, release_date, watch_age, null, series_num);
			contentService.insert(vo);
			for(int i = 0;i < genres.size();i++) {
				content_genreService.insert(new Content_genreVo(0, content_num, genres.get(i)));
			}
			for(int i = 0;i < staffs.size();i++) {
				content_staffService.insert(new Content_staffVo(0, staffs.get(i), content_num));
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return "redirect:/";
	}
	@RequestMapping(value="/content/delete",method=RequestMethod.GET)
	public String delete(HttpSession session,int num) {
		ContentVo orgVo = contentService.find(num);
		ftp.init();
		String posterDeletePath = "/poster/" + orgVo.getContent_post1();
		ftp.delete(posterDeletePath);
		String stillcutDeletePath = "/stillcut/" + orgVo.getContent_post2();
		ftp.delete(stillcutDeletePath);
		String trailerDeletePath = "/trailer/" + orgVo.getTrailer_savesrc();
		ftp.delete(trailerDeletePath);
		String orgDeletePath = "/org/" + orgVo.getSavesrc();
		ftp.delete(orgDeletePath);
		ftp.disconnect();
		List<Content_commentVo> list = content_commentService.relDeleteList(num);
		for(Content_commentVo vo : list) {
			goodService.relDelete(vo.getComment_num());
			if(vo.isBookmark()) {
				bookmarkService.relDelete(vo.getComment_num());
			}
		}
		content_commentService.relDelete(num);
		recordService.relDelete(num);
		ratesService.relDelete(num);
		interastsService.relDelete(num);
		content_genreService.relDelete(num);
		content_staffService.relDelete(num);
		contentService.delete(num);
		return "redirect:/content/list";
	}
	@RequestMapping(value="/content/update",method=RequestMethod.GET)
	public String updateForm(int num,Model model) {
		ContentVo vo = contentService.find(num);
		model.addAttribute("vo", vo);
		if(vo.getSeries_num() != 0) {
			model.addAttribute("seriesVo", seriesService.find(vo.getSeries_num()));
		}
		model.addAttribute("category_num", content_genreService.getCategory(num));
		model.addAttribute("glist", content_genreService.list(num));
		model.addAttribute("slist", content_staffService.staffList(num));
		return ".content.update";
	}
	@RequestMapping(value="/content/update",method=RequestMethod.POST)
	public String update(HttpSession session,HttpServletRequest request,
			MultipartFile poster,MultipartFile stillcut,MultipartFile trailer,MultipartFile org,
			Date release_date) {
		int content_num = Integer.parseInt(request.getParameter("content_num"));
		String content_name = request.getParameter("content_name");
		int watch_age = Integer.parseInt(request.getParameter("watch_age"));
		String content_summary = request.getParameter("content_summary");
		String series = request.getParameter("series");
		long content_size = 0;
		long trailer_size = 0;
		String orgsrc = null;
		String savesrc = null;
		String trailer_orgsrc = null;
		String trailer_savesrc = null;
		String content_post1 = null;
		String content_post2 = null;
		int series_num = 0;
		if(series != null) {
			series_num = Integer.parseInt(series);
		}
		ArrayList<Integer> genres = new ArrayList<Integer>();
		ArrayList<Integer> staffs = new ArrayList<Integer>();
		Enumeration<String> pn = request.getParameterNames();
		while(pn.hasMoreElements()) {
			String element = pn.nextElement();
			if(element.startsWith("genre")) {
				genres.add(Integer.parseInt(element.replace("genre", "")));
			}else if(element.startsWith("staff")) {
				staffs.add(Integer.parseInt(element.replace("staff", "")));
			}
		}
		ContentVo orgVo = contentService.find(content_num);
		ftp.init();
		UUID uuid = UUID.randomUUID();
		try {
			if(!poster.isEmpty()) {
				String posterUploadPath = "/poster/";
				String posterSaveName = uuid + "_" + poster.getOriginalFilename();
				content_post1 = posterSaveName;
				String posterDeletePath = "/poster/" + orgVo.getContent_post1();
				ftp.delete(posterDeletePath);
				ftp.upload(posterUploadPath, poster, posterSaveName);
			}
			if(!stillcut.isEmpty()) {
				String stillcutUploadPath = "/stillcut/";
				String stillcutSaveName = uuid + "_" + stillcut.getOriginalFilename();
				content_post2 = stillcutSaveName;
				String stillcutDeletePath = "/stillcut/" + orgVo.getContent_post2();
				ftp.delete(stillcutDeletePath);
				ftp.upload(stillcutUploadPath, stillcut, stillcutSaveName);
			}
			if(!trailer.isEmpty()) {
				String trailerUploadPath = "/trailer/";
				trailer_orgsrc = trailer.getOriginalFilename();
				String trailerSaveName = uuid + "_" + trailer_orgsrc;
				trailer_savesrc = trailerSaveName;
				String trailerDeletePath = "/trailer/" + orgVo.getTrailer_savesrc();
				ftp.delete(trailerDeletePath);
				ftp.upload(trailerUploadPath, trailer, trailerSaveName);
				trailer_size = trailer.getSize();
			}
			if(!org.isEmpty()) {
				String orgUploadPath = "/org/";
				orgsrc = org.getOriginalFilename();
				String orgSaveName = uuid + "_" + orgsrc;
				savesrc = orgSaveName;
				String orgDeletePath = "/org/" + orgVo.getSavesrc();
				ftp.delete(orgDeletePath);
				ftp.upload(orgUploadPath, org, orgSaveName);
				content_size = org.getSize();
			}
			ftp.disconnect();
			ContentVo vo = new ContentVo(content_num, content_name, orgsrc, savesrc, content_summary, 
					trailer_orgsrc, trailer_savesrc, content_size, trailer_size, content_post1, 
					content_post2, release_date, watch_age, null, series_num);
			contentService.update(vo);
			content_genreService.relDelete(content_num);
			for(int i = 0;i < genres.size();i++) {
				content_genreService.insert(new Content_genreVo(0, content_num, genres.get(i)));
			}
			content_staffService.relDelete(content_num);
			for(int i = 0;i < staffs.size();i++) {
				content_staffService.insert(new Content_staffVo(0, staffs.get(i), content_num));
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return "redirect:/content/list";
	}

	@RequestMapping(value="/content/list")
	public String list(Model model,@RequestParam(value="pageNum",defaultValue="1")int pageNum,
			@RequestParam(value="sort",defaultValue="recommend")String sort,String keyword) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(keyword != null && !keyword.trim().equals("")) {
			map.put("keyword", keyword);
			model.addAttribute("keyword", keyword);
		}
		int totalRowCount = contentService.listCount(map);
		PageUtil pageUtil = new PageUtil(pageNum, totalRowCount, 10, 10);
		map.put("startRow", pageUtil.getMysqlStartRow());
		map.put("rowBlockCount", pageUtil.getRowBlockCount());
		map.put("sort", sort);
		List<ContentVo> contentList = contentService.list(map);
		model.addAttribute("contentList", contentList);
		model.addAttribute("pageUtil", pageUtil);
		model.addAttribute("sort", sort);
		return ".content.list";
	}
	@RequestMapping(value="/content/userView",method=RequestMethod.GET)
	public String userList(HttpSession session,Model model,int profile_num) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("profile_num", profile_num);
		map.put("listType", "jjim");
		model.addAttribute("jjimList", contentService.userViewList(map));
		map.put("listType", "new");
		model.addAttribute("newList", contentService.userViewList(map));
		map.put("listType", "best");
		model.addAttribute("bestList", contentService.userViewList(map));
		map.put("startRow", 0);
		map.put("rowBlockCount", 40);
		model.addAttribute("recommendList", contentService.recommendList(map));
		session.setAttribute("searchState", "on");
		return ".user_content.list";
	}
	@RequestMapping(value="/content/contentPlay",method=RequestMethod.GET)
	public String contentPlay(Model model,int content_num) {
		ContentVo vo = contentService.find(content_num);
		model.addAttribute("vo", vo);
		return ".user_content.play";
	}
	@RequestMapping(value="/content/seriesList",produces="application/json;charset=utf-8")
	@ResponseBody
	public String seriesList(int series_num) {
		JSONObject json = new JSONObject();
		SeriesVo seriesVo = seriesService.find(series_num);
		json.put("series_name", seriesVo.getSeries_name());
		List<ContentVo> list = contentService.seriesList(series_num);
		JSONArray arr = new JSONArray();
		for(ContentVo vo : list) {
			JSONObject obj = new JSONObject();
			obj.put("content_num", vo.getContent_num());
			obj.put("content_name", vo.getContent_name());
			obj.put("orgsrc", vo.getOrgsrc());
			obj.put("savesrc", vo.getSavesrc());
			obj.put("content_summary", vo.getContent_summary());
			obj.put("trailer_orgsrc", vo.getTrailer_orgsrc());
			obj.put("trailer_savesrc", vo.getTrailer_savesrc());
			obj.put("content_size", vo.getContent_size());
			obj.put("trailer_size", vo.getTrailer_size());
			obj.put("content_post1", vo.getContent_post1());
			obj.put("content_post2", vo.getContent_post2());
			obj.put("release_date", vo.getRelease_date());
			obj.put("watch_age", vo.getWatch_age());
			obj.put("content_regdate", vo.getContent_regdate());
			obj.put("series_num", vo.getSeries_num());
			arr.put(obj);
		}
		json.put("list", arr);
		return json.toString();
	}
	@RequestMapping(value="/content/recommendList",produces="application/json;charset=utf-8")
	@ResponseBody
	public String recommendList(int profile_num) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("profile_num", profile_num);
		map.put("startRow", 0);
		map.put("rowBlockCount", 10);
		List<ContentVo> list = contentService.recommendList(map);
		JSONArray arr = new JSONArray();
		for(ContentVo vo : list) {
			JSONObject obj = new JSONObject();
			obj.put("content_num", vo.getContent_num());
			obj.put("content_name", vo.getContent_name());
			obj.put("orgsrc", vo.getOrgsrc());
			obj.put("savesrc", vo.getSavesrc());
			obj.put("content_summary", vo.getContent_summary());
			obj.put("trailer_orgsrc", vo.getTrailer_orgsrc());
			obj.put("trailer_savesrc", vo.getTrailer_savesrc());
			obj.put("content_size", vo.getContent_size());
			obj.put("trailer_size", vo.getTrailer_size());
			obj.put("content_post1", vo.getContent_post1());
			obj.put("content_post2", vo.getContent_post2());
			obj.put("release_date", vo.getRelease_date());
			obj.put("watch_age", vo.getWatch_age());
			obj.put("content_regdate", vo.getContent_regdate());
			obj.put("series_num", vo.getSeries_num());
			arr.put(obj);
		}
		return arr.toString();
	}
	@RequestMapping(value="/content/similarList",produces="application/json;charset=utf-8")
	@ResponseBody
	public String similarList(int content_num,int series_num) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("content_num", content_num);
		map.put("series_num", series_num);
		List<ContentVo> list = contentService.similarList(map);
		JSONArray arr = new JSONArray();
		for(ContentVo vo : list) {
			JSONObject obj = new JSONObject();
			obj.put("content_num", vo.getContent_num());
			obj.put("content_name", vo.getContent_name());
			obj.put("orgsrc", vo.getOrgsrc());
			obj.put("savesrc", vo.getSavesrc());
			obj.put("content_summary", vo.getContent_summary());
			obj.put("trailer_orgsrc", vo.getTrailer_orgsrc());
			obj.put("trailer_savesrc", vo.getTrailer_savesrc());
			obj.put("content_size", vo.getContent_size());
			obj.put("trailer_size", vo.getTrailer_size());
			obj.put("content_post1", vo.getContent_post1());
			obj.put("content_post2", vo.getContent_post2());
			obj.put("release_date", vo.getRelease_date());
			obj.put("watch_age", vo.getWatch_age());
			obj.put("content_regdate", vo.getContent_regdate());
			obj.put("series_num", vo.getSeries_num());
			arr.put(obj);
		}
		return arr.toString();
	}
	@RequestMapping(value="/content/searchContent",produces="application/json;charset=utf-8")
	@ResponseBody
	public String searchContent(HttpSession session,String txt,
			@RequestParam(value="category_num",defaultValue="0")int category_num) {
		JSONObject json = new JSONObject();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("txt", txt);
		map.put("category_num", category_num);
		List<ContentVo> list = contentService.searchContentName(map);
		JSONArray arr = new JSONArray();
		for(ContentVo vo : list) {
			JSONObject obj = new JSONObject();
			obj.put("content_num", vo.getContent_num());
			obj.put("content_name", vo.getContent_name());
			obj.put("orgsrc", vo.getOrgsrc());
			obj.put("savesrc", vo.getSavesrc());
			obj.put("content_summary", vo.getContent_summary());
			obj.put("trailer_orgsrc", vo.getTrailer_orgsrc());
			obj.put("trailer_savesrc", vo.getTrailer_savesrc());
			obj.put("content_size", vo.getContent_size());
			obj.put("trailer_size", vo.getTrailer_size());
			obj.put("content_post1", vo.getContent_post1());
			obj.put("content_post2", vo.getContent_post2());
			obj.put("release_date", vo.getRelease_date());
			obj.put("watch_age", vo.getWatch_age());
			obj.put("content_regdate", vo.getContent_regdate());
			obj.put("series_num", vo.getSeries_num());
			arr.put(obj);
		}
		json.put("searchContentName", arr);
		list = contentService.searchStaffName(map);
		arr = new JSONArray();
		for(ContentVo vo : list) {
			JSONObject obj = new JSONObject();
			obj.put("content_num", vo.getContent_num());
			obj.put("content_name", vo.getContent_name());
			obj.put("orgsrc", vo.getOrgsrc());
			obj.put("savesrc", vo.getSavesrc());
			obj.put("content_summary", vo.getContent_summary());
			obj.put("trailer_orgsrc", vo.getTrailer_orgsrc());
			obj.put("trailer_savesrc", vo.getTrailer_savesrc());
			obj.put("content_size", vo.getContent_size());
			obj.put("trailer_size", vo.getTrailer_size());
			obj.put("content_post1", vo.getContent_post1());
			obj.put("content_post2", vo.getContent_post2());
			obj.put("release_date", vo.getRelease_date());
			obj.put("watch_age", vo.getWatch_age());
			obj.put("content_regdate", vo.getContent_regdate());
			obj.put("series_num", vo.getSeries_num());
			arr.put(obj);
		}
		json.put("searchStaffName", arr);
		list = contentService.searchGenreName(map);
		arr = new JSONArray();
		for(ContentVo vo : list) {
			JSONObject obj = new JSONObject();
			obj.put("content_num", vo.getContent_num());
			obj.put("content_name", vo.getContent_name());
			obj.put("orgsrc", vo.getOrgsrc());
			obj.put("savesrc", vo.getSavesrc());
			obj.put("content_summary", vo.getContent_summary());
			obj.put("trailer_orgsrc", vo.getTrailer_orgsrc());
			obj.put("trailer_savesrc", vo.getTrailer_savesrc());
			obj.put("content_size", vo.getContent_size());
			obj.put("trailer_size", vo.getTrailer_size());
			obj.put("content_post1", vo.getContent_post1());
			obj.put("content_post2", vo.getContent_post2());
			obj.put("release_date", vo.getRelease_date());
			obj.put("watch_age", vo.getWatch_age());
			obj.put("content_regdate", vo.getContent_regdate());
			obj.put("series_num", vo.getSeries_num());
			arr.put(obj);
		}
		json.put("searchGenreName", arr);
		return json.toString();
	}
}





















