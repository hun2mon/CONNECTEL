package com.connec.tel.service;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.dao.LoginDAO;

@Service
public class LoginService {
	
	@Autowired LoginDAO loginDAO;
	@Autowired PasswordEncoder encoder;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	public ModelAndView login(String id, String pw, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		String loadPw = loginDAO.loadPw(id);
		String page = "redirect:/main";
		
		if (loadPw != null) {
			if (encoder.matches(pw, loadPw)) {
				logger.info("일치");
				session.setAttribute("emp_no", "1");		
			} else {
				logger.info("불일치");
				page = "redirect:/";
			}			
		}
		mav.setViewName(page);
		return mav;
	}


	public void join(String pw) {
		
		String hash = encoder.encode(pw);
		logger.info("hash: {}", hash);
		
		loginDAO.join(hash);
		
	}

}
