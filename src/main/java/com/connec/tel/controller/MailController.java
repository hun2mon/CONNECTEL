package com.connec.tel.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
		
		// 실해시켜보고
		
		logger.info("mail 전송 요청");
		logger.info("mailDTO : {}",mailDTO);
		String[] receiverList = mailDTO.getMail_receiver().split(",");
		List<String> emailList = new ArrayList<String>();

	    for (String receiver : receiverList) {
	        int start = receiver.indexOf('"');
	        int end = receiver.indexOf('"', start + 1);
	        if (start != -1 && end != -1) {
	            String email = receiver.substring(start + 1, end);
	            emailList.add(email);
	        }
	    }

	    logger.info("추출된 이메일 주소 : {}", emailList);
		
		EmpDTO emp = (EmpDTO) session.getAttribute("loginInfo");
		String emp_no = emp.getEmp_no();
		mailDTO.setEmp_no(emp_no);
		mailService.mail(mailDTO,emailList,files);

		
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
	
	@PostMapping(value = "/mail/TempMailList.ajax")
	@ResponseBody
	public Map<String, Object> TempMailList(String search, String page, String cnt, HttpSession session) {
		logger.info("sendMailList 요청!");
		logger.info("search : "+ search);
		logger.info("search : "+ page);
		logger.info("search : "+ cnt);		
		
		EmpDTO emp = (EmpDTO) session.getAttribute("loginInfo");
		String emp_no = emp.getEmp_no();
		
		return mailService.TempMailList(search,page,cnt,emp_no);
	}
	
	@GetMapping(value = "/mail/mailDetail.go")
	public String mailDetail(String mail_no, Model model) {
		logger.info("mailDetail 요청!");
		logger.info("mail_no : "+ mail_no);
		
		
		MailDTO dto = mailService.mailDetail(mail_no);
		List<String> list = mailService.mailFile(mail_no);
		model.addAttribute("info", dto);
		model.addAttribute("list", list);
		
		return "/mail/mailDetail";
	}
	
	@GetMapping(value = "/mail/mail_delete.do")
	public String mail_delete(String mail_no, Model model) {
		logger.info("mail_delete 요청!");
		logger.info("mail_no : "+ mail_no);
		
		
		mailService.mail_delete(mail_no);
		model.addAttribute("msg", "1개의 메일을 삭제하였습니다.");
		
		
		return "/mail/sendMailList";
	}
	
	@GetMapping(value = "/mail/sendMail")
	public String sendMailGO(@RequestParam List<String> receivers ,Model model) {
		logger.info("sendMailGO 요청!");
		logger.info("receivers : {}", receivers);
		

		model.addAttribute("receivers", receivers);
		
		
		return "/mail/sendMail";
	}
	
	@PostMapping(value = "/mail/mail_all_delete.ajax")
	@ResponseBody
	public Map<String, Object> mail_all_delete(@RequestBody Map<String, Object> param) {
		logger.info("param : {}" ,param);
		
		List<String> mail_no = (List<String>) param.get("mail_no");
		logger.info("mail_no : {}" ,mail_no);
		
		return mailService.mail_all_delete(mail_no);
	}
	
	@PostMapping(value = "/mail/mailTempSave.ajax")
	@ResponseBody
	public Map<String, Object> mailTempSave(@RequestParam Map<String, Object>param,
										HttpSession session) {
		logger.info("param : {}" ,param);
		
		EmpDTO emp = (EmpDTO) session.getAttribute("loginInfo");
		String emp_no = emp.getEmp_no();
		
		param.put("emp_no", emp_no);
		
		return mailService.mailTempSave(param);
	}
	
	@PostMapping(value = "/mail/clientAddListCall.ajax")
	@ResponseBody
	public Map<String, Object> clientAddListCall() {
		logger.info("고객주소록 요청!!");
		
		return mailService.clientAddListCall();
	}
	
	@PostMapping(value = "/mail/addAddress.ajax")
	@ResponseBody
	public Map<String, Object> addAddress(@RequestParam Map<String, Object> param, HttpSession session) {
		logger.info("addAddress!! 요청");
		logger.info("param : {}" ,param);
		
		EmpDTO emp = (EmpDTO) session.getAttribute("loginInfo");
		String emp_no = emp.getEmp_no();
		
		param.put("emp_no", emp_no);
		
		return mailService.addAddress(param);
	}
	
	@PostMapping(value = "/mail/myAddressList.ajax")
	@ResponseBody
	public Map<String, Object> myAddressList(String search, String page, String cnt, HttpSession session) {
		logger.info("sendMailList 요청!");
		logger.info("search : "+ search);
		logger.info("search : "+ page);
		logger.info("search : "+ cnt);		
		
		EmpDTO emp = (EmpDTO) session.getAttribute("loginInfo");
		String emp_no = emp.getEmp_no();
		
		return mailService.myAddressList(search,page,cnt,emp_no);
	}
	
	@PostMapping(value = "/mail/clentList.ajax")
	@ResponseBody
	public Map<String, Object> clentList(String search, String page, String cnt) {
		logger.info("clentList 요청!");
		logger.info("search : "+ search);
		logger.info("search : "+ page);
		logger.info("search : "+ cnt);		

		
		return mailService.clentList(search,page,cnt);
	}
	

}
