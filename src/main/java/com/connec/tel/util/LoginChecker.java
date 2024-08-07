package com.connec.tel.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class LoginChecker implements HandlerInterceptor{
	
Logger logger = LoggerFactory.getLogger(getClass());

	
	// 컨트롤러를 거치기 전에 이곳을 들른다.
	// 반환값이 false면 컨트롤러에 접근할 수 없다.(하얀 화면을 보여줌)
	// 그래서 false 로 컨트롤러에 가지 못하게 한 다음 response를 이용해서 다른곳으로 보내는게 일반적이다.
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler)
			throws Exception {
		
		boolean pass = true;

		logger.info("=========PRE HANDLER==========");
		
		HttpSession session = req.getSession();
		
		if (session.getAttribute("loginInfo") == null) {
			pass = false;
			resp.sendRedirect("/"); //context 경로가 있다면 같이 넣어줘야 한다. /15_TotalBoard_/
		}
		
		return pass;
	}
	
	

}
