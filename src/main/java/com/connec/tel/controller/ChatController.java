package com.connec.tel.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;

import com.connec.tel.dto.ChatMessage;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class ChatController {
	
	private final SimpMessageSendingOperations messagingTemplate = null;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@MessageMapping("/chat/message")
	public void message(ChatMessage message) {
		if (ChatMessage.MessegeType.ENTER.equals(message.getType())) {
			logger.info("sdfsdf");
			message.setMessage(message.getSender() + "님이 입장하였습니다.");
		}
		logger.info("123");
		messagingTemplate.convertAndSend("/sub/chat/room/" + message.getRoomId(), message);
	}
}
