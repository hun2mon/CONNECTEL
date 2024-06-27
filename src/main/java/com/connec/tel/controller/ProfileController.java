package com.connec.tel.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.connec.tel.service.ProfileService;

@Controller
public class ProfileController {
	
	@Autowired ProfileService profileService;
	Logger logger = LoggerFactory.getLogger(getClass());

	
	@GetMapping(value = "/profile/profile.go")
	public String leaveList(Model model, HttpSession session) {
		logger.info("프로필 이동!");
	    String page = "profile/profile";

	    // 세션에서 emp_no 가져오기
	    String emp_no = (String) session.getAttribute("loginInfo.emp_no");
	    logger.info("emp_no: " + emp_no);
	    
	    profileService.leaveList(model, emp_no);
	    
	    // 페이지 이름 반환
	    return page;
	}
	
	@RequestMapping(value = "/changePassword", method= RequestMethod.POST)
	public String changePw(String emp_no, String new_password) {
		String page = "redirect:/profile.go?emp_no="+emp_no;
		logger.info("비밀번호 변경하기" + new_password);
		
		profileService.changePassword(new_password,emp_no);		
		return page;
	}

	
	
}
