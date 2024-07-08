package com.connec.tel.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias(value ="notice")
public class NoticeDTO {

	private String message;
	private String emp_no;
	private String noti_content;
	private Date noti_date;
	
	
	
	
	
	

	public void setMessage(String message) {
		this.message = message;
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}

	public String getNoti_content() {
		return noti_content;
	}

	public void setNoti_content(String noti_content) {
		this.noti_content = noti_content;
	}

	public Date getNoti_date() {
		return noti_date;
	}

	public void setNoti_date(Date noti_date) {
		this.noti_date = noti_date;
	}

	public String getMessage() {
		return message;
	}

	public void setMessageContent(String message) {
		this.message = message;
	}
	
	
	
}
