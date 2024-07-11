package com.connec.tel.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.connec.tel.dto.kakaoPayApproveDTO;
import com.connec.tel.dto.kakaoPayReadyDTO;
import com.connec.tel.service.CommonService;




@Controller
public class CommonController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired CommonService commonService;
	
	// 조직도
	@GetMapping(value = "/treeCall.ajax")
	@ResponseBody
	public Map<String, Object> treeCall(String search){
		String word = "%%";
		if (search != null) {
			word = "%" + search + "%";			
		}
		logger.info("search : {}", word);
		return commonService.treeCall(word); 
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
	
	//카카오페이 결제 요청(guest/proxyReserve.jsp 에 ajax 요청법 있어요 참고 요망)
	@PostMapping(value = "/common/ready")
	@ResponseBody
	public kakaoPayReadyDTO kakaoPay(@RequestParam Map<String, Object> params,HttpSession session) {
		logger.info("결제요청");
		logger.info("params : {}",params);
		kakaoPayReadyDTO res = commonService.kakaoPay(params,session);

		return res;
	}
	
		@PostMapping(value = "/common/PlusReady")
		@ResponseBody
		public kakaoPayReadyDTO PlusReady(@RequestParam Map<String, Object> params,HttpSession session) {
			logger.info("결제요청");
			logger.info("params : {}",params);
			kakaoPayReadyDTO res = commonService.PlusReady(params,session);

			return res;
		}
	
	
	//결제 성공시
	@RequestMapping(value ="/common/success" )
	public String success(@RequestParam("pg_token") String pgToken,HttpSession session,Model model) {
		logger.info("성공");
		logger.info("pgToken : " +pgToken);
		kakaoPayApproveDTO res = commonService.kakaoPayApprove(pgToken,session);
		model.addAttribute("msg", "예약에 성공하였습니다.");
		return "/guest/proxyReserve";
	}
	
	//추가결제 성공시
		@RequestMapping(value ="/common/plusSuccess" )
		public String plusSuccess(@RequestParam("pg_token") String pgToken,HttpSession session,Model model) {
			logger.info("성공");
			logger.info("pgToken : " +pgToken);
			kakaoPayApproveDTO res = commonService.plusSuccess(pgToken,session);
			model.addAttribute("msg", "업그레이드 하였습니다.");
			return "/room/liveRoomManage";
		}
	
	//카카오페이 결제 중 취소
	@RequestMapping(value ="/common/cancel" )
	public String cancel(Model model) {
		logger.info("취소");
		model.addAttribute("msg", "예약에 실패하였습니다.");
		return "/guest/proxyReserve";
	}
	
	
}
