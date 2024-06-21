package com.connec.tel.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.RoomDTO;

@Mapper
public interface RoomDAO {

	List<RoomDTO> liveRoomManageAjax();

	List<RoomDTO> reservationList();

	List<RoomDTO> reservationSearchList(Map<String, Object> param);

	void checkIn(Map<String, Object> param);

	void roomCheckIn(String room_no);

	RoomDTO checkInInfo(String room_no);

	void checkOut(String room_no, String res_no, String emp_no);

	void roomCheckOut(String room_no);

}
