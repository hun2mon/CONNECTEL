package com.connec.tel.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.MainDTO;

@Mapper
public interface MainDAO {

	List<MainDTO> getAllSchedules();

	List<MainDTO> getThisWeek(String format, String format2);

	List<MainDTO> getToday(String format);

	List<MainDTO> getTomorrow(String format);


}
