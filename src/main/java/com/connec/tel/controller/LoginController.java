package com.connec.tel.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.service.LoginService;

@Controller
public class LoginController {
	
	@Autowired LoginService loginService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value = "/")
	public String login() {
		return "login/login";
	}
	
	@PostMapping(value = "/login.do")
	public ModelAndView loginDo(String id, String pw, HttpSession session) {
		logger.info("id : {}", id);
		logger.info("pw : {}", pw);
		return loginService.login(id,pw, session);
	}
	
	@GetMapping(value = "/logout.do")
	public String logout(HttpSession session) {
		
		session.removeAttribute("loginInfo");
		
		return "redirect:/";
	}

}
