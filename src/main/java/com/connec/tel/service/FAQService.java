package com.connec.tel.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.connec.tel.dao.FaqDAO;
import com.connec.tel.dto.EmpDTO;
import com.connec.tel.dto.FaqDTO;

@Service
public class FAQService {
	
	@Autowired FaqDAO faqDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	public Map<String, Object> list(int currPage, int pagePerCnt) {
		Map<String, Object>result = new HashMap<String, Object>();
		List<FaqDTO>list =faqDAO.list(pagePerCnt, currPage);
		result.put("list", list);
		result.put("currPage", currPage);
		result.put("totalPages", faqDAO.allCount(pagePerCnt));
		
		
		return result;
	}
	public ModelAndView write(Map<String, String> param, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		EmpDTO empDTO = (EmpDTO) session.getAttribute("loginInfo");
		param.put("emp_no", empDTO.getEmp_no());
		
		int row = faqDAO.write(param);
		if (row > 0) {
			mav.setViewName("faq/faqList");
			mav.addObject("msg", "작성이 완료 되었습니다.");
		} else {
			mav.setViewName("faq/faqWrite");
			mav.addObject("msg", "작성에 실패했습니다.");
		}
		
		return mav;
	}
	public ModelAndView detail(String faq_no) {
		ModelAndView mav = new ModelAndView();
		
		FaqDTO dto = faqDAO.detail(faq_no);			
		mav.addObject("dto", dto);
		mav.setViewName("faq/faqDetail");
		return mav;
	}
	@Transactional
    public void deleteFAQs(List<Integer> faqNos) {
        faqDAO.deleteFAQs(faqNos);
    }
	
	

}
