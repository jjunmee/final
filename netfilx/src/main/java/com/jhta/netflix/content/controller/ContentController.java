package com.jhta.netflix.content.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jhta.netflix.content.service.ContentService;

@Controller
public class ContentController {
	@Autowired
	private ContentService service;
	
	@RequestMapping(value="/content/insert",method=RequestMethod.GET)
	public String insertForm() {
		return "content/insert";
	}
}
