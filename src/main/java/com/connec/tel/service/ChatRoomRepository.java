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

	 public List<ChatRoom> findAllRoom(String emp_no) {
	     List<ChatRoom> chatRooms = msgDAO.chatRoomList(emp_no);
	     return chatRooms;
	 }
	
	 public Map<String, ChatRoom> findRoomById(String id) {
		 Map<String, ChatRoom> map = new HashMap<String, ChatRoom>();
		 ChatRoom chatRoom = msgDAO.getChatRoom(id);
		 map.put("chatRoom", chatRoom);
	     return map;
	 }
	
	 public ChatRoom createChatRoom(String name, List<String> memberList, String registerName) {
	     ChatRoom chatRoom = ChatRoom.create(name);
	     
	     String roomId = chatRoom.getRoomId();
	     
	     String emp_no =  (String) memberList.get(0);
	     logger.info("registerName : {}", registerName);
	     logger.info("emp_on : {}", emp_no);
	     msgDAO.createRoom(roomId, emp_no);
	     
	     int index = 1;
	     for (String member : memberList) {
			msgDAO.addMember(roomId,member,name,registerName,index);
			index += 1;
		}
	     
	     
	     
	     return chatRoom;
	 }
	
	public void addMsg(String roomId, String emp_no, String sendMessage, String msg_type) {
		msgDAO.addMsg(roomId, emp_no, sendMessage, msg_type);
	}

	public Map<String, Object> contentsCall(String roomId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ChatRoom> list = msgDAO.contentsCall(roomId);
		map.put("list", list);
		return map;
	}

}
