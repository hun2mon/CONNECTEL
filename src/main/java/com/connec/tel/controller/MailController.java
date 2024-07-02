package com.connec.tel.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.jsoup.helper.Validate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.connec.tel.dto.EmpDTO;
import com.connec.tel.dto.MailDTO;
import com.connec.tel.service.MailService;

@Controller
public class MailController {
	
	@Autowired MailService mailService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@PostMapping(value = "/mail/mail.do")
	public String mail(@ModelAttribute MailDTO mailDTO,
			@RequestParam("multipartFiles") List<MultipartFile> files, HttpSession session) {
		
		logger.info("mail 전송 요청");
		logger.info("mailDTO : {}",mailDTO);
		String[] receiverList = mailDTO.getMail_receiver().split(",");
		
		EmpDTO emp = (EmpDTO) session.getAttribute("loginInfo");
		String emp_no = emp.getEmp_no();
		mailDTO.setEmp_no(emp_no);
		mailService.mail(mailDTO,receiverList,files);

		
		return "/mail/mailSuccess";
	}
	
	@PostMapping(value = "/mail/sendMailList.ajax")
	@ResponseBody
	public Map<String, Object> sendMailList(String search, String page, String cnt, HttpSession session) {
		logger.info("sendMailList 요청!");
		logger.info("search : "+ search);
		logger.info("search : "+ page);
		logger.info("search : "+ cnt);		
		
		EmpDTO emp = (EmpDTO) session.getAttribute("loginInfo");
		String emp_no = emp.getEmp_no();
		
		return mailService.sendMailList(search,page,cnt,emp_no);
	}
	
	@GetMapping(value = "/mail/mailDetail.go")
	public String mailDetail(String mail_no, Model model) {
		logger.info("mailDetail 요청!");
		logger.info("mail_no : "+ mail_no);
		
		
		MailDTO dto = mailService.mailDetail(mail_no);
		model.addAttribute("info", dto);
		
		
		return "/mail/mailDetail";
	}
	
	

}
