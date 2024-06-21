package com.connec.tel.service;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.connec.tel.dao.RoomDAO;
import com.connec.tel.dto.EmpDTO;
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

	public Map<String, Object> reservationList(Map<String, Object> param) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if (!param.get("name").equals("")) {
			List<RoomDTO> list = roomDAO.reservationSearchList(param);	
			map.put("list", list);
		}else {			
			List<RoomDTO> list = roomDAO.reservationList();			
			map.put("list", list);
		}
		
		return map;
	}

	public Map<String, Object> checkIn(Map<String, Object> param, HttpSession session) {
		
		String checkIn = (String) param.get("check_in");		
		logger.info("checkIn : " +checkIn);
		
		String check_in = formatCheckDate(checkIn);	
		logger.info("[service]check_in : "+check_in);
		
		String regist_date = check_in.substring(0, 10);
		logger.info("regist_date : " + regist_date);
		
		EmpDTO emp = (EmpDTO) session.getAttribute("loginInfo");
		String emp_no = emp.getEmp_no();
		
		logger.info("emp_no : " + emp_no);
		
		String room_no = (String) param.get("room_no");
		// param에 check_in 넣고 그전에 regist_date 변환해서 넣고, emp_no 넣고 그다음에는 room 상태 바꾸기
		
		param.put("check_in",check_in);
		param.put("regist_date", regist_date);
		param.put("emp_no",emp_no);
		roomDAO.checkIn(param);
		
		roomDAO.roomCheckIn(room_no);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msg", "체크인 성공");
		return map;
	}

	private String formatCheckDate(String checkDate) {
		 SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy. M. d. a h:mm:ss");
	        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        String formattedDate = null;
	        try {
	            Date date = (Date) inputFormat.parse(checkDate);
	            formattedDate = outputFormat.format(date);
	        } catch (Exception e) {
	            e.printStackTrace();

	        }
	        return formattedDate;
	    }

	public Map<String, Object> checkInInfo(String room_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		RoomDTO dto = roomDAO.checkInInfo(room_no);
		
		map.put("res_no", dto.getRes_no());
		map.put("stay_check_in",dto.getStay_check_in());
		
		return map;
	}

	public Map<String, Object> checkOut(String room_no, String res_no, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		EmpDTO emp = (EmpDTO) session.getAttribute("loginInfo");
		String emp_no = emp.getEmp_no();
		
		roomDAO.checkOut(room_no,res_no,emp_no);
		roomDAO.roomCheckOut(room_no);
		return map;
	}

	public Map<String, Object> roomStateList(String search, String page, String cnt) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int currPage = Integer.parseInt(page);
		int cntt = Integer.parseInt(cnt);
		
		int start = (currPage-1) * cntt;
		
		search = "%" + search + "%";
		
		int totalpage = roomDAO.totalPage(search, cntt);
		
		List<RoomDTO> list = roomDAO.roomStateList(search, start, cntt);
		
		map.put("list", list);
		map.put("currPage", currPage);
		map.put("totalPages", totalpage);
		return map;
	}

	public Map<String, Object> updateNotAvailable(String room_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		roomDAO.updateNotAvailable(room_no);
		
		map.put("msg","성공");
		
		return map;
	}

	public Map<String, Object> updateAvailable(String room_no) {
Map<String, Object> map = new HashMap<String, Object>();
		
		roomDAO.updateAvailable(room_no);
		
		map.put("msg","성공");
		
		return map;
	}


	
	
}
	

