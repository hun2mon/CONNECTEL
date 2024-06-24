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
	private int type_code;
	private String yearAndmonth;
	private char dd_division;
	private int standard;
	private int superior;
	private int delux;
	private int suite;
	private String date;
	
	
	
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public char getDd_division() {
		return dd_division;
	}
	public void setDd_division(char dd_division) {
		this.dd_division = dd_division;
	}
	public String getYearAndmonth() {
		return yearAndmonth;
	}
	public void setYearAndmonth(String yearAndmonth) {
		this.yearAndmonth = yearAndmonth;
	}
	
	public int getStandard() {
		return standard;
	}
	public void setStandard(int standard) {
		this.standard = standard;
	}
	public int getSuperior() {
		return superior;
	}
	public void setSuperior(int superior) {
		this.superior = superior;
	}
	public int getDelux() {
		return delux;
	}
	public void setDelux(int delux) {
		this.delux = delux;
	}
	public int getSuite() {
		return suite;
	}
	public void setSuite(int suite) {
		this.suite = suite;
	}
	public int getType_code() {
		return type_code;
	}
	public void setType_code(int type_code) {
		this.type_code = type_code;
	}
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
