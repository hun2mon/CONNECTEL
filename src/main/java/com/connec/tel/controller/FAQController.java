package com.connec.tel.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.service.FAQService;

@Controller
public class FAQController {
	
	@Autowired FAQService faqService;
	Logger logger = LoggerFactory.getLogger(getClass());

	
	@RequestMapping(value="/faq/faqList.ajax")
	@ResponseBody
	public Map<String, Object> faqList(String page, String cnt){
		logger.info("faq List 요청");
		logger.info("페이지당 보여줄 갯수 : "+cnt);
		logger.info("요청 페이지 : "+page);
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		
		
		return faqService.list(currPage,pagePerCnt);
	}
	
	
	@RequestMapping(value="/faqwrite.go")
	public String faqwrite() {
		
		return"/faq/faqWrite";
	}
	
	
	@PostMapping(value="faqwrite.do")
	public ModelAndView writedo(@RequestParam Map<String, String> param, HttpSession session) {
		logger.info("param {}", param);
		
		
		return faqService.write(param, session);
	}	
	
	@GetMapping(value="/faq/faqDetail.go")
	public ModelAndView detail(String faq_no) {
		logger.info("idx="+faq_no);
		return faqService.detail(faq_no);
	}
	
	
	@PostMapping("/faq/deleteFaq.ajax")
	@ResponseBody
	public ResponseEntity<String> deleteFAQs(@RequestBody List<Integer> faqNos) {
	    try {
	        faqService.deleteFAQs(faqNos);
	        return ResponseEntity.ok("삭제 성공");
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패: " + e.getMessage());
	    }
	}
	
	

}
