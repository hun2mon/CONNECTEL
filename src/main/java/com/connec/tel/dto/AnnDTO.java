package com.connec.tel.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("annDTO")
public class AnnDTO {
	private String ann_no;
	private String register;
	private String ann_subject;
	private String ann_content;
	private String ann_bHit;
	private String ann_division;
	private String ann_fixed;
	private String ann_date;
	private String updater;
	private String update_date;
	public String getAnn_no() {
		return ann_no;
	}
	public void setAnn_no(String ann_no) {
		this.ann_no = ann_no;
	}
	public String getRegister() {
		return register;
	}
	public void setRegister(String register) {
		this.register = register;
	}
	public String getAnn_subject() {
		return ann_subject;
	}
	public void setAnn_subject(String ann_subject) {
		this.ann_subject = ann_subject;
	}
	public String getAnn_content() {
		return ann_content;
	}
	public void setAnn_content(String ann_content) {
		this.ann_content = ann_content;
	}
	public String getAnn_bHit() {
		return ann_bHit;
	}
	public void setAnn_bHit(String ann_bHit) {
		this.ann_bHit = ann_bHit;
	}
	public String getAnn_division() {
		return ann_division;
	}
	public void setAnn_division(String ann_division) {
		this.ann_division = ann_division;
	}
	public String getAnn_fixed() {
		return ann_fixed;
	}
	public void setAnn_fixed(String ann_fixed) {
		this.ann_fixed = ann_fixed;
	}
	public String getAnn_date() {
		return ann_date;
	}
	public void setAnn_date(String ann_date) {
		this.ann_date = ann_date;
	}
	public String getUpdater() {
		return updater;
	}
	public void setUpdater(String updater) {
		this.updater = updater;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	
	


}
