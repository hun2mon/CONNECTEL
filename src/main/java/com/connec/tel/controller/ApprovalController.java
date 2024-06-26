package com.connec.tel.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.dto.EmpDTO;
import com.connec.tel.service.ApprovalService;
import com.connec.tel.service.CommonService;

@Controller
public class ApprovalController {

	@Autowired ApprovalService appService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
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
	
	@GetMapping(value = "/approval/myAppListCall.ajax")
	@ResponseBody
	public Map<String, Object> myAppListCall(String search,String page, String cnt, String cate,HttpSession session){
		EmpDTO empDTO = (EmpDTO) session.getAttribute("loginInfo"); 
		String emp_no = empDTO.getEmp_no();
		return appService.myAppListCall(search, page, cnt, emp_no, cate);
	}
	
	@GetMapping(value = "/approval/draftDetail")
	public ModelAndView draftDetail(String draft_no, String draft_status) {
		logger.info("draft_no : {}", draft_no);
		logger.info("draft_status : {}", draft_status);
		return appService.draftDetail(draft_no, draft_status);
	}
	
	@GetMapping(value = "/approval/approverCall.ajax")
	@ResponseBody
	public Map<String, Object> approverCall(String draft_no){
		logger.info("draft_no : {}", draft_no);
		return appService.approverCall(draft_no);
	}
	
	@PostMapping(value = "/approval/draftWrite.ajax")
	@ResponseBody
	public Map<String, Object> draftWrite(@RequestBody Map<String, Object> params){
		return appService.draftWrite(params);
		
	}	
	
	@PostMapping(value = "approval/fileSave")
	public String fileSave(MultipartFile[] app_file, String draft_no) {
		return appService.fileSave(app_file, draft_no);
	}
}
