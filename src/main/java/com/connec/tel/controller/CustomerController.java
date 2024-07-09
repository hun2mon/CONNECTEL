package com.connec.tel.controller;


import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.dto.RoomDTO;
import com.connec.tel.dto.kakaoPayApproveDTO;
import com.connec.tel.dto.kakaoPayReadyDTO;
import com.connec.tel.service.CustomerService;
import java.util.Random;

import javax.servlet.http.HttpSession;



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
	
	//결제페이지 이동
	@RequestMapping(value="/customer/payment.go")
	public String payment(String checkin) {
		
		return "/customer/payment";
	}
	
	
	//호텔소개 페이지 이동
	@RequestMapping(value="/customer/hotelpreiview.go")
	public String preview_go(){
		
		
		return"/customer/hotelpreview";
	}
	
	//예약조획 성공 상세조회 페이지 이동
	@RequestMapping(value="/customer/myreservationdetail.go")
	public ModelAndView myresercheckDetail(HttpSession session) {
		logger.info("예약조회 페이지 이동");
		String res_no = (String) session.getAttribute("reservationNo");
		
		
		logger.info("요청 번호:"+res_no);
		
		return customerService.myresercheckDetail(res_no);
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
	
	
	//고객 결제 이메일인증 ajax
	@PostMapping(value="/customer/emailsend.ajax")
	@ResponseBody
	public String emailcode(String email, HttpSession session ){

		
		int random = (int) (Math.random() * 999999) + 0;
		String Code = String.format("%06d", random);

        logger.info("인증 코드 :{}", Code);

        // 세션에 인증 코드 저장
        session.setAttribute("Code", Code);
        session.setAttribute("email", email);

        // 이메일 전송
        customerService.emailcode(email, Code);

        return "인증코드가 이메일로 전송되었습니다.";
    }
	
	@PostMapping("/customer/codeconfirm.ajax")
    @ResponseBody
    public String confirmEmailCode(@RequestParam("confirm") String confirm, HttpSession session) {
        // 세션에서 인증 코드 가져오기
        String storedCode = (String) session.getAttribute("Code");
        logger.info("세션 코드 "+storedCode);
        if (confirm.equals(storedCode)) {
            return "이메일 인증이 완료되었습니다.";
        } else {
            return "유효하지 않은 인증 코드입니다.";
        }
    }
	
	
	@PostMapping("/customer/reservation.ajax")
	@ResponseBody
	public kakaoPayReadyDTO kakaopay(@RequestParam Map<String, Object> params,HttpSession session, String cos_email){
		logger.info("결제요청");
		logger.info("params : {}",params);
		session.setAttribute("email",cos_email);
		kakaoPayReadyDTO res = customerService.kaPay(params,session);
		
		return res;
		
		
	}
	
	
	@RequestMapping(value ="/customer/success" )
	public String success(@RequestParam("pg_token") String pgToken,HttpSession session,Model model) {
		logger.info("성공");
		logger.info("pgToken : " +pgToken);
		kakaoPayApproveDTO res = customerService.kakaoPayApprove(pgToken,session);
		model.addAttribute("msg", "예약에 성공하였습니다.");
		String successsend = (String) session.getAttribute("email");
		
		customerService.successmailsend(successsend);

		return "/customer/reservationsuccess";
	}
	
	//카카오페이 결제 중 취소
	@RequestMapping(value ="/customer/cancel" )
	public String cancel(Model model) {
		logger.info("취소");
		model.addAttribute("msg", "예약에 실패하였습니다.");
		return "/customer/reservation.go";
	}
	
	
	
	@PostMapping(value="/customer/reservationcheck.ajax")
	@ResponseBody
	public Map<String, Object> reservationcheck(@RequestParam String name, @RequestParam String phone, @RequestParam String reservationNo,HttpSession session) {

	    logger.info("예약조회 컨트롤러");
	    logger.info("이름 :" + name);
	    logger.info("폰번호 :" + phone);
	    logger.info("예약번호 :" + reservationNo);

	   
	    return customerService.reservationcheck(name, phone, reservationNo, session);
	}
	
	
	
	
	
}
