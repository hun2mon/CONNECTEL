package com.connec.tel.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.connec.tel.dto.FaqDTO;


@Mapper
public interface FaqDAO {

	List<FaqDTO> list(int pagePerCnt, int currPage, String category);

	Object allCount(int pagePerCnt, String category);
    int write(Map<String, String> param);    
    
    int searchCount(@Param("textval") String textval);
    int deleteFaqs(List<Integer> faqNos);

	List<FaqDTO> faqsearch(String textval);

	FaqDTO faqDetail(String faq_no);

	FaqDTO faqupdate(String faq_no);

	FaqDTO getFaqById(String faq_no);

	public void updateFaq(@Param("faqDTO") FaqDTO faqDTO, 
            @Param("faq_subject") String faqSubject,
            @Param("faq_content") String faqContent,
            @Param("faq_category") String faqCategory, 
            @Param("faq_no") String faq_no);

}
