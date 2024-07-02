package com.connec.tel.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

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

 private Map<String, ChatRoom> chatRoomMap;

 @PostConstruct
 private void init() {
     chatRoomMap = new LinkedHashMap<>();
 }

 public List<ChatRoom> findAllRoom() {
     // 채팅방 생성순서 최근 순으로 반환
     List chatRooms = new ArrayList<>(chatRoomMap.values());
     Collections.reverse(chatRooms);
     return chatRooms;
 }

 public Map<String, ChatRoom> findRoomById(String id) {
	 Map<String, ChatRoom> map = new HashMap<String, ChatRoom>();
	 map.put("chatRoom", chatRoomMap.get(id));
     return map;
 }

 public ChatRoom createChatRoom(String name, String emp_no) {
	 logger.info("emp_no : {}", emp_no);
     ChatRoom chatRoom = ChatRoom.create(name);
     String roomId = chatRoom.getRoomId();
     
     msgDAO.createRoom(roomId, name, emp_no);
     chatRoomMap.put(chatRoom.getRoomId(), chatRoom);
     
     return chatRoom;
 }
}
