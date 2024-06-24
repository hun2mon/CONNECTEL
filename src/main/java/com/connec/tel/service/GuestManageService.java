package com.connec.tel.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.connec.tel.dao.GuestManageDAO;
import com.connec.tel.dto.GuestManageDTO;

@Service
public class GuestManageService {
	
	@Autowired GuestManageDAO geustMngDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	public Map<String, Object> reserveList(String search, String page, String cnt, String searchDate) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int currPage = Integer.parseInt(page);
		int cntt = Integer.parseInt(cnt);
		
		int start = (currPage-1) * cntt;
		
		search = "%" + search + "%";
		
		int totalpage = geustMngDAO.totalPage(search, cntt,searchDate);
		
		List<GuestManageDTO> list = geustMngDAO.reserveList(search, start, cntt,searchDate);
		
		map.put("list", list);
		map.put("currPage", currPage);
		map.put("totalPages", totalpage);
		return map;

	}
	public Map<String, Object> reserveDelete(String res_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		geustMngDAO.reserveDelete(res_no);
	
		return map;
	}
	
	public Map<String, Object> stayList(String search, String page, String cnt, String searchDate) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int currPage = Integer.parseInt(page);
		int cntt = Integer.parseInt(cnt);
		
		int start = (currPage-1) * cntt;
		
		search = "%" + search + "%";
		
		int totalpage = geustMngDAO.stayListTotalPage(search, cntt,searchDate);
		
		List<GuestManageDTO> list = geustMngDAO.stayList(search, start, cntt,searchDate);
		
		map.put("list", list);
		map.put("currPage", currPage);
		map.put("totalPages", totalpage);
		return map;
	}

}
