package com.connec.tel.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.connec.tel.dao.CalendarDAO;
import com.connec.tel.dto.CalendarDTO;

import io.opentelemetry.sdk.trace.data.EventData;

@Service
public class CalendarService {

	@Autowired
	CalendarDAO calendarDAO;
	Logger logger = LoggerFactory.getLogger(getClass());

	public void deleteEvent(Long id) {
		calendarDAO.deleteEvent(id);
		calendarDAO.deleteParties(id);
	}

	public List<Map<String, Object>> getEvents(String emp_no) {
	    List<Map<String, Object>> events = new ArrayList<>();

	    // 두 번째 리스트 가져오기
	    List<Map<String, Object>> shareList = calendarDAO.getShare(emp_no);
	    events.addAll(shareList); // 리스트 합치기

	    return events;
	}


	public void addEvent(String cal_content, LocalDateTime cal_start, LocalDateTime cal_end, String emp_no) {
		calendarDAO.addEvent(cal_content, cal_start, cal_end, emp_no);
		
	}

	public Map<String, Object> updateParty(Map<String, Object> param) {
		Map<String, Object> map = new HashMap<String, Object>();

		logger.info("param : {}", param);
		@SuppressWarnings("unchecked")
		List<Map<String, String>> params = (List<Map<String, String>>) param.get("participants");

		List<String> emp_nos = params.stream().map(p -> p.get("emp_no")).collect(Collectors.toList());
		List<String> names = params.stream().map(p -> p.get("name")).collect(Collectors.toList());

		String emp_no = "";
	    int cal_no;

	    if (param.get("id") instanceof Integer) {
	        cal_no = (int) param.get("id");
	    } else {
	        cal_no = Integer.parseInt((String) param.get("id"));      
	    }
		logger.info("cal_no : " + cal_no);
		calendarDAO.partyShare(cal_no);


		for (int i = 0; i < emp_nos.size(); i++) {
			emp_no = String.valueOf(emp_nos.get(i));
			calendarDAO.updateParty(cal_no, emp_no);
		}


		return map;
	}

	public List<String> getParties(long id) {
		logger.info("asdasd"+id);
		return calendarDAO.getParties(id);
	}

	public void deptInsert(String cal_no, String dept_code) {
		
		calendarDAO.deptInsert(cal_no,dept_code);
		calendarDAO.deptShare(cal_no);
	}

	public void editEvent(String cal_no, String cal_content, LocalDateTime cal_start, LocalDateTime cal_end,
			String emp_no) {
		calendarDAO.editEvent(cal_no, cal_content, cal_start, cal_end, emp_no);

		
	}

	public void deleteParties(Long id) {
		calendarDAO.deleteParty(id);
		calendarDAO.deleteShare(id);
	}

	public Map<String, Object> getEvent(String cal_no, String emp_no) {
		return calendarDAO.getEvent(cal_no,emp_no);
	}

	public List<Map<String, Object>> getDays(String cal_no) {
		return calendarDAO.getDays(cal_no);
	}


}
