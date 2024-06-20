package com.connec.tel.config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.connec.tel.util.LoginChecker;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer{
	
	@Autowired LoginChecker checker;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		
		List<String> excludeList = new ArrayList<String>();
		excludeList.add("/");
		excludeList.add("/login.**"); // login. 뒤에 뭐가 오든지
		excludeList.add("/assets/**"); // resources/ 뒤에 뭐가 오든지
		excludeList.add("/dist/**");
		excludeList.add("/join.**");
		//1. 인터셉터에 등록할 로직 추가
		//2. 인터셉터가 가로챌 url 패턴 등록
		//3. 인터셉터가 예외로 둘 url 패턴 등록
		
		registry.addInterceptor(checker)
			.addPathPatterns("/**")
			.excludePathPatterns(excludeList);
		
	}
	
	

}
