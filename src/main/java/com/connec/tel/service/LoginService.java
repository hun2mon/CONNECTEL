package com.connec.tel.service;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.dao.LoginDAO;
import com.connec.tel.dto.EmpDTO;

@Service
public class LoginService {
	
	@Autowired LoginDAO loginDAO;
	@Autowired PasswordEncoder encoder;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	public ModelAndView login(String id, String pw, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		EmpDTO dto = loginDAO.login(id);
		
		String page = "redirect:/main";
		
		Float leftOver = (float) 0;
		if (dto != null) {
			if (encoder.matches(pw, dto.getPassword())) {
				logger.info("일치");
				leftOver = loginDAO.leftOver(dto.getEmp_no()) ;			
				session.setAttribute("loginInfo", dto);
				session.setAttribute("leftOver", leftOver);
			} else {
				logger.info("불일치");
				page = "redirect:/";
			}			
		}
		mav.setViewName(page);
		return mav;
	}
	
}
