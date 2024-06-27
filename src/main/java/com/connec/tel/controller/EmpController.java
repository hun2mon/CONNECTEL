package com.connec.tel.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
	public String empRegist(MultipartFile[] photos,  @RequestParam Map<String, String> param, HttpSession session) {
		String page = "emp/empList";
		
		logger.info("param :{}",param);
		 empService.empRegist(photos,param, session);
		
		
		 return page;
	}
	
	@RequestMapping(value = "/empList.ajax")
	@ResponseBody
	public Map<String, Object> empList(int page , String searchType, String searchText, String categoryNum) {
		logger.info("Emplist 요청");
		logger.info("요청페이지 : " + page);
		logger.info("emp 검색에서 가져온 text : "+searchText);
		logger.info("emp 검색에서 가져온 type : "+searchType);
		logger.info("emp 검색에서 가져온 category num : " + categoryNum);
		logger.info("emp 검색에서 가져온 category num : " + categoryNum);
		Map<String, Object> map = null;
		int currPage = page;
			
		map = empService.empList(currPage,searchType,searchText,categoryNum);	
		
		
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
	
	@RequestMapping(value = "/resetPw.do")
	public String resetPw(String emp_no) {
		String page = "redirect:/empDetail.go?emp_no="+emp_no;
		logger.info("비밀번호 초기화 요청");
		
		empService.resetPw(emp_no);
		return page;
	}
	
	
	@RequestMapping(value = "/empEdit.go")
	public String empEdit(String emp_no, Model model) {
		logger.info("emp_no  : " + emp_no);
		String page = "emp/empEdit";
		
		EmpDTO dto = empService.empDetail(emp_no,model);
	
		model.addAttribute("emp",dto);

	
		
		return page;
	}
	@RequestMapping(value = "/empEdit.do")
	public String empEditDo(MultipartFile[] photos, @RequestParam Map<String, String> param, HttpSession session) {
		String page = "emp/empList";
		
		logger.info("param :{}",param);
		 empService.empEditDo(photos,param, session);
		
		
		 return page;

	}
	
	@RequestMapping(value = "/leaveList.ajax")
	@ResponseBody
	public Map<String, Object> leaveList(int page, String emp_no) {
		logger.info("leave List 요청");
		logger.info("요청페이지 : " + page);
		Map<String, Object> map = null;
		int currPage = page;
			
		map = empService.leaveList(currPage,emp_no);	
		
		
		return map;
	}
	
	
}
