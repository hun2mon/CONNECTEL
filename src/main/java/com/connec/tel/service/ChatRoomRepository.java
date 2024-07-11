package com.connec.tel.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.connec.tel.controller.NoticeController;
import com.connec.tel.dao.MessengerDAO;
import com.connec.tel.dto.ChatRoom;
import com.connec.tel.dto.EmpDTO;

@Repository
public class ChatRoomRepository {
	
	@Autowired MessengerDAO msgDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired NoticeController notiController;

	 public List<ChatRoom> findAllRoom(String emp_no) {
	     List<ChatRoom> chatRooms = msgDAO.chatRoomList(emp_no);
	     return chatRooms;
	 }
	
	 public Map<String, ChatRoom> findRoomById(String id, HttpSession session) {
		 Map<String, ChatRoom> map = new HashMap<String, ChatRoom>();
		 EmpDTO dto = (EmpDTO) session.getAttribute("loginInfo");
		 msgDAO.updateEnterDate(id,dto.getEmp_no());
		 ChatRoom chatRoom = msgDAO.getChatRoom(id);
		 map.put("chatRoom", chatRoom);
	     return map;
	 }
	
	 public ChatRoom createChatRoom(String name, List<String> memberList) {
	     ChatRoom chatRoom = ChatRoom.create(name);
	     
	     String roomId = chatRoom.getRoomId();
	     
	     String emp_no =  (String) memberList.get(0);
	     logger.info("emp_on : {}", emp_no);
	     msgDAO.createRoom(roomId, emp_no);
	     
	     for (String member : memberList) {
			msgDAO.addMember(roomId,member,name);
		}
	     
	     
	     
	     return chatRoom;
	 }
	
	public void addMsg(String roomId, String emp_no, String sendMessage, String msg_type) {
		
		Date today = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		int compare = 0;
		
		msgDAO.addMsg(roomId, emp_no, sendMessage, msg_type);
		
	}

	public Map<String, Object> contentsCall(String roomId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ChatRoom> list = msgDAO.contentsCall(roomId);
		map.put("list", list);
		return map;
	}

	public List<EmpDTO> chatMemberList(String roomId) {
		return msgDAO.chatMemberList(roomId);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> plusMember(Map<String, Object> params) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<String> plusMemberList = (List<String>) params.get("plusMemberList");
		String chat_no = (String) params.get("chat_no");
		String room_name = (String) params.get("room_name");
		
		for (String member : plusMemberList) {
			msgDAO.addMember(chat_no, member, room_name);
		}
		
		map.put("msg", "인원이 추가되었습니다.");
		
		return map;
	}

	public Map<String, Object> roomNameChange(Map<String, Object> param) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int row = msgDAO.roomNameChange(param);
		
		if (row > 0) {
			map.put("msg", "변경이 완료 되었습니다.");
		}
		
		return map;
	}

	public Map<String, Object> outRoom(Map<String, Object> param) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		msgDAO.outRoom(param);
		
		return map;
	}

}
