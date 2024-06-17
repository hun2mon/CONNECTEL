package com.connec.tel.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.connec.tel.service.MainService;

@Controller
public class MainController {
	
	@Autowired MainService mainService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value = "/")
	public String main() {
		logger.info("main 요청");
		
		return "main/main";
	}
	
	@RequestMapping(value = "/{folder}/{jsp}" + ".go")
	public String move(@PathVariable String folder, @PathVariable String jsp) {
		return folder + "/" + jsp;
	}
}
