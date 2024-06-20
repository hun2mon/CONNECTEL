package com.connec.tel.service;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.connec.tel.dao.MailDAO;

@Service
public class MailService {
	
	@Autowired MailDAO mailDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private JavaMailSender javaMailSender; 
	
	@Value("${spring.mail.username}")
    private String senderEmail;
	
	

	public void mail(Map<String, String> param, String[] receiverList, List<MultipartFile> files) {
		for (String email : receiverList) {
            sendEmail(param, email.trim(), files);
        }	
	}

	private void sendEmail(Map<String, String> param, String email, List<MultipartFile> files) {
		MimeMessage message = javaMailSender.createMimeMessage();	
			
		try {
	            MimeMessageHelper helper = new MimeMessageHelper(message, true);
	            helper.setFrom(senderEmail); // 발신자 이메일 주소 설정
	            helper.setTo(email); // 수신자 이메일 주소 설정
	            helper.setSubject(param.get("subject")); // 제목 설정
	            helper.setText(param.get("content"), true); // 내용 설정
	            
	            // 파일 첨부
	            for (MultipartFile file : files) {
	                if (!file.isEmpty()) {
	                    helper.addAttachment(file.getOriginalFilename(), file);
	                    
	                }
	            }
	            
	            javaMailSender.send(message); // 이메일 전송
	            logger.info("메일 전송 완료: {}", email);
		} catch (Exception e) {
			 logger.error("메일 전송 실패: {}", e.getMessage());
			e.printStackTrace();
		}
		
	}

	
}
