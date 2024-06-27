package com.connec.tel.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.connec.tel.service.CommonService;

@Controller
public class CommonController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired CommonService commonService;
	
	// 조직도
	@GetMapping(value = "/treeCall.ajax")
	@ResponseBody
	public Map<String, Object> treeCall(){
		return commonService.treeCall(); 
	}
	
	// 테이블 예시
	@GetMapping(value = "/listCall.ajax")
	@ResponseBody
	public Map<String, Object> listCall(String search, String page, String cnt){
		
		return commonService.listCall(search, page, cnt); 
	}
	
	// 파일 다운로드
	@GetMapping(value = "/download/{file}")
	public ResponseEntity<Resource> download(@PathVariable String file) {
		logger.info("file : {}", file);
		return commonService.download(file);
	}
	
	
}
