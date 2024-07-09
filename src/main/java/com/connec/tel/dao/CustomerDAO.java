package com.connec.tel.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.AnnDTO;
import com.connec.tel.dto.GuestManageDTO;
import com.connec.tel.dto.RoomDTO;

@Mapper
public interface CustomerDAO {

	List<AnnDTO> noticelist(int pagePerCnt, int currPage);

	Object noticeCount(int pagePerCnt);

	List<AnnDTO> noticeSearch(String textval);

	AnnDTO noticedetail(String ann_no);

	void bHit(String ann_no);

	String noticephoto(String ann_no);
	
	
	//여기서부터 예약관련임

	List<GuestManageDTO> room_info();

	int standard_num(String in_date, String out_date);

	int superior_num(String in_date, String out_date);

	int delux_num(String in_date, String out_date);

	int suite_num(String in_date, String out_date);

	List<GuestManageDTO> reserveListCall(Map<String, Object> param);

	GuestManageDTO getRoomPrices(String in_date, String out_date);

	Object standardphoto(String standard_photo);

	Object superiorphoto(String superior_photo);

	Object deluxphoto(String delux_no);

	Object suitephoto(String suite_no);

	Object standard_detail();

	Object superior_detail();

	Object delux_detail();

	Object suite_detail();

	Object standard_extent();

	Object superior_extent();

	Object delux_extent();

	Object suite_extent();

	Object standard_amenity();

	Object superior_amenity();

	Object delux_amenity();

	Object suite_amenity();

	Object standard_roomview();

	Object superior_roomview();

	Object delux_roomview();

	Object suite_roomview();

	int todayResSearch(String currDate);

	int todayResNumSearch(String currDate);

	int price(Object object);

	int plus_price(String date, int price, String change_room_type);


	void reservation(Map<String, Object> param);

	String getres_no(String successsend);

	RoomDTO checkReservation(String name, String phone, String reservationNo);

	RoomDTO reservedetail(String res_no);
	
	
	

}
