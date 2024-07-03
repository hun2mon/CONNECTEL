package com.connec.tel.dao;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.MainDTO;

@Mapper
public interface MainDAO {

	List<MainDTO> getAllSchedules();

	List<MainDTO> getThisWeek(String format, String format2, String emp_no);

	List<MainDTO> getToday(String format, String emp_no);

	List<MainDTO> getTomorrow(String format, String emp_no);

	int totalReserve(LocalDate today);

	List<MainDTO> nowaReserve();

	int totalApproval(String emp_no);

	int draft(String emp_no);


}
