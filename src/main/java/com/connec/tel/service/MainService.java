package com.connec.tel.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.connec.tel.dao.MainDAO;
import com.connec.tel.dto.MainDTO;

@Service
public class MainService {
	
	@Autowired MainDAO mainDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public List<MainDTO> getAllSchedules() {
		return mainDAO.getAllSchedules();
	}

	public List<MainDTO> getThisWeek() {
		// 오늘 날짜 계산
		LocalDateTime now = LocalDateTime.now();
		
		// 이번 주의 시작일 계산(월요일)
        LocalDateTime startOfWeek = now.with(java.time.DayOfWeek.MONDAY);
        LocalDateTime endOfWeek = startOfWeek.plusDays(6);
		
		// 날짜 포맷 지정
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd-HH-mm");
		
        List<MainDTO> events = mainDAO.getThisWeek(startOfWeek.format(formatter), endOfWeek.format(formatter));


        return events;
	}

    public List<MainDTO> getToday() {
        LocalDate today = LocalDate.now();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        return mainDAO.getToday(today.format(formatter));
    }

    public List<MainDTO> getTomorrow() {
        LocalDate tomorrow = LocalDate.now().plusDays(1);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        return mainDAO.getTomorrow(tomorrow.format(formatter));
    }

	

}
