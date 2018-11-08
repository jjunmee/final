package com.jhta.netflix.profile.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.netflix.lib.FileUpload;
import com.jhta.netflix.profile.service.ProfileService;
import com.jhta.netflix.profile.vo.ProfileVo;

@Controller
public class ProfileController {
	@Autowired private ProfileService service;
	@Autowired FileUpload ftp;
	//amin profile 페이지 이동 
	@RequestMapping(value="/admin/profile")
	public ModelAndView adminProfileView() {
		ModelAndView mv =new ModelAndView(".admin.profile");
		List<ProfileVo> pro_grop_list = service.groupList(); 
		mv.addObject("profile_group", pro_grop_list);
		return mv;
	}
	//그룹 추가
	@RequestMapping(value="/admin/profile/groupInput",method=RequestMethod.POST)
	public String adminProfileInsert(@RequestParam("pro_group_name") String pro_group_name) {
		ProfileVo vo= new ProfileVo(0,pro_group_name);
		service.groupInsert(vo);
		return "redirect:/admin/profile";
	}
	
	//ajax json 그룹 이미지 
	@RequestMapping(value="/admin/profile/group-img",method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> adminGroupImg(@RequestParam("group_no") int group_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ProfileVo> list = service.proImgList(group_no);
		map.put("profile_group_img", list);
		return map;
	}
	//이미지 업로드 
	@RequestMapping(value="/admin/profile/imgInput",method=RequestMethod.POST)
	public String adminGroupImgInput(@RequestParam("file1") MultipartFile file1,@RequestParam("pro_group_no") String pro_group_no,HttpServletRequest req) {
		String fileName = file1.getOriginalFilename();
		System.out.println(">>>>>>>>>>>>>>>>>>."+pro_group_no+"<<<<<<<<<<<<<<<<<<<<<");
		try {
			InputStream is = file1.getInputStream();
			String file_path = req.getSession().getServletContext().getRealPath("/resources/")+fileName;
			FileOutputStream fos = new FileOutputStream(file_path);
			FileCopyUtils.copy(is, fos);
			File f = new File(file_path);
			ftp.init();
			ftp.upload("/profile/"+pro_group_no+"/", f);
			ftp.disconnect();
			is.close();
			fos.close();
			if(!f.delete()) {
				throw new Exception("error");
			}
			int group_no = Integer.parseInt(pro_group_no);
			String url = "http://dmszone.com:8080/watflix/profile/"+pro_group_no+"/"+fileName;
			ProfileVo vo = new ProfileVo(0, group_no, url);
			int no = service.proImgInsert(vo);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "redirect:/admin/profile";
	}
}
