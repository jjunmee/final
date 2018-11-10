package com.jhta.netflix.record.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.jhta.netflix.record.service.RecordService;

@Controller
public class RecordController {
	@Autowired
	private RecordService service;
}
