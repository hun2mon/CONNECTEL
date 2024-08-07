package com.connec.tel.dto;

import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;

@Alias(value = "calendar")
public class CalendarDTO {
	private String cal_no;
	private String cal_content;
	private LocalDateTime cal_start;
	private LocalDateTime cal_end;
	private String emp_no;
	private String dept_code;
	private String isShared;
	
	
	
	
	public String getIsShared() {
		return isShared;
	}

	public void setIsShared(String isShared) {
		this.isShared = isShared;
	}

	public String getName() {
		return name;
	}

	public String getDept_code() {
		return dept_code;
	}
	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}
	public void setName(String name) {
		this.name = name;
	}
	private String name;
	
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
