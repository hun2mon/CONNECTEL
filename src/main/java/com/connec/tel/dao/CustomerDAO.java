package com.connec.tel.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.AnnDTO;
import com.connec.tel.dto.GuestManageDTO;

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
	
	
	

}
