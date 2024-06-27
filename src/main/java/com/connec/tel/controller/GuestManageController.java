package com.connec.tel.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.connec.tel.dto.kakaoPayCancelDTO;
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
	
	@PostMapping(value = "/guest/reserveCancel.ajax")
	@ResponseBody
	public kakaoPayCancelDTO reserveCancel(String res_no,String cancelPrice){
		logger.info("reserveDelete.axax 요청!!!");
		logger.info("res_no : "+ res_no);
		logger.info("cancelPrice : "+ cancelPrice);
		
		kakaoPayCancelDTO res = guestMngService.reserveCancel(res_no,cancelPrice);
		return res;
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
	
	@PostMapping(value = "/guest/cancelList.ajax")
	@ResponseBody
	public Map<String, Object> cancelList(String search,
			String page, String cnt,String searchDate){
		logger.info("cancelList.axax 요청!!!");
		logger.info("search : "+ search);
		logger.info("page : "+ page);
		logger.info("cnt : "+ cnt);
		logger.info("searchDate : "+ searchDate);
		
		return guestMngService.cancelList(search, page, cnt, searchDate);
	}
	
	@PostMapping(value = "/guest/resCancelDate.ajax")
	@ResponseBody
	public Map<String, Object> resCancelDate(String date){
		logger.info("resCancelDate.axax 요청!!!");
		logger.info("date : "+ date);
		
		return guestMngService.resCancelDate(date);
	}
	
	
}

