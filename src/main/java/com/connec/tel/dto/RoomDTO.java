package com.connec.tel.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class RoomDTO {
	private int room_no;
	private char room_status;
	private int res_no;
	private Timestamp stay_check_in;
	
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
