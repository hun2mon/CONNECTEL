package com.connec.tel.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface CalendarDAO {
	List<Map<String, Object>> getEvents(String start, String end);

	void addEvent(String title, String start, String end);

	void deleteEvent(Long id);


}
