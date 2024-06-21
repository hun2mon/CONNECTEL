package com.connec.tel.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.connec.tel.service.MainService;

@Controller
public class MainController {
	
	@Autowired MainService mainService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	// 메인 페이지 이동
	@RequestMapping(value = "/main")
	public String main() {
		logger.info("main 요청");
		
		return "main/main";
	}
	
	// 페이지 이동
	@RequestMapping(value = "/{folder}/{jsp}" + ".go")
	public String move(@PathVariable String folder, @PathVariable String jsp) {
		return folder + "/" + jsp;
	}
}
