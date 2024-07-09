package com.connec.tel.dto;

import java.sql.Date;
import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;


@Alias(value ="notice")
public class NoticeDTO {

	private String message;
	private String emp_no;
	private String noti_content;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private String noti_date;
    private String noti_link;
    private String noti_idx;
    
    
    
    
	public String getNoti_idx() {
		return noti_idx;
	}

	public void setNoti_idx(String noti_idx) {
		this.noti_idx = noti_idx;
	}

	public String getNoti_link() {
		return noti_link;
	}

	public void setNoti_link(String noti_link) {
		this.noti_link = noti_link;
	}

	public String getNoti_date() {
		return noti_date;
	}

	public void setNoti_date(String noti_date) {
		this.noti_date = noti_date;
	}

	public NoticeDTO(String emp_no, String noti_content, String noti_date, String noti_link) {
        this.emp_no = emp_no;
        this.noti_content = noti_content;
        this.noti_date = noti_date;
        this.noti_link = noti_link;
	}

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



	public String getMessage() {
		return message;
	}

	public void setMessageContent(String message) {
		this.message = message;
	}
	
	
	
}
