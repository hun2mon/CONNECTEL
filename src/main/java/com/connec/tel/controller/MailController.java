package com.connec.tel.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.connec.tel.service.MailService;

@Controller
public class MailController {
	
	@Autowired MailService mailService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@PostMapping(value = "/mail/mail.do")
	public String mail(@RequestParam Map<String, String>param,
			@RequestParam("multipartFiles") List<MultipartFile> files, Model model) {
		
		logger.info("mail 전송 요청");
		logger.info("param : {}",param);
		String[] receiverList = param.get("email").split(",");
		mailService.mail(param,receiverList,files);
		
		return null;
	}
	
	

}
