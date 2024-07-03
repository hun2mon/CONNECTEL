package com.connec.tel.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.connec.tel.dao.NoticeDAO;
import com.connec.tel.dto.MessengerDTO;
import com.connec.tel.dto.NoticeDTO;

@Service
public class NoticeService {
	
	@Autowired NoticeDAO noticeDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	private final SimpMessagingTemplate messagingTemplate;
	
	public NoticeService(SimpMessagingTemplate messagingTemplate) {
		this.messagingTemplate = messagingTemplate;
	}
	
	public void notifyFrontend(final String message) {
		MessengerDTO response= new MessengerDTO(message); 
		
		messagingTemplate.convertAndSend("/topic/messages", response);
	}

}
