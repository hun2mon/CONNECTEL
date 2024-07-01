package com.connec.tel.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.GuestManageDTO;

@Mapper
public interface GuestManageDAO {

	int totalPage(String search, int cntt, String searchDate);

	List<GuestManageDTO> reserveList(String search, int start, int cntt, String searchDate);

	

	int stayListTotalPage(String search, int cntt, String searchDate);

	List<GuestManageDTO> stayList(String search, int start, int cntt, String searchDate);

	int cancelTotalPage(String search, int cntt, String searchDate);

	List<GuestManageDTO> cancelList(String search, int start, int cntt, String searchDate);

	String resCancelDate(String date);

	void reserveCancel(String res_no);

	void insert_res_cancel(String res_no, String cancelPrice);

	String selectTid(String res_no);

	List<GuestManageDTO> reserveListCall(Map<String, Object> param);

	List<GuestManageDTO> room_info();

	int standard_num(String in_date, String out_date);

	int superior_num(String in_date, String out_date);

	int delux_num(String in_date, String out_date);

	int suite_num(String in_date, String out_date);

	List<String> getDate(String today);


	

}
