package com.connec.tel.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.connec.tel.service.GuestManageService;

@Controller
public class GuestManageController {

	@Autowired GuestManageService guestMngService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	@PostMapping(value = "/guest/reserveList.ajax")
	@ResponseBody
	public Map<String, Object> reserveList(String search,
			String page, String cnt,String searchDate){
		logger.info("reserveList.axax 요청!!!");
		logger.info("search : "+ search);
		logger.info("page : "+ page);
		logger.info("cnt : "+ cnt);
		logger.info("searchDate : "+ searchDate);
		
		return guestMngService.reserveList(search, page, cnt, searchDate);
	}
	
	@PostMapping(value = "/guest/reserveDelete.ajax")
	@ResponseBody
	public Map<String, Object> reserveDelete(String res_no){
		logger.info("reserveDelete.axax 요청!!!");
		logger.info("res_no : "+ res_no);
	
		return guestMngService.reserveDelete(res_no);
	}
	
	@PostMapping(value = "/guest/stayList.ajax")
	@ResponseBody
	public Map<String, Object> stayList(String search,
			String page, String cnt,String searchDate){
		logger.info("stayList.axax 요청!!!");
		logger.info("search : "+ search);
		logger.info("page : "+ page);
		logger.info("cnt : "+ cnt);
		logger.info("searchDate : "+ searchDate);
		
		return guestMngService.stayList(search, page, cnt, searchDate);
	}
	
	
}

