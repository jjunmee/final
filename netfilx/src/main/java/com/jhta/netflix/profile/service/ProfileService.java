package com.jhta.netflix.profile.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.profile.dao.ProfileDao;

@Service
public class ProfileService {
	@Autowired
	private ProfileDao profileDao;
}
