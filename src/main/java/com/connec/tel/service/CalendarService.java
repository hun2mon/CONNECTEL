package com.connec.tel.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.connec.tel.dao.CalendarDAO;
import com.connec.tel.dto.CalendarDTO;

@Service
public class CalendarService {
	
	@Autowired CalendarDAO calendarDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public List<CalendarDTO> getEvents() {
		return calendarDAO.getEvents();
	}



	public void deleteEvent(String cal_no) {
		calendarDAO.deleteEvent(cal_no);
	}



	public void createEvent(CalendarDTO event) {
		calendarDAO.createEvent(event);
	}



	public void shareEvent(CalendarDTO dto) {
		calendarDAO.shareEvent(dto);
	}
	


}
