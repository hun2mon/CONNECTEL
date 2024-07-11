package com.connec.tel.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;

import com.connec.tel.dto.ChatMessage;
import com.connec.tel.service.ChatRoomRepository;

@Controller
public class ChatController {
	
	private final SimpMessageSendingOperations messagingTemplate;
	
	
	public ChatController(SimpMessageSendingOperations messagingTemplate){
		this.messagingTemplate = messagingTemplate;
	}
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ChatRoomRepository crRepository;
	
	@MessageMapping("/chat/message")
	public void message(ChatMessage message) {
		logger.info("======roomId : {}======", message.getRoomId());
		logger.info("======sender : {}======", message.getSender());
		logger.info("======emp_no : {}======", message.getEmp_no());
		logger.info("======emp_no : {}======", message.getType());
		logger.info("======msg_type : {}======", message.getMsg_type());
		String roomId = message.getRoomId();
		String emp_no = message.getEmp_no();
		String sendMessage = message.getMessage();
		String msg_type = message.getMsg_type();
		if (ChatMessage.MessegeType.TALK.equals(message.getType())) {
			crRepository.addMsg(roomId, emp_no, sendMessage, msg_type);
			try {
				Thread.sleep(1);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		messagingTemplate.convertAndSend("/sub/chat/room/" + message.getRoomId(), message);
	}
}
