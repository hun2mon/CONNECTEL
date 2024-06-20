package com.connec.tel.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.connec.tel.service.FAQService;

@Controller
public class FAQController {
	
	@Autowired FAQService faqService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/faq.go")
	public String faqgo() {
		
		return "faqList";
	}
	
	@RequestMapping(value="/faq/faqList.ajax")
	@ResponseBody
	public Map<String, Object> faqList(){
		logger.info("faq List 요청");
		
		return faqService.list();
	}

}
