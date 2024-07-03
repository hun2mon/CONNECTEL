package com.connec.tel.dto;

public class MessengerDTO {

	private String content;
	
	public MessengerDTO() {
		
	}
	public MessengerDTO(String content) {
		this.content = content;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
}
