package com.connec.tel.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import io.opentelemetry.sdk.trace.data.EventData;


@Mapper
public interface CalendarDAO {
	List<Map<String, Object>> getEvents(String emp_no);

	void addEvent(String cal_content, LocalDateTime cal_start, LocalDateTime cal_end, String emp_no);

	void deleteEvent(Long id);

	void updateParty(int cal_no, String emp_no);

	List<String> getParties(long id);

	void deptInsert(String cal_no, String dept_code);

	void editEvent(String cal_no, String cal_content, LocalDateTime cal_start, LocalDateTime cal_end, String emp_no);

	void deleteParties(Long id);

	void deleteParty(Long id);

	List<Map<String, Object>> getShare(String emp_no);

	Map<String, Object> getEvent(String cal_no, String emp_no);

	void deptShare(String cal_no);

	void partyShare(int cal_no);

	void deleteShare(Long id);



}
