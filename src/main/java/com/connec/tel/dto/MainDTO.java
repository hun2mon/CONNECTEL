package com.connec.tel.dto;

import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;

@Alias(value = "main")
public class MainDTO {
	
	private String cal_no;
	private String cal_content;
	private LocalDateTime cal_start;
	private LocalDateTime cal_end;
	private String emp_no;
	
	public String getCal_no() {
		return cal_no;
	}
	public void setCal_no(String cal_no) {
		this.cal_no = cal_no;
	}
	public String getCal_content() {
		return cal_content;
	}
	public void setCal_content(String cal_content) {
		this.cal_content = cal_content;
	}
	public LocalDateTime getCal_start() {
		return cal_start;
	}
	public void setCal_start(LocalDateTime cal_start) {
		this.cal_start = cal_start;
	}
	public LocalDateTime getCal_end() {
		return cal_end;
	}
	public void setCal_end(LocalDateTime cal_end) {
		this.cal_end = cal_end;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	
	
	
	

}
