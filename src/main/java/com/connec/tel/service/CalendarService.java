package com.connec.tel.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.connec.tel.dao.CalendarDAO;

@Service
public class CalendarService {
	
	@Autowired CalendarDAO calendarDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	

	public void deleteEvent(Long id) {
		calendarDAO.deleteEvent(id);
	}


	public List<Map<String, Object>> getEvents(String start, String end) {
		return calendarDAO.getEvents(start,end);
	}


	public void addEvent(String title, String start, String end) {
		calendarDAO.addEvent(title,start,end);
	}

	


}
