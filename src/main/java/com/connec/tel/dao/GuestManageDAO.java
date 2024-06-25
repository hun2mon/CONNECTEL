package com.connec.tel.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.GuestManageDTO;

@Mapper
public interface GuestManageDAO {

	int totalPage(String search, int cntt, String searchDate);

	List<GuestManageDTO> reserveList(String search, int start, int cntt, String searchDate);

	void reserveDelete(String res_no);

	int stayListTotalPage(String search, int cntt, String searchDate);

	List<GuestManageDTO> stayList(String search, int start, int cntt, String searchDate);

	

}
