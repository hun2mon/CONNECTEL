package com.connec.tel.dto;

import java.sql.Date;
import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

@Alias(value = "app")
public class ApprovalDTO {
	
	// 결재선
	private int app_line_no;
	private String emp_no;
	private String app_line_name;
	private Date regist_date;
	
	//기안서
	private String draft_no;
	private String register;
	private String draft_subject;
	private Date draft_start;
	private String draft_end;
	private String draft_content;
	private String draft_status;
	private String reason;
	private String final_approver;
	
	//휴가
	private String leave_cate;
	private Float leave_use;
	private Date leave_start;
	private Date leave_end;
	
	private String name;
	private Timestamp app_date;
	private int app_procedure;
	private String rank_name;
	
	
	
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
	public String getRegister() {
		return register;
	}
	public void setRegister(String register) {
		this.register = register;
	}
	public String getDraft_subject() {
		return draft_subject;
	}
	public void setDraft_subject(String draft_subject) {
		this.draft_subject = draft_subject;
	}
	public Date getDraft_start() {
		return draft_start;
	}
	public void setDraft_start(Date draft_start) {
		this.draft_start = draft_start;
	}
	public String getDraft_content() {
		return draft_content;
	}
	public void setDraft_content(String draft_content) {
		this.draft_content = draft_content;
	}
	public String getDraft_status() {
		return draft_status;
	}
	public void setDraft_status(String draft_status) {
		this.draft_status = draft_status;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getDraft_end() {
		return draft_end;
	}
	public void setDraft_end(String draft_end) {
		this.draft_end = draft_end;
	}
	public String getDraft_no() {
		return draft_no;
	}
	public void setDraft_no(String draft_no) {
		this.draft_no = draft_no;
	}
	public String getFinal_approver() {
		return final_approver;
	}
	public void setFinal_approver(String final_approver) {
		this.final_approver = final_approver;
	}
	public String getLeave_cate() {
		return leave_cate;
	}
	public void setLeave_cate(String leave_cate) {
		this.leave_cate = leave_cate;
	}
	public Float getLeave_use() {
		return leave_use;
	}
	public void setLeave_use(Float leave_use) {
		this.leave_use = leave_use;
	}
	public Date getLeave_start() {
		return leave_start;
	}
	public void setLeave_start(Date leave_start) {
		this.leave_start = leave_start;
	}
	public Date getLeave_end() {
		return leave_end;
	}
	public void setLeave_end(Date leave_end) {
		this.leave_end = leave_end;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Timestamp getApp_date() {
		return app_date;
	}
	public void setApp_date(Timestamp app_date) {
		this.app_date = app_date;
	}
	public int getApp_procedure() {
		return app_procedure;
	}
	public void setApp_procedure(int app_procedure) {
		this.app_procedure = app_procedure;
	}
	public String getRank_name() {
		return rank_name;
	}
	public void setRank_name(String rank_name) {
		this.rank_name = rank_name;
	}

}
