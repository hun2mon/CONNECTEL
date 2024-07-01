package com.connec.tel.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.dao.CustomerDAO;
import com.connec.tel.dto.AnnDTO;
import com.connec.tel.dto.EmpDTO;

@Service
public class CustomerService {
	
	@Autowired CustomerDAO customerDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	
	public Map<String, Object> noticelist(int currPage, int pagePerCnt, String ann_division, String ann_fixed, String register, String ann_date) {
		Map<String, Object>result = new HashMap<String, Object>();
		List<AnnDTO>list = customerDAO.noticelist(pagePerCnt,currPage);
		EmpDTO dto = new EmpDTO();
		String name = dto.geteName();
		result.put("list", list);
		result.put("currPage", currPage);
		result.put("ann_division", ann_division);
		result.put("ann_fixed", ann_fixed);
		result.put("totalPages", customerDAO.noticeCount(pagePerCnt));
		result.put("register", name);
		result.put("ann_date", ann_date);
		
		return result;
	}



	public Map<String, Object> noticeSearch(Map<String, Object> map, String textval) {
		List<AnnDTO> list = customerDAO.noticeSearch(textval);
		map.put("list", list);
		
		return map;
		
	}



	public ModelAndView noticeDetail(String ann_no) {
		ModelAndView mav = new ModelAndView();
		AnnDTO dto = customerDAO.noticedetail(ann_no);
		
		customerDAO.bHit(ann_no);
		logger.info("고객디테일");
		mav.addObject("dto", dto);
		mav.addObject("image", customerDAO.noticephoto(ann_no));
		mav.setViewName("/customer/noticeDetail");
		
		
		
		return mav;
	}

}
