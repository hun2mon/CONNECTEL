package com.connec.tel.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.connec.tel.dao.MessengerDAO;
import com.connec.tel.dto.ChatRoom;

@Repository
public class ChatRoomRepository {
	
	@Autowired MessengerDAO msgDAO;
	Logger logger = LoggerFactory.getLogger(getClass());

	 public List<ChatRoom> findAllRoom() {
	     List<ChatRoom> chatRooms = msgDAO.chatRoomList();
	     return chatRooms;
	 }
	
	 public Map<String, ChatRoom> findRoomById(String id) {
		 Map<String, ChatRoom> map = new HashMap<String, ChatRoom>();
		 ChatRoom chatRoom = msgDAO.getChatRoom(id);
		 map.put("chatRoom", chatRoom);
	     return map;
	 }
	
	 public ChatRoom createChatRoom(String name, String emp_no) {
		 logger.info("emp_no : {}", emp_no);
	     ChatRoom chatRoom = ChatRoom.create(name);
	     String roomId = chatRoom.getRoomId();
	     
	     msgDAO.createRoom(roomId, name, emp_no);
	     
	     return chatRoom;
	 }
	
	public void addMsg(String roomId, String emp_no, String sendMessage) {
		msgDAO.addMsg(roomId, emp_no, sendMessage);
	}

	public Map<String, Object> contentsCall(String roomId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ChatRoom> list = msgDAO.contentsCall(roomId);
		map.put("list", list);
		return map;
	}

}
