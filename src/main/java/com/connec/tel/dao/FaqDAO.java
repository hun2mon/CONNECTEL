package com.connec.tel.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.FaqDTO;


@Mapper
public interface FaqDAO {


	List<FaqDTO> list(int pagePerCnt, int currPage);

	Object allCount(int pagePerCnt);

	int write(Map<String, String> param);

	FaqDTO detail(String faq_no);


	void deleteFAQs(List<Integer> faqNos);



}
