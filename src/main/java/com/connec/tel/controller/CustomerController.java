package com.connec.tel.controller;


import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.service.CustomerService;

@Controller
public class CustomerController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired CustomerService customerService;
	
	
	/*                  :: 이동 관련 ::    /customer/.. .go로 할 것!           */
	
	//고객 페이지 이동	
	@RequestMapping(value="/customer/customermain.go")
	public String customerpage_go() {
		logger.info("고객 메인페이지 이동.");
		return"/customer/clientmain";
	}
	
	//고객 공지사항 이동
	@RequestMapping(value="/customer/notice.go")
	public String notice_go() {
		logger.info("고객 공지사항 이동");
		return "/customer/customernotice";
	}
	
	//고객 FAQ 이동
	@RequestMapping(value="/customer/faq.go")
	public String faq_go() {
		logger.info("고객 FAQ 이동");
		
		return "/customer/customerfaq";
	}
	
	//예약페이지 이동
	@RequestMapping(value="/customer/reservation.go")
	public String reservation_go(){
		logger.info("고객 예약페이지 이동");
		
		return"/customer/reservation";
	}
	
	//예약조회페이지 이동
	@RequestMapping(value="/customer/myreservation.go")
	public String myreservation_go() {
		logger.info("예약조회 페이지 이동");
		
		return"/customer/myreservation";
		
	}
	
	//공지사항 상세보기 이동
	@RequestMapping(value="/customer/noticeDetail.go")
	public ModelAndView noticeDetail(String ann_no) {
		logger.info("디테일 요청함");
		logger.info("넘버"+ann_no);
		
		return customerService.noticeDetail(ann_no);
		
	}
	
	
	
	
	
	
	
	/*                  :: 아작스 관련 ::    /customer/.. .ajax로 할 것!           */
	
	
	
	//공지사항 리스트 ajax
	@GetMapping(value="/customer/notice.ajax")
	@ResponseBody
	public Map<String, Object> noticelist(String page, String cnt,  String ann_division, String ann_bHit, String ann_fixed, String register, String ann_date) {
		logger.info("고객 공지사항 리스트 요청");
		
		int currPage = Integer.parseInt(page);
        int pagePerCnt = Integer.parseInt(cnt);
		
		
		return customerService.noticelist(currPage, pagePerCnt, ann_division, ann_fixed, register, ann_date);
	}
	
	//공지사항 검색 ajax
	@RequestMapping(value="customer/noticesearch.ajax")
	@ResponseBody
	public Map<String, Object> noticeSearch(@RequestParam("textval")String textval, @RequestParam("page") String page){
		Map<String, Object> map = new HashMap<>();
		customerService.noticeSearch(map,textval);
		
		return map;
		
	}
	
	
	
	//고객예약날짜 ajax
	@PostMapping(value = "/customer/reserveListCall.ajax")
	@ResponseBody
	public Map<String, Object> reserveListCall(@RequestParam Map<String, Object> param){
		logger.info("고객이 예약 가능한 리스트를 요청");
		logger.info("검색 날짜 : {}", param);
		
		return customerService.reserveListCall(param);
	}
	
	
	
	
	
}
