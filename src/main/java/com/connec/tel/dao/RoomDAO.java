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

	List<RoomDTO> roomStateList(String search, int start, int cntt);

	void updateNotAvailable(String room_no);

	void updateAvailable(String room_no);

	int totalPage(String search, int cntt);

	List<RoomDTO> roomPirceList(Map<String, Object> param);

	void updateRoomPirceList(Map<String, Object> param);

	void insertRoomPirceList(Map<String, Object> param);

	int row(String yearMonth, String division);

	void sundayPrice(Map<String, Object> param);

	int roomPriceRow(String ddate);

	void updateRoomPrice(Map<String, Object> param);

	void weekendPrice(Map<String, Object> param);

	void weekdayPrice(Map<String, Object> param);

	void updateSundayPrice(Map<String, Object> param);

	void updateWeekendPrice(Map<String, Object> param);

	void updateWeekdayPrice(Map<String, Object> param);

	List<RoomDTO> roomPriceCalendarList(String year_month);

	void updateStay(Map<String, Object> param);


}
