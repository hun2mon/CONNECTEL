package com.connec.tel.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.connec.tel.dao.AnnDAO;
import com.connec.tel.dto.AnnDTO;

@Service
public class AnnService {
	
	@Autowired AnnDAO annDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	public Map<String, Object> list(int currPage, int pagePerCnt, String ann_division, String ann_fixed) {
		Map<String, Object>result = new HashMap<String, Object>();
		List<AnnDTO>list = annDAO.list(pagePerCnt,currPage,ann_division,ann_fixed);
		result.put("list", list);
		result.put("currPage", currPage);
		result.put("ann_division", ann_division);
		result.put("ann_fixed", ann_fixed);

		
		return result;
	}

}
