package com.connec.tel.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;

import com.connec.tel.dto.CalendarDTO;
import com.connec.tel.service.CalendarService;

@Controller
public class CalendarController {
	
	@Autowired CalendarService calService;
	Logger logger = LoggerFactory.getLogger(getClass());

	   @GetMapping("/calendar/calendar.go")
	    public String home() {
	        logger.info("캘린더 이동");
	        return "calendar/calendar";
	    }
	    
	    @GetMapping("/events")
	    public ResponseEntity<List<CalendarDTO>> getEvents() {
	        List<CalendarDTO> events = calService.getEvents();
	        return ResponseEntity.ok(events);
	    }
	    
	    @PostMapping("/events")
	    public ResponseEntity<Void> inputCalendar(@RequestBody CalendarDTO event) {
	        calService.createEvent(event);
	        return ResponseEntity.status(201).build();
	    }
	    
	    @DeleteMapping("/events/{cal_no}")
	    public ResponseEntity<Void> deleteEvent(@PathVariable String cal_no) {
	        calService.deleteEvent(cal_no);
	        return ResponseEntity.noContent().build();
	    }
	    @PostMapping("/share")
	    public void shareEvent(@RequestBody CalendarDTO dto) {
	    	logger.info(dto + "");
	        calService.shareEvent(dto);
	    }  
	    
	}

