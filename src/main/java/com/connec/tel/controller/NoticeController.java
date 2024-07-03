package com.connec.tel.controller;

import java.security.Principal;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.util.HtmlUtils;

import com.connec.tel.dto.MessengerDTO;
import com.connec.tel.dto.NoticeDTO;
import com.connec.tel.service.NoticeService;

@Controller
public class NoticeController {
	
	@Autowired NoticeService noticeService;
	Logger logger = LoggerFactory.getLogger(getClass());

	
	@MessageMapping("/message")
	@SendTo("/topic/messages")
	public MessengerDTO getMessage(final NoticeDTO message) {
		
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return new MessengerDTO(HtmlUtils.htmlEscape(message.getMessageContent()));
	}
	
	@MessageMapping("/privatemessage")
	@SendTo("/topic/privatemessages")
	public MessengerDTO getPrivatetMessage(final NoticeDTO message,
											final Principal principal) {
		
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return new MessengerDTO(HtmlUtils.htmlEscape(message.getMessageContent()));
	}
}
