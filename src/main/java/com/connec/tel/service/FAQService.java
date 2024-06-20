package com.connec.tel.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.connec.tel.dao.FaqDAO;
import com.connec.tel.dto.FaqDTO;

@Service
public class FAQService {
	
	@Autowired FaqDAO faqDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	public Map<String, Object> list() {
		Map<String, Object>result = new HashMap<String, Object>();
		List<FaqDTO>list =faqDAO.list();
		result.put("list", list);
		
		return result;
	}

}
