package com.connec.tel.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.EmpDTO;

@Mapper
public interface CommonDAO {

	List<EmpDTO> treeCall();

	List<EmpDTO> listCall(String search, int start, int cntt);

	int totalPage(String search, int cntt);

	void reservation(Map<String, Object> params);

	int todayResSearch(String currDate);

	int todayResNumSearch(String currDate);

}
