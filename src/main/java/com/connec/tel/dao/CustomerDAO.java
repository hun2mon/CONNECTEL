package com.connec.tel.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.AnnDTO;

@Mapper
public interface CustomerDAO {

	List<AnnDTO> noticelist(int pagePerCnt, int currPage);

	Object noticeCount(int pagePerCnt);

	List<AnnDTO> noticeSearch(String textval);

	AnnDTO noticedetail(String ann_no);

	void bHit(String ann_no);

	String noticephoto(String ann_no);
	
	
	

}
