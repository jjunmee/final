package com.jhta.netflix.pay_info.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.jhta.netflix.pay_info.service.Pay_infoService;

@Controller
public class Pay_infoController {
	@Autowired
	private Pay_infoService service;
	
	
}
