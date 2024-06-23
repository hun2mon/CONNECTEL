package com.connec.tel.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.connec.tel.dto.EmpDTO;
import com.connec.tel.service.ApprovalService;

@Controller
public class ApprovalController {

	@Autowired ApprovalService appService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	@PostMapping(value = "/test")
	public String test(@RequestParam List<String> emp_no, @RequestParam List<String> referrer, @RequestParam Map<String, Object> param) {
		for (String string : emp_no) {
			logger.info("emp_no : {}", string);			
		}
		
		logger.info("param : {}", param);
		
		for (String string : referrer) {
			logger.info("referrer : {}", string);			
		}
		
		return "redirect:/";		
	}
	
	@GetMapping(value = "/approval/appLineSave.ajax")
	@ResponseBody
	public Map<String,Object> appLineSave(String[] appLine, String name){
		return appService.appLineSave(appLine, name);
	}
	
	@GetMapping(value = "/approval/lineCall.ajax")
	@ResponseBody
	public Map<String, Object> lineCall(HttpSession session){
		logger.info("lineCall===============================");
		EmpDTO empDTO = (EmpDTO) session.getAttribute("loginInfo");
		
		return appService.lineCall(empDTO.getEmp_no());
	}
	
	@GetMapping(value = "/approval/saveListCall.ajax")
	@ResponseBody
	public Map<String, Object> saveListCall(int app_line_no){
		logger.info("app_line_no : {}", app_line_no);
		return appService.saveListCall(app_line_no);
	}
	
	@GetMapping(value = "/approval/savaLineDel.ajax")
	@ResponseBody
	public Map<String, Object> saveListDel(int app_line_no) {
		logger.info("app_line_no : {}", app_line_no);
		return appService.savaLineDel(app_line_no);
	}
}
