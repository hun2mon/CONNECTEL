package com.connec.tel.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.EmpDTO;

@Mapper
public interface CommonDAO {

	List<EmpDTO> treeCall(String search);

	List<EmpDTO> listCall(String search, int start, int cntt);

	int totalPage(String search, int cntt);

}
