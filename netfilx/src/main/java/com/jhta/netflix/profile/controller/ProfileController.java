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
import org.springframework.dao.DataIntegrityViolationException;
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
		try {
			admin_service.proImgDel(no);
		}catch(DataIntegrityViolationException e) {
			return "redirect:/admin/profile";
		}
		return "redirect:/admin/profile";
	}
	
	//profile choice view
	@RequestMapping(value="/profile/user/index")
	public ModelAndView profileChoiceView(HttpSession session) {
		String id = (String)session.getAttribute("id");
		List<ProfileUserListVo> list = user_service.userProfileList(id);
		ModelAndView mv = new ModelAndView(".profile.index");
		if(!list.isEmpty()) {
			session.setAttribute("users_num",list.get(0).getUsers_num());
			mv.addObject("list",list);
		}
		return mv;
	}
	
	//head json profile get list
	@RequestMapping(value="/profile/user/json")
	public @ResponseBody HashMap<String, Object> profileUsergetList(HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			int profile_num = (Integer)session.getAttribute("profile_num");
			int users_num = (Integer)session.getAttribute("users_num");
			if(profile_num>0 && users_num>0) {
				map.put("users_num", users_num);
				map.put("profile_num", profile_num);
				List<ProfileUserListVo> list = user_service.userProfileList(map);
				map.put("profileList", list);
			}
			return map;
		}catch (NullPointerException e) {
			String id = (String)session.getAttribute("id");
			List<ProfileUserListVo> list = user_service.userProfileList(id);
			map.put("profileList", list);
			return map;
		}
	}
	
	//profile user insert form move
	@RequestMapping(value="/profile/user/insertForm",method=RequestMethod.GET)
	public ModelAndView profilUserInsertFormView(@RequestParam("first")String first,@RequestParam("pimg_src")String pimg_src,@RequestParam("pimg_num")String pimg_num){
		ModelAndView mv = new ModelAndView(".profile.insertForm");
			  mv.addObject("action", "/profile/user/insert");
		mv.addObject("first",first);
		mv.addObject("pimg_src",pimg_src);
		mv.addObject("pimg_num",pimg_num);
		return mv;
	}
	
	//profile user insert form move
	@RequestMapping(value="/profile/user/updateFormView",method=RequestMethod.GET)
	public ModelAndView profilUserUpdateFormView(@RequestParam("profile_num")String profile_num,@RequestParam(value="n_pimg_src",defaultValue="")String n_pimg_src,@RequestParam(value="n_pimg_num",defaultValue="")String n_pimg_num){
		ModelAndView mv = new ModelAndView(".profile.insertForm");
		int profile;
		try {
			profile=Integer.parseInt(profile_num);
		}catch(NullPointerException e) {
			profile=0;
		}
		if(profile>0) {
		  ProfileUserListVo vo = user_service.profileInfo(profile);
		  if(vo!=null) {
			  mv.addObject("vo", vo);
			  mv.addObject("action", "/profile/manageProfiles/up");
		  }
		}
		if(n_pimg_num!=null) {
			mv.addObject("n_pimg_num", n_pimg_num);
			mv.addObject("n_pimg_src", n_pimg_src);
		}
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
			age=7;
		}else {
			age=19;
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
	
	///profile/user/getInfo?
	@RequestMapping(value="/profile/user/getInfo",method=RequestMethod.POST)
	public String userProfileSelect(@RequestParam("profile_num")String profile_num,@RequestParam("p_password")String p_password,HttpSession session) {
		int no=Integer.parseInt(profile_num);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("profile_num", no);
		map.put("profile_pwd", p_password);
		ProfileUserListVo vo = user_service.userProfileInfo(map);
		if(vo!=null) {
		session.setAttribute("users_num", vo.getUsers_num());
		session.setAttribute("profile_num", vo.getProfile_num());
		session.setAttribute("nickname", vo.getNickname());
		session.setAttribute("pimg_src", vo.getPimg_src());
		session.setAttribute("profile_first", vo.isProfile_first());
		}
		return ".main";
	}
	
	//profile img All list execute
	@RequestMapping(value="/profile/user/img/listForm")
	public ModelAndView ProfileAllList(@RequestParam("first")String first,HttpSession session) {
		ModelAndView mv = new ModelAndView(".profile.imgListForm");
		List<ProfileVo> group_list = admin_service.groupList();
		List<ProfileVo> pro_list = admin_service.imgAllList();
		mv.addObject("group_list", group_list);
		mv.addObject("pro_list", pro_list);
		mv.addObject("first", first);
		return mv;
	}
	
	///profile/user/img/change?profile_num=${vo. }
	//profile img All list execute
	@RequestMapping(value="profile/user/img/change")
	public ModelAndView profileImgChange(@RequestParam("profile_num")String profile_num,HttpSession session) {
		ModelAndView mv = new ModelAndView(".profile.imgListForm");
		List<ProfileVo> group_list = admin_service.groupList();
		List<ProfileVo> pro_list = admin_service.imgAllList();
		mv.addObject("group_list", group_list);
		mv.addObject("pro_list", pro_list);
		mv.addObject("profile_num", profile_num);
		return mv;
	}
	//유저프로필관리
	@RequestMapping(value="/profile/manageProfiles")
	public ModelAndView profileUserInfoAdmin(HttpSession session) {
		String id = (String)session.getAttribute("id");
		List<ProfileUserListVo> list = user_service.userProfileList(id);
		ModelAndView mv = new ModelAndView(".profile.manageProfiles");
		if(!list.isEmpty()) {
			mv.addObject("list",list);
		}
		return mv;
	}
	
	//유저프로필 삭제처리 first 값 2로 변경 후 조회시 2번 제외!!!!!!
	@RequestMapping(value="/profile/manageProfiles/del",method=RequestMethod.GET)
	public String userProfileDelete(String profile_num) {
		int num = Integer.parseInt(profile_num);
		user_service.userProfileManagersDelete(num);
		return "redirect:/profile/manageProfiles";
	}
	//유저프로필 수정
	@RequestMapping(value="/profile/manageProfiles/up",method=RequestMethod.POST)
	public String userProfileUpdate(@RequestParam("nickname")String nickname,@RequestParam("pimg_num")String pimg_num,@RequestParam("profile_pwd")String profile_pwd,@RequestParam("child")String child,@RequestParam("profile_num")String profile_num) {
		int profile_no = Integer.parseInt(profile_num);
		int img_no = Integer.parseInt(pimg_num);
		int age;
		if(child.equals("false")) {
			age=7;
		}else {
			age=19;
		}
		ProfileUserVo vo = new ProfileUserVo(profile_no, nickname, 0, img_no, age, profile_pwd, false, null);
		user_service.userProfileManagersUpdate(vo);
		return "redirect:/profile/manageProfiles";
	}
}
