package com.connec.tel.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.connec.tel.service.NoticeService;

@Controller
public class NoticeController {
	
	@Autowired NoticeService noticeService;
	Logger logger = LoggerFactory.getLogger(getClass());

}
