package com.connec.tel.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import com.connec.tel.dto.EmpDTO;
import com.connec.tel.dto.MessengerDTO;
import com.connec.tel.dto.NoticeDTO;
import com.connec.tel.service.NoticeService;

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
    

    public void sendShare(String emp_no, String notificationContent) {
        try {
            // 1초간 텀을 줌 (실제로는 적절한 시간을 선택하여야 함)
            Thread.sleep(1000);
            noticeService.sendShare(emp_no, notificationContent);
        } catch (InterruptedException e) {
            logger.error("Thread interrupted while sleeping: " + e.getMessage());
            Thread.currentThread().interrupt();
        }
        logger.info(emp_no + notificationContent + " 센드 쉐얼 ㄱㄱㄱ");
        messagingTemplate.convertAndSendToUser(emp_no, "/queue/notifications", notificationContent);
    }

	public void sendTest(String emp_no, String content) {
                
        messagingTemplate.convertAndSendToUser(emp_no, "/queue/notifications", content);


		
	}
}
