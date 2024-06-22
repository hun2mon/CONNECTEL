package com.connec.tel.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.connec.tel.service.CommonService;

@Controller
public class CommonController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired CommonService commonService;
	
	@GetMapping(value = "/treeCall.ajax")
	@ResponseBody
	public Map<String, Object> treeCall(){
		return commonService.treeCall(); 
	}
	
	@GetMapping(value = "/listCall.ajax")
	@ResponseBody
	public Map<String, Object> listCall(String search, String page, String cnt){
		
		return commonService.listCall(search, page, cnt); 
	}
	
	
}
