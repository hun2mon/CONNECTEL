package com.connec.tel.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;

import com.connec.tel.service.CalendarService;

@Controller
public class CalendarController {

	@Autowired
	CalendarService calService;
	Logger logger = LoggerFactory.getLogger(getClass());

	@GetMapping("/calendar/calendar.go")
	public String home() {
		logger.info("캘린더 이동");
		return "calendar/calendar";
	}

	@RequestMapping(value = "/addEvent", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addEvent(@RequestParam("title") String title,@RequestParam("start") String start, @RequestParam("end") String end) {
		Map<String, Object> result = new HashMap<>();
			try {
	           // DB에 일정 정보 저장
	           calService.addEvent(title, start, end);
	           result.put("success", true);
	       } catch (Exception e) {
	           e.printStackTrace();
	           result.put("success", false);
	       }

	       return result;
	   }

	@RequestMapping(value = "/getEvents", method = RequestMethod.GET)
	@ResponseBody
	public List<Map<String, Object>> getEvents(@RequestParam("start") String start, @RequestParam("end") String end) {
		// DB에서 해당 기간의 일정 정보 조회
		List<Map<String, Object>> events = calService.getEvents(start, end);
		return events;
	}

	@RequestMapping(value = "/deleteEvent", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteEvent(@RequestParam("id") Long id) {
		Map<String, Object> result = new HashMap<>();
			try {
				// DB에서 일정 정보 삭제
				calService.deleteEvent(id);
				result.put("success", true);
			} catch (Exception e) {
				e.printStackTrace();
				result.put("success", false);
			}

			return result;
	}

}
