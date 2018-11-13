package com.jhta.netflix.profile.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.jhta.netflix.profile.service.ProfileUserService;
import com.jhta.netflix.profile.vo.ProfileUserListVo;
import com.jhta.netflix.profile.vo.ProfileUserVo;
import com.jhta.netflix.profile.vo.ProfileVo;

@Controller
public class ProfileController {
	@Autowired private ProfileService admin_service;
	@Autowired private ProfileUserService user_service;
	@Autowired FileUpload ftp;
	//amin profile 페이지 이동 
	@RequestMapping(value="/admin/profile")
	public ModelAndView adminProfileView() {
		ModelAndView mv =new ModelAndView(".admin.profile");
		List<ProfileVo> pro_group_list = admin_service.groupList(); 
		mv.addObject("profile_group", pro_group_list);
		return mv;
	}
	//그룹 추가
	@RequestMapping(value="/admin/profile/groupInput",method=RequestMethod.POST)
	public String adminProfileInsert(@RequestParam("pro_group_name") String pro_group_name) {
		ProfileVo vo= new ProfileVo(0,pro_group_name);
		admin_service.groupInsert(vo);
		return "redirect:/admin/profile";
	}
	
	//ajax json 그룹 이미지 
	@RequestMapping(value="/admin/profile/group-img",method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> adminGroupImg(@RequestParam("group_no") int group_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ProfileVo> list = admin_service.proImgList(group_no);
		map.put("profile_group_img", list);
		return map;
	}
	//이미지 업로드 
	@RequestMapping(value="/admin/profile/imgInput",method=RequestMethod.POST)
	public String adminGroupImgInput(@RequestParam("file1") MultipartFile file1,@RequestParam("pro_group_no") String pro_group_no,HttpServletRequest req) {
		String fileName = file1.getOriginalFilename();
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
			admin_service.proImgInsert(vo);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "redirect:/admin/profile";
	}
	
	//group delete
	@RequestMapping(value="/admin/profile/group/del",method=RequestMethod.GET)
	public String adminProfileGroupDel(@RequestParam("group_no") String group_no) {
		int no = Integer.parseInt(group_no);
		admin_service.groupDel(no);
		return "redirect:/admin/profile";
	}
	
	//profile img delete
	@RequestMapping(value="/admin/profile/img/del",method=RequestMethod.GET)
	public String adminProfileImgDel(@RequestParam("pimg_no") String pimg_no) {
		int no = Integer.parseInt(pimg_no);
		admin_service.proImgDel(no);
		return "redirect:/admin/profile";
	}
	
	//profile choice view
	@RequestMapping(value="/profile/user/index")
	public ModelAndView profileChoiceView(HttpSession session) {
		String id = (String)session.getAttribute("id");
		List<ProfileUserListVo> list = user_service.userProfileList(id);
		if(list!=null) {//등록된 프로필이 있을 때 세션에 유저번호 저장
			ProfileUserListVo vo = list.get(0);
			session.setAttribute("users_num", vo.getUsers_num());
		}
		ModelAndView mv = new ModelAndView(".profile.index");
		mv.addObject("list",list);
		return mv;
	}
	
	//profile user insert form move
	@RequestMapping(value="/profile/user/insertForm",method=RequestMethod.GET)
	public ModelAndView profilUserInsertFormView(@RequestParam("first")String first) {
		ModelAndView mv = new ModelAndView(".profile.insertForm");
		mv.addObject("first",first);
		return mv;
	}
	
	//profile user insertOk
	@RequestMapping(value="/profile/user/insert",method=RequestMethod.POST)
	public String profileUserInsertOk(@RequestParam("nickname")String nickname,@RequestParam("pimg_num")String pimg_num,@RequestParam("profile_pwd")String profile_pwd,@RequestParam("child")String child,@RequestParam("profile_first")String profile_first,HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String id = (String)session.getAttribute("id");
		int img_no = Integer.parseInt(pimg_num);
		int age;
		if(child.equals("false")) {
			age=19;
		}else {
			age=7;
		}
		boolean first=false;
		if(profile_first.equals("true")) {
			first=true;
		}
		ProfileUserVo vo = new ProfileUserVo(0, nickname, 0, img_no, age, profile_pwd, first, null);
		map.put("vo", vo);
		map.put("id", id);
		user_service.userProfileInsert(map);
		return "redirect:/profile/user/index";
	}
	
}
