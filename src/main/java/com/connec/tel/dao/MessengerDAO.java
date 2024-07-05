package com.connec.tel.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.ChatRoom;

@Mapper
public interface MessengerDAO {

	void createRoom(String roomId, String emp_no);

	ChatRoom getChatRoom(String id);

	List<ChatRoom> chatRoomList(String emp_no);

	void addMsg(String roomId, String emp_no, String sendMessage, String msg_type);

	List<ChatRoom> contentsCall(String roomId);

	void addMember(String roomId, String member, String name, String registerName, int index);

}
