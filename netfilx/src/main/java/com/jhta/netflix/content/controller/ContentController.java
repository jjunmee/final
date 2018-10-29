package com.jhta.netflix.content.controller;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.jhta.netflix.content.service.ContentService;
import com.jhta.netflix.content.vo.ContentVo;
import com.jhta.netflix.content_genre.service.Content_genreService;
import com.jhta.netflix.content_genre.vo.Content_genreVo;
import com.jhta.netflix.content_staff.service.Content_staffService;
import com.jhta.netflix.content_staff.vo.Content_staffVo;

@Controller
public class ContentController {
	@Autowired
	private ContentService contentService;
	@Autowired
	private Content_genreService content_genreService;
	@Autowired
	private Content_staffService content_staffService;
	
	@RequestMapping(value="/content/insert",method=RequestMethod.GET)
	public String insertForm() {
		return "content/insert";
	}
	@RequestMapping(value="/content/insert",method=RequestMethod.POST)
	public String insert(HttpSession session,HttpServletRequest request,MultipartFile poster,
			MultipartFile stillcut,MultipartFile trailer,MultipartFile org,Date release,int watch_age) {
		int content_num = contentService.count() + 1;
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
		String posterUploadPath = session.getServletContext().getRealPath("/resources/upload/poster");
		String posterSaveName = uuid + "_" + poster.getOriginalFilename();
		String content_post1 = posterSaveName;
		String stillcutUploadPath = session.getServletContext().getRealPath("/resources/upload/stillcut");
		String stillcutSaveName = uuid + "_" + stillcut.getOriginalFilename();
		String content_post2 = stillcutSaveName;
		String trailerUploadPath = session.getServletContext().getRealPath("/resources/upload/trailer");
		String trailer_orgsrc = trailer.getOriginalFilename();
		String trailerSaveName = uuid + "_" + trailer_orgsrc;
		String trailer_savesrc = trailerSaveName;
		String orgUploadPath = session.getServletContext().getRealPath("/resources/upload/org");
		String orgsrc = org.getOriginalFilename();
		String orgSaveName = uuid + "_" + orgsrc;
		String savesrc = orgSaveName;
		try {
			InputStream is = poster.getInputStream();
			FileOutputStream fos = new FileOutputStream(posterUploadPath + "\\" + posterSaveName);
			FileCopyUtils.copy(is, fos);
			is.close();
			fos.close();
			System.out.println(posterUploadPath + "경로에 poster!");
			is = stillcut.getInputStream();
			fos = new FileOutputStream(stillcutUploadPath + "\\" + stillcutSaveName);
			FileCopyUtils.copy(is, fos);
			is.close();
			fos.close();
			System.out.println(stillcutUploadPath + "경로에 stillcut!");
			is = trailer.getInputStream();
			fos = new FileOutputStream(trailerUploadPath + "\\" + trailerSaveName);
			FileCopyUtils.copy(is, fos);
			is.close();
			fos.close();
			System.out.println(trailerUploadPath + "경로에 trailer!");
			long trailer_size = trailer.getSize();
			is = org.getInputStream();
			fos = new FileOutputStream(orgUploadPath + "\\" + orgSaveName);
			FileCopyUtils.copy(is, fos);
			is.close();
			fos.close();
			System.out.println(orgUploadPath + "경로에 org!");
			long content_size = org.getSize();
			ContentVo vo = new ContentVo(content_num, content_name, orgsrc, savesrc, content_summary, 
					trailer_orgsrc, trailer_savesrc, content_size, trailer_size, content_post1, 
					content_post2, release, watch_age, null, series_num);
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
}
