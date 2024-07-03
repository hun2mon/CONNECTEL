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
	public Object getType() {
		// TODO Auto-generated method stub
		return null;
	}
	public String getSender() {
		// TODO Auto-generated method stub
		return null;
	}
	public void setMessage(String string) {
		// TODO Auto-generated method stub
		
	}
	public String getRoomId() {
		// TODO Auto-generated method stub
		return null;
	}
}
