package com.connec.tel.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.connec.tel.dao.ApprovalDAO;
import com.connec.tel.dto.ApprovalDTO;
import com.connec.tel.dto.EmpDTO;

@Service
public class ApprovalService {

	@Autowired ApprovalDAO appDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	public Map<String, Object> appLineSave(String[] appLine, String name) {
		Map<String, Object> map = new HashMap<String, Object>();
		ApprovalDTO appDTO = new ApprovalDTO();
		
		appDTO.setApp_line_name(name);
		appDTO.setEmp_no(appLine[0]);
		
		appDAO.appLineName(appDTO);
		
		int idx = appDTO.getApp_line_no();
		logger.info("========idx===========" + idx);
		int procedure = 1;
		int row = 0;
		for (String emp_no : appLine) {
			row = appDAO.appLineSave(idx,emp_no,procedure);
			procedure += 1;
		}
		
		
		map.put("row", row);
		
		
		
		return map;
	}
	public Map<String, Object> lineCall(String emp_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ApprovalDTO> list = appDAO.lineCall(emp_no);
		map.put("list", list);
		return map;
	}
	public Map<String, Object> saveListCall(int app_line_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<EmpDTO> list = appDAO.saveListCall(app_line_no);
		
		map.put("list", list);
		return map;
	}
	
}
