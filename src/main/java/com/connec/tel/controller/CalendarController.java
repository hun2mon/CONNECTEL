package com.connec.tel.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;

import com.connec.tel.dto.CalendarDTO;
import com.connec.tel.dto.EmpDTO;
import com.connec.tel.service.CalendarService;

import io.opentelemetry.sdk.trace.data.EventData;

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
	public Map<String, Object> addEvent(@RequestParam("cal_content") String cal_content,@RequestParam("cal_start") String cal_start,
				@RequestParam("cal_end") String cal_end, @RequestParam("emp_no") String emp_no) {
		Map<String, Object> result = new HashMap<>();
		logger.info("title : " + cal_content + "cal_start : " + cal_start + "end : " + cal_end + "emp_no : " + emp_no);
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
			try {
		        LocalDateTime startDateTime = LocalDateTime.parse(cal_start, formatter);
		        LocalDateTime endDateTime = LocalDateTime.parse(cal_end, formatter);
	           // DB에 일정 정보 저장
		        calService.addEvent(cal_content, startDateTime, endDateTime, emp_no);
	           result.put("success", true);
	       } catch (Exception e) {
	           e.printStackTrace();
	           result.put("success", false);
	       }

	       return result;
	   }
	
	
	
    @PostMapping("/removeEventParticipant")
    @ResponseBody
    public Map<String, String> removeEventParticipant(@RequestParam("eventId") int eventId, @RequestParam("name") String name) {
    	logger.info("삭제 ㄲㄲㄲㄱ");
        boolean isRemoved = calService.removeEventParticipant(eventId, name);
        if (isRemoved) {
            return Map.of("status", "success");
        } else {
            return Map.of("status", "error");
        }
    }
	
	
	@RequestMapping(value = "/getEventParticipants")
	public ResponseEntity<List<String>> getEventParticipants(@RequestParam("id") int id) {
	    try {
	        List<String> participants = calService.getParties(id);
	        return ResponseEntity.ok(participants);
	    } catch (Exception e) {
	        logger.error("Error occurred while fetching event participants", e);
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                             .body(Collections.singletonList("Error occurred while fetching event participants"));
	    }
	}
	
	@RequestMapping(value = "/updateParticipants.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateParty(@RequestBody Map<String, Object> param) {
		return calService.updateParty(param);
	}

		
	
	@RequestMapping(value = "/getEvents", method = RequestMethod.GET)
	@ResponseBody
	public List<Map<String, Object>> getEvents(@RequestParam("emp_no") String emp_no) {
		logger.info("ㅎㅇㅎㅇ~");
		List<Map<String, Object>> events = calService.getEvents(emp_no);

		return events;
	}
	
	@RequestMapping(value = "/getDays", method = RequestMethod.GET)
	@ResponseBody
	public List<Map<String, Object>> getDays(@RequestParam("cal_no") String cal_no) {
		logger.info("ㅎㅇㅎㅇ~");
		List<Map<String, Object>> events = calService.getDays(cal_no);
		logger.info("events : {}",events);

		return events;
	}
	
	@RequestMapping(value = "/getEvent", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getEvent(@RequestParam("cal_no") String cal_no, @RequestParam("emp_no") String emp_no) {
		logger.info("ㅎㅇㅎㅇ~" + cal_no + emp_no);
	    Map<String,Object> event = calService.getEvent(cal_no,emp_no);
		return event;
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
	

	@RequestMapping(value = "/insertEmployeesByDepartment", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertEmployeesByDepartment(@RequestBody Map<String, Object> requestBody) {
	    Map<String, Object> result = new HashMap<>();
	    
	    String cal_no = (String) requestBody.get("cal_no");
	    String dept_code = (String) requestBody.get("dept_code");
	    
	    logger.info("일정 번호: " + cal_no + ", 부서 코드: " + dept_code);
	    
	    try {
	        // 여기에 부서에 속한 사원을 일정에 추가하는 로직을 추가하세요
	        calService.deptInsert(cal_no, dept_code);
	        result.put("success", true);
	    } catch (Exception e) {
	        logger.error("일정에 사원 추가 중 오류 발생: " + e.getMessage());
	        result.put("success", false);
	        result.put("message", "일정에 사원을 추가하는 도중 오류가 발생했습니다.");
	    }

	    return result;
	}
	
	@RequestMapping(value = "/editEvent", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> editEvent(@RequestBody Map<String, Object> requestBody) {
	    Map<String, Object> result = new HashMap<>();
	    
	    String cal_no = (String) requestBody.get("cal_no");
	    String cal_start = (String) requestBody.get("cal_start");
	    String cal_end = (String) requestBody.get("cal_end");
	    String emp_no = (String) requestBody.get("epm_no");
	    String cal_content = (String) requestBody.get("cal_content");
	    
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
			try {
		        LocalDateTime startDateTime = LocalDateTime.parse(cal_start, formatter);
		        LocalDateTime endDateTime = LocalDateTime.parse(cal_end, formatter);
	           // DB에 일정 정보 저장
		        calService.editEvent(cal_no, cal_content, startDateTime, endDateTime, emp_no);
	           result.put("success", true);
	       } catch (Exception e) {
	           e.printStackTrace();
	           result.put("success", false);
	       }

	       return result;
	   }
	
	@RequestMapping(value = "/deleteParties", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteParties(@RequestParam("id") Long id) {
		Map<String, Object> result = new HashMap<>();
			try {
				// DB에서 일정 정보 삭제
				calService.deleteParties(id);
				result.put("success", true);
			} catch (Exception e) {
				e.printStackTrace();
				result.put("success", false);
			}

			return result;
	}
	
	
	
	    

	}
	

