package com.jhta.netflix.profile.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jhta.netflix.profile.dao.ProfileUserDaoImpl;

@Service
public class ProfileUserService {
	@Autowired private ProfileUserDaoImpl dao;
}
