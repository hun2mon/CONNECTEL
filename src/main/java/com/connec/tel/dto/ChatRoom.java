package com.connec.tel.dto;

import java.sql.Timestamp;
import java.util.UUID;

import org.apache.ibatis.type.Alias;

@Alias(value = "chatRoom")
public class ChatRoom {
	private String roomId;
	private String name;
	private String room_name;
	private String content_no;
	private String chat_no;
	private String emp_no;
	private String chat_content;
	private String eName;
	private Timestamp chat_date;
	private String msg_type;
	private String profile_img;
	

	public static ChatRoom create(String name) {
		ChatRoom chatRoom = new ChatRoom();
		chatRoom.roomId = UUID.randomUUID().toString();
		chatRoom.name = name;
		return chatRoom;
	}


	public String getRoomId() {
		return roomId;
	}


	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getContent_no() {
		return content_no;
	}


	public void setContent_no(String content_no) {
		this.content_no = content_no;
	}


	public String getChat_no() {
		return chat_no;
	}


	public void setChat_no(String chat_no) {
		this.chat_no = chat_no;
	}


	public String getEmp_no() {
		return emp_no;
	}


	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}


	public String getChat_content() {
		return chat_content;
	}


	public void setChat_content(String chat_content) {
		this.chat_content = chat_content;
	}


	public String geteName() {
		return eName;
	}


	public void seteName(String eName) {
		this.eName = eName;
	}


	public Timestamp getChat_date() {
		return chat_date;
	}


	public void setChat_date(Timestamp chat_date) {
		this.chat_date = chat_date;
	}


	public String getMsg_type() {
		return msg_type;
	}


	public void setMsg_type(String msg_type) {
		this.msg_type = msg_type;
	}


	public String getProfile_img() {
		return profile_img;
	}


	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}


	public String getRoom_name() {
		return room_name;
	}


	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
}
