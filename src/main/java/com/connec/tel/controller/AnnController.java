package com.connec.tel.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.connec.tel.service.AnnService;

@Controller
public class AnnController {
	
	@Autowired AnnService annService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	@RequestMapping(value="/empann/annList.ajax")
	@ResponseBody
	public Map<String, Object> annList(String page, String cnt, String ann_division,String ann_bHit, String ann_fixed){
		logger.info("직원 공지사항 요청");
		logger.info("cnt :"+cnt);
		logger.info("직원 = E"+ ann_division);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		
		
		
		return annService.list(currPage,pagePerCnt,ann_division,ann_fixed);
	}
	
	@RequestMapping(value="/empannwrite.go")
	public String annwrite() {
		return"/ann/empAnnWrite";
	}
	
	
	

}
