package com.connec.tel.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.AnnDTO;

@Mapper
public interface AnnDAO {

	
	int deleteempann(List<Integer> annNos);
	
	
	int deleteann(List<Integer> annNos);

	void fileWrite(String fileName, String newFileName, String ann_no);
	
	int write(AnnDTO dto);
	
	List<AnnDTO> search(String textval);

	List<AnnDTO> list(int pagePerCnt, int currPage, String ann_division, String ann_fixed, String register);

	Object allCount(int pagePerCnt);

	AnnDTO empanndetail(String ann_no);


	int count(Map<String, String> param);

	void unfixAnnouncement(Integer annNo);

	int getFixedCount();

	String photo(String ann_no);
	
	
	
	String annphoto(String ann_no);
	
	List<AnnDTO> annlist(int pagePerCnt, int currPage, String ann_division, String ann_fixed, String ann_date);

	int annwrite(AnnDTO dto);

	void annfileWrite(String fileName, String newFileName, String ann_no);

	AnnDTO anndetail(String ann_no);

	
	
	List<AnnDTO> annsearch(String textval);


	void increasebHitCount(String ann_no);


	void increaseCount(String ann_no);


	AnnDTO getannbyId(String ann_no);


	void updateann(AnnDTO annDTO, String ann_subject, String ann_content, String ann_no);


	String photoname(String ann_no);
	

}
