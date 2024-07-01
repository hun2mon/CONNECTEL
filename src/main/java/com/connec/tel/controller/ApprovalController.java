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
	
	
	//결재선 저장
	@GetMapping(value = "/approval/appLineSave.ajax")
	@ResponseBody
	public Map<String,Object> appLineSave(String[] appLine, String name){
		return appService.appLineSave(appLine, name);
	}
	
	//저장된 결재선 리스트 불러오기
	@GetMapping(value = "/approval/lineCall.ajax")
	@ResponseBody
	public Map<String, Object> lineCall(HttpSession session){
		logger.info("lineCall===============================");
		EmpDTO empDTO = (EmpDTO) session.getAttribute("loginInfo");
		
		return appService.lineCall(empDTO.getEmp_no());
	}
	
	//저장된 결재자 불러오기
	@GetMapping(value = "/approval/saveListCall.ajax")
	@ResponseBody
	public Map<String, Object> saveListCall(int app_line_no){
		logger.info("app_line_no : {}", app_line_no);
		return appService.saveListCall(app_line_no);
	}
	
	//저장된 결재선 삭제
	@GetMapping(value = "/approval/savaLineDel.ajax")
	@ResponseBody
	public Map<String, Object> saveListDel(int app_line_no) {
		logger.info("app_line_no : {}", app_line_no);
		return appService.savaLineDel(app_line_no);
	}
	
	//기안서 작성
	@PostMapping(value = "/approval/draftWrite.ajax")
	@ResponseBody
	public Map<String, Object> draftWrite(@RequestBody Map<String, Object> params){
		return appService.draftWrite(params);
		
	}	
	
	// 기안서 첨부파일 저장
	@PostMapping(value = "approval/fileSave")
	public String fileSave(MultipartFile[] app_file, String draft_no) {
		logger.info("app_file : {}", app_file.length);
		logger.info("draft_no : {}", draft_no);
		return appService.fileSave(app_file, draft_no);
	}
	
	// 내 기안문 리스트
	@GetMapping(value = "/approval/myAppListCall.ajax")
	@ResponseBody
	public Map<String, Object> myAppListCall(String search,String page, String cnt, String cate,HttpSession session){
		EmpDTO empDTO = (EmpDTO) session.getAttribute("loginInfo"); 
		String emp_no = empDTO.getEmp_no();
		return appService.myAppListCall(search, page, cnt, emp_no, cate);
	}
	
	// 기안문 상세보기
	@GetMapping(value = "/approval/draftDetail")
	public ModelAndView draftDetail(String draft_no, String draft_status) {
		logger.info("draft_no : {}", draft_no);
		logger.info("draft_status : {}", draft_status);
		return appService.draftDetail(draft_no, draft_status);
	}
	
	//결재자 불러오기
	@GetMapping(value = "/approval/approverCall.ajax")
	@ResponseBody
	public Map<String, Object> approverCall(String draft_no){
		logger.info("draft_no : {}", draft_no);
		return appService.approverCall(draft_no);
	}
	
	//결재 요청온 문서 리스트
	@GetMapping(value = "/approval/reqAppListCall.ajax")
	@ResponseBody
	public Map<String, Object> reqAppListCall(String search,String page, String cnt, String cate,HttpSession session){
		EmpDTO empDTO = (EmpDTO) session.getAttribute("loginInfo"); 
		String emp_no = empDTO.getEmp_no();
		return appService.reqAppListCall(search, page, cnt, emp_no, cate);
	}
	
	//결재 승인
	@PostMapping(value = "/approval/approve.ajax")
	@ResponseBody
	public Map<String, Object> approve(@RequestParam Map<String, Object> param){
		
		return appService.approve(param);
	}
	
	//결재 반려
	@PostMapping(value = "/approval/comapnion.ajax")
	@ResponseBody
	public Map<String, Object> comapnion(@RequestParam Map<String, String> param){
		logger.info("param : {}", param);
		return appService.companion(param);
	}
	
	
	//결재 요청온 문서 리스트
	@GetMapping(value = "/approval/availableViewListCall.ajax")
	@ResponseBody
	public Map<String, Object> availableViewListCall(String search,String page, String cnt, String cate,HttpSession session){
		EmpDTO empDTO = (EmpDTO) session.getAttribute("loginInfo"); 
		String emp_no = empDTO.getEmp_no();
		String dept_code = String.valueOf(empDTO.getDept_code()); 
		return appService.availableViewListCall(search, page, cnt, emp_no, cate, dept_code);
	}
		
	//결재 반려 사유 불러오기
	@PostMapping(value = "/approval/compReason.ajax")
	@ResponseBody
	public Map<String, Object> compReason(String draft_no){
		logger.info("draft_no :{}", draft_no);
		return appService.compReason(draft_no);
	}
	
	//임시저장 결재자 호출
	@PostMapping(value = "/approval/compApproverCall.ajax")
	@ResponseBody
	public Map<String, Object> compApproverCall(String draft_no){
		logger.info("darft_no : {}", draft_no);
		return appService.compApproverCall(draft_no);
	}
	
	
	//임시저장 문서 삭제
	@PostMapping(value = "/approval/delDraft.ajax")
	@ResponseBody
	public Map<String, Object>delDraft(String draft_no){
		logger.info("draft_no : {}", draft_no);
		return appService.delDraft(draft_no);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
