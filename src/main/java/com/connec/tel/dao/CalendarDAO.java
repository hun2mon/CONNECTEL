package com.connec.tel.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.CalendarDTO;

@Mapper
public interface CalendarDAO {

	List<CalendarDTO> getEvents();

	void createEvent(CalendarDTO event);

	void deleteEvent(String cal_no);

	void shareEvent(CalendarDTO dto);


}
