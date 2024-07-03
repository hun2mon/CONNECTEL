package com.connec.tel.dto;

import java.util.UUID;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias(value = "chatRoom")
public class ChatRoom {
	private String roomId;
	private String name;
	

	public static ChatRoom create(String name) {
		ChatRoom chatRoom = new ChatRoom();
		chatRoom.roomId = UUID.randomUUID().toString();
		chatRoom.name = name;
		return chatRoom;
	}


}
