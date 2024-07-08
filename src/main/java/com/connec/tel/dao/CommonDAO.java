package com.connec.tel.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.EmpDTO;

@Mapper
public interface CommonDAO {

	List<EmpDTO> treeCall(String search);

	List<EmpDTO> listCall(String search, int start, int cntt);

	int totalPage(String search, int cntt);

	void reservation(Map<String, Object> params);

	int todayResSearch(String currDate);

	int todayResNumSearch(String currDate);

	int price(Object object);

	int plus_price(String date, int price, String change_room_type);

	void changeRoom(int res_no, int change_room, int plus_price);

}
