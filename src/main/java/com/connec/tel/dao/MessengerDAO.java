package com.connec.tel.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.ChatRoom;

@Mapper
public interface MessengerDAO {

	void createRoom(String roomId, String name, String emp_no);

	ChatRoom getChatRoom(String id);

	List<ChatRoom> chatRoomList();

	void addMsg(String roomId, String emp_no, String sendMessage);

	List<ChatRoom> contentsCall(String roomId);

}
