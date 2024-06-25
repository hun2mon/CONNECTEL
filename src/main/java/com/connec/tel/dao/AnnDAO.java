package com.connec.tel.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.AnnDTO;

@Mapper
public interface AnnDAO {


	int deleteann(List<Integer> annNos);

	void fileWrite(String fileName, String newFileName, String ann_no);
	
	int write(AnnDTO dto);
	
	List<AnnDTO> search(String textval);

	List<AnnDTO> list(int pagePerCnt, int currPage, String ann_division, String ann_fixed, String register);

	Object allCount(int pagePerCnt);

	AnnDTO empanndetail(String ann_no);

	String photo(String ann_no);

}
