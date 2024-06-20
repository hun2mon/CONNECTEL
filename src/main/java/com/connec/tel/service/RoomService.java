package com.connec.tel.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.connec.tel.dao.RoomDAO;
import com.connec.tel.dto.RoomDTO;

@Service
public class RoomService {

	@Autowired RoomDAO roomDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public Map<String, Object> liveRoomManageAjax() {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<RoomDTO> list = roomDAO.liveRoomManageAjax();
		
		map.put("list", list);
		
		return map;
	}
	
}
