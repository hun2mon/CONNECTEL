package com.connec.tel.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.connec.tel.dto.EmpDTO;
import com.connec.tel.service.EmpService;

@Controller
public class EmpController {

	@Autowired EmpService empService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value = "/empRegist.do")
	public String empRegist(HttpSecurity http,MultipartFile[] photos,  @RequestParam Map<String, String> param, HttpSession session) {
		try {
			http.authorizeRequests();
		} catch (Exception e) {
			e.printStackTrace();
		}
		String page = "main/main";
		
		logger.info("param :{}",param);
		 empService.empRegist(photos,param, session);
		
		
		 return page;
	}
	
	@RequestMapping(value = "/empList.ajax")
	@ResponseBody
	public Map<String, Object> empList(int page, int categoryNum) {
		logger.info("emp List 요청");
		logger.info("요청페이지 : " + page);

		logger.info("emp 검색에서 가져온 category num : " + categoryNum);
		Map<String, Object> map = null;
		int currPage = page;
			
		map = empService.empList(currPage,categoryNum);	
		
		
		return map;
	}
	
	@RequestMapping(value = "/empDetail.go")
	public String empDetail(String emp_no, Model model) {
		logger.info("emp_no : " + emp_no);
		String page = "emp/empDetail";
		
		EmpDTO dto = empService.empDetail(emp_no,model);
		
		
		model.addAttribute("emp", dto);
		
		
		return page;
	}
	
	@RequestMapping(value = "/resetPw")
	public String resetPw() {
		
		
		empService.resetPw();
		return "aa";
	}
	
	
}
