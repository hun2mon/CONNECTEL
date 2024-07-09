package com.connec.tel.controller;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import com.connec.tel.dto.EmpDTO;
import com.connec.tel.dto.MessengerDTO;
import com.connec.tel.dto.NoticeDTO;
import com.connec.tel.service.NoticeService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

@Controller
public class NoticeController {
	
	@Autowired NoticeService noticeService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
    @Autowired
    private SimpMessagingTemplate messagingTemplate;

	
    
    
    @MessageMapping("/privatemessage")
    @SendTo("/user/queue/notifications")
    public MessengerDTO getPrivateMessage(final NoticeDTO message,
                                          final Principal principal) {
        // 메시지 내용을 HTML 이스케이프 처리 후 반환
        String escapedMessageContent = HtmlUtils.htmlEscape(message.getMessage());
        return new MessengerDTO(escapedMessageContent);
    }
    
    @GetMapping("/notifications")
    @ResponseBody
    public List<NoticeDTO> getNotifications(Model model, String emp_no) {
    
    	
        
        logger.info("empNo : " + emp_no);
        List<NoticeDTO> notifications = noticeService.getNotifications(emp_no);
        logger.info("notifications : {}", notifications);
        model.addAttribute("notifications", notifications);
        return notifications;
    }
    

    public void sendShare(String emp_no, String noti_content) {
        LocalDateTime noti_dates = LocalDateTime.now();
        // LocalDateTime을 원하는 형식의 문자열로 변환
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String noti_date = noti_dates.format(formatter);
        
        
        
        ObjectMapper objectMapper = new ObjectMapper();

        String noti_link = "/calendar/calendar.go";

        NoticeDTO message = new NoticeDTO(emp_no, noti_content,noti_date,noti_link);
        logger.info("message: " + message);

        try {
            Thread.sleep(500);
            noticeService.sendShare(emp_no, noti_content,noti_link);
            // NoticeDTO 객체를 JSON 문자열로 변환
            String jsonContent = objectMapper.writeValueAsString(message);
            // 웹소켓을 통해 사용자에게 JSON 문자열 전송
            logger.info(jsonContent);
            messagingTemplate.convertAndSendToUser(emp_no, "/queue/notifications", jsonContent);
        } catch (Exception e) {
            logger.error("Thread interrupted while sleeping: " + e.getMessage());
            Thread.currentThread().interrupt();
        }

    }
    
    
    public void sendTest(String emp_no, String noti_content) {
        // 현재 시간을 LocalDateTime 객체로 가져옴
        LocalDateTime noti_dates = LocalDateTime.now();

        // LocalDateTime을 원하는 형식의 문자열로 변환
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String noti_date = noti_dates.format(formatter);

        // ObjectMapper 생성
        ObjectMapper objectMapper = new ObjectMapper();
        String noti_link = "calendar/calendar.go";
        // NoticeDTO 객체 생성
        logger.info(noti_date+ "노티 데이트!!!!");
        NoticeDTO message = new NoticeDTO(emp_no, noti_content, noti_date,noti_link);

        logger.info("message: " + message);

        try {
            // NoticeDTO 객체를 JSON 문자열로 변환
            String jsonContent = objectMapper.writeValueAsString(message);
            // 웹소켓을 통해 사용자에게 JSON 문자열 전송
            logger.info(jsonContent);
            messagingTemplate.convertAndSendToUser(emp_no, "/queue/notifications", jsonContent);
        } catch (JsonProcessingException e) {
            logger.error("Error converting object to JSON: " + e.getMessage());
            // 예외 처리
        }
    }
    
    @DeleteMapping("/notifications/{noti_idx}")
    @ResponseBody
    public ResponseEntity<String> deleteNotification(@PathVariable("noti_idx") String noti_idx) {
        // 예제로 알림 삭제 로직
    	logger.info("noti_idx" + noti_idx);
        boolean deleted = noticeService.deleteId(noti_idx);
        if (deleted) {
            return ResponseEntity.ok("Notification deleted successfully");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Notification not found");
        }
    }
    
    
}
