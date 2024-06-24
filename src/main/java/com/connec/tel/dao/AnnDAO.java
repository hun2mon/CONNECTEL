package com.connec.tel.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.AnnDTO;

@Mapper
public interface AnnDAO {

	List<AnnDTO> list(int pagePerCnt, int currPage, String ann_division, String ann_fixed);

}
