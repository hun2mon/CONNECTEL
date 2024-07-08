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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.connec.tel.dto.CalendarDTO;
import com.connec.tel.dto.EmpDTO;
import com.connec.tel.service.CalendarService;

import io.opentelemetry.sdk.trace.data.EventData;

@Controller
public class CalendarController {

    private final NoticeController noticeController;

	
    @Autowired
    public CalendarController(NoticeController noticeController) {
        this.noticeController = noticeController;
    }
	
	
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
	
    @RequestMapping(value = "/calendar/mainDetail", method = RequestMethod.GET)
    public String calendarDetail(@RequestParam("cal_no") String cal_no, Model model) {
        String page = "calendar/calendar";
        model.addAttribute("cal_no", cal_no);
        logger.info("Calendar ID: " + cal_no);
        List<CalendarDTO> event = calService.calendarDetail(cal_no);
        model.addAttribute("event", event);
        
        return page;
    }
    
    
    @RequestMapping(value = "/calendar/getDetail", method = RequestMethod.GET)
    @ResponseBody
    public CalendarDTO getCalendarDetail(@RequestParam("cal_no") String cal_no) {
        return calService.calendarDetail(cal_no).get(0);  // List의 첫 번째 항목 반환
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
        String notificationContent = "일정이 공유 되었습니다.";
        @SuppressWarnings("unchecked")
		List<Map<String, String>> participants = (List<Map<String, String>>) param.get("participants");

        if (participants != null) {
            for (Map<String, String> participant : participants) {
                // 각 participant에서 `emp_no` 추출
                String emp_no = participant.get("emp_no");
                String name = participant.get("name");

                // `emp_no`가 null이 아닌지 확인 후 처리
                if (emp_no != null) {
                    // 필요한 로직 수행 (예: 알림 전송)
                    System.out.println("Emp No: " + emp_no + ", Name: " + name);

                    noticeController.sendShare(emp_no, notificationContent);

                }
            }
        } else {
            // participants가 null일 때의 처리 로직
            System.out.println("Participants list is null.");
        }
        


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
	

