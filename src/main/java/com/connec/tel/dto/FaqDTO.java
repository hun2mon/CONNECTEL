package com.connec.tel.dto;

import org.apache.ibatis.type.Alias;

@Alias("faqDTO")
public class FaqDTO {
	private int FAQ_no;
	private String FAQ_subject;
	private String FAQ_content;
	private String register;
	public int getFAQ_no() {
		return FAQ_no;
	}
	public void setFAQ_no(int fAQ_no) {
		FAQ_no = fAQ_no;
	}
	public String getFAQ_subject() {
		return FAQ_subject;
	}
	public void setFAQ_subject(String fAQ_subject) {
		FAQ_subject = fAQ_subject;
	}
	public String getFAQ_content() {
		return FAQ_content;
	}
	public void setFAQ_content(String fAQ_content) {
		FAQ_content = fAQ_content;
	}
	public String getRegister() {
		return register;
	}
	public void setRegister(String register) {
		this.register = register;
	}
	
	
}
