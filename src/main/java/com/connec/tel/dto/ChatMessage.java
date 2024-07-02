package com.connec.tel.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatMessage {
	public enum MessegeType{
		ENTER, TALK
	}
	
	private MessegeType type;
	private String roomId;
	private String sender;
	private String message;
}
