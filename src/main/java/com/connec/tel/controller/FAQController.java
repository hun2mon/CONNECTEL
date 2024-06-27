package com.connec.tel.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.dto.EmpDTO;
import com.connec.tel.dto.FaqDTO;
import com.connec.tel.service.FAQService;

@Controller
public class FAQController {
	
	@Autowired FAQService faqService;
	Logger logger = LoggerFactory.getLogger(getClass());

	@RequestMapping(value="/faq/faqList.ajax")
	@ResponseBody
	public Map<String, Object> faqList(String page, String cnt, String category){
		logger.info("faq List 요청");
		logger.info("페이지당 보여줄 갯수 : "+cnt);
		logger.info("요청 페이지 : "+page);
		logger.info("카테고리: "+category);
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		
		
		return faqService.list(currPage,pagePerCnt,category);
	}


	
	
	@RequestMapping(value="/faqwrite.go")
	public String faqwrite() {
		return"/faq/faqWrite";
	}
	
		@PostMapping(value="faqwrite.do")
		public ModelAndView writedo(@RequestParam Map<String, String> param, HttpSession session) {
			logger.info("param {}", param);
			
			EmpDTO empDTO = (EmpDTO) session.getAttribute("loginInfo");
		    if (empDTO != null) {
		        // 사용자 정보에서 register 값 설정
		        param.put("register", empDTO.getEmp_no());
		    }
	 		
			
			return faqService.write(param, session);
		}	


	@GetMapping(value="/faqDetail.go")
	public ModelAndView faqDetail(String faq_no) {
		logger.info("디테일 요청함");
		logger.info("넘버"+faq_no);
		return faqService.faqDetail(faq_no);
	}

	@PostMapping("/faq/deleteFaq.ajax")
	@ResponseBody
	public ResponseEntity<String> deleteFaq(@RequestBody List<Integer> faqNos) {
		logger.info("삭제 요청 FAQ 번호: " + faqNos);
		
		int result = faqService.deleteFaqs(faqNos);
		if (result > 0) {
			return new ResponseEntity<>("FAQ 삭제 성공", HttpStatus.OK);
		} else {
			return new ResponseEntity<>("FAQ 삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@RequestMapping(value = "/faq/search.ajax")
	@ResponseBody
	public Map<String, Object> noticeSearch(@RequestParam("textval") String textval, @RequestParam("page") String page) {
	    Map<String, Object> map = new HashMap<>();
	    faqService.search(map, textval);
	    logger.info("서칭");
	    logger.info("텍스트: " + textval);

	    return map;
	}
	
	@GetMapping("/faqupdate.go")
	public ModelAndView showUpdateForm(@RequestParam("faq_no") String faq_no) {
	    FaqDTO faq = faqService.getFaqById(faq_no);
	    logger.info("업데이트 창 이동");
	    
	    ModelAndView mav = new ModelAndView("/faq/faqEdit");
	    mav.addObject("dto", faq);
	    return mav;
	}

	@PostMapping("/faq/update.do")
	public ModelAndView updateFaq(FaqDTO faqDTO, String faq_subject, String faq_content, String faq_category, String faq_no, HttpSession session) {
	    logger.info("업데이트 시도");
	    logger.info("faq_subject :" + faq_subject);
	    logger.info("faq_content : " + faq_content);
	    logger.info("카테고리 :" + faq_category);
	    
	    faqService.updateFaq(faqDTO, faq_subject, faq_content, faq_category, faq_no, session);
	    return new ModelAndView("redirect:/faq/faqList.go");
	}


}