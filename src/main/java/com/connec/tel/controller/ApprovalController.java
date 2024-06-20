package com.connec.tel.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.connec.tel.service.ApprovalService;

@Controller
public class ApprovalController {

	@Autowired ApprovalService appService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	@PostMapping(value = "/test")
	public String test(@RequestParam List<String> emp_no, @RequestParam List<String> referrer, @RequestParam Map<String, Object> param) {
		for (String string : emp_no) {
			logger.info("emp_no : {}", string);			
		}
		
		logger.info("param : {}", param);
		
		for (String string : referrer) {
			logger.info("referrer : {}", string);			
		}
		
		return "redirect:/";		
	}
	
}
