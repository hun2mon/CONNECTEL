package com.connec.tel.dto;

import java.sql.Date;
import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;

@Alias(value = "main")
public class MainDTO {
	
	private String cal_no;
	private String cal_content;
	private LocalDateTime cal_start;
	private LocalDateTime cal_end;
	private String emp_no;
	private int totalReserve; // 예약 총 수를 나타내는 변수
	
	

    public int getTotalReserve() {
        return totalReserve;
    }

    public void setTotalReserve(int totalReserve) {
        this.totalReserve = totalReserve;
    }
	public Date getDate_str() {
		return date_str;
	}
	public void setDate_str(Date date_str) {
		this.date_str = date_str;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	private Date date_str;
	private int count;
	
	
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
