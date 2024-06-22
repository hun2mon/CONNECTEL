package com.connec.tel.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias(value = "app")
public class ApprovalDTO {
	
	private int app_line_no;
	private String emp_no;
	private String app_line_name;
	private Date regist_date;
	
	
	public int getApp_line_no() {
		return app_line_no;
	}
	public void setApp_line_no(int app_line_no) {
		this.app_line_no = app_line_no;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getApp_line_name() {
		return app_line_name;
	}
	public void setApp_line_name(String app_line_name) {
		this.app_line_name = app_line_name;
	}
	public Date getRegist_date() {
		return regist_date;
	}
	public void setRegist_date(Date regist_date) {
		this.regist_date = regist_date;
	}

}
