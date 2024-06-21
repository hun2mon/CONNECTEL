package com.connec.tel.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class RoomDTO {
	private int room_no;
	private char room_status;
	private int res_no;
	private Timestamp stay_check_in;
	private String cos_name;
	private String cos_phone;
	private String cos_email;
	private Date in_date;
	private Date out_date;
	private Date res_date;
	private int res_price;
	
	
	
	public String getCos_name() {
		return cos_name;
	}
	public void setCos_name(String cos_name) {
		this.cos_name = cos_name;
	}
	public String getCos_phone() {
		return cos_phone;
	}
	public void setCos_phone(String cos_phone) {
		this.cos_phone = cos_phone;
	}
	public String getCos_email() {
		return cos_email;
	}
	public void setCos_email(String cos_email) {
		this.cos_email = cos_email;
	}
	public Date getIn_date() {
		return in_date;
	}
	public void setIn_date(Date in_date) {
		this.in_date = in_date;
	}
	public Date getOut_date() {
		return out_date;
	}
	public void setOut_date(Date out_date) {
		this.out_date = out_date;
	}
	public Date getRes_date() {
		return res_date;
	}
	public void setRes_date(Date res_date) {
		this.res_date = res_date;
	}
	public int getRes_price() {
		return res_price;
	}
	public void setRes_price(int res_price) {
		this.res_price = res_price;
	}
	public int getRoom_no() {
		return room_no;
	}
	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}
	public char getRoom_status() {
		return room_status;
	}
	public void setRoom_status(char room_status) {
		this.room_status = room_status;
	}
	public int getRes_no() {
		return res_no;
	}
	public void setRes_no(int res_no) {
		this.res_no = res_no;
	}
	public Timestamp getStay_check_in() {
		return stay_check_in;
	}
	public void setStay_check_in(Timestamp stay_check_in) {
		this.stay_check_in = stay_check_in;
	}
	
}
