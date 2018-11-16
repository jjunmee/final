package com.jhta.netflix.profile.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.profile.dao.ProfileDao;
import com.jhta.netflix.profile.dao.ProfileDaoImpl;
import com.jhta.netflix.profile.vo.ProfileUserVo;
import com.jhta.netflix.profile.vo.ProfileVo;

@Service
public class ProfileService {
	@Autowired
	private ProfileDaoImpl profileDao;
	
	
		public int groupInsert(ProfileVo vo) {
			return profileDao.groupInsert(vo);
		}
		public int groupDel(int no) {
			return profileDao.groupDel(no);
		}
		public List<ProfileVo> groupList(){
			return profileDao.groupList();
		}
		
		
		public int proImgInsert(ProfileVo vo) {
			return profileDao.proImgInsert(vo);
		}
		public int proImgDel(int no) {
			return profileDao.proImgDel(no);
		}
		public List<ProfileVo> proImgList(int no){
			return profileDao.proImgList(no);
		}
		public List<ProfileVo> imgAllList(){
			return profileDao.imgAllList();
		}
		
		public ProfileUserVo find(int num) {
			return profileDao.find(num);
		}
}
