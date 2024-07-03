package com.connec.tel.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
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
import com.connec.tel.dto.MailDTO;
import com.connec.tel.dto.RoomDTO;

@Service
public class MailService {
	
	@Autowired MailDAO mailDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private JavaMailSender javaMailSender; 
	
	@Value("${spring.mail.username}")
    private String senderEmail;
	
	public String file_root = "C:/upload/";

	public void mail(MailDTO mailDTO, String[] receiverList, List<MultipartFile> files) {
		for (String email : receiverList) {
            sendEmail(mailDTO, email.trim(), files);
        }	
		
		// 그리고 이메일 데이터 디비에 저장(mail)
        mailDAO.mailSave(mailDTO);
        
        // 여기서 파일이나 이미지 이름 저장 (포토테이블)
        for (MultipartFile file : files) {
        	String oriName = file.getOriginalFilename();
        	 if (!oriName.equals("")) {
 	            String ext = oriName.substring(oriName.lastIndexOf("."));
 	            
 	            String newFileName = System.currentTimeMillis() +ext;
 	            logger.info(oriName +" -> "+newFileName);
 	            
 	            try {
 	               byte[] bytes = file.getBytes();
 	               Path path = Paths.get(file_root+newFileName);
 	               Files.write(path, bytes);
 	               //mypageDAO.introFileCreate(newFileName,userId);
 	               mailDAO.fileUpload(newFileName,oriName,mailDTO.getMail_no());
 	               Thread.sleep(1);
 	            } catch (Exception e) {
 	               
 	               e.printStackTrace();
 	            }
 	   
 	         }
        }
	}

	private void sendEmail(MailDTO mailDTO, String email, List<MultipartFile> files) {
		MimeMessage message = javaMailSender.createMimeMessage();	
			
		try {
	            MimeMessageHelper helper = new MimeMessageHelper(message, true);
	            helper.setFrom(senderEmail); // 발신자 이메일 주소 설정
	            helper.setTo(email); // 수신자 이메일 주소 설정
	            helper.setSubject(mailDTO.getMail_subject()); // 제목 설정
	            helper.setText(mailDTO.getMail_content(), true); // 내용 설정
	            
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

	public Map<String, Object> sendMailList(String search, String page, String cnt, String emp_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int currPage = Integer.parseInt(page);
		int cntt = Integer.parseInt(cnt);
		
		int start = (currPage-1) * cntt;
		
		search = "%" + search + "%";
		
		int totalpage = mailDAO.totalPage(search, cntt,emp_no);
		
		List<RoomDTO> list = mailDAO.sendMailList(search, start, cntt,emp_no);
		
		
		map.put("list", list);
		map.put("currPage", currPage);
		map.put("totalPages", totalpage);
		return map;
	}

	public Map<String, Object> TempMailList(String search, String page, String cnt, String emp_no) {
Map<String, Object> map = new HashMap<String, Object>();
		
		int currPage = Integer.parseInt(page);
		int cntt = Integer.parseInt(cnt);
		
		int start = (currPage-1) * cntt;
		
		search = "%" + search + "%";
		
		int totalpage = mailDAO.tempTotalPage(search, cntt,emp_no);
		
		List<RoomDTO> list = mailDAO.TempMailList(search, start, cntt,emp_no);
		
		
		map.put("list", list);
		map.put("currPage", currPage);
		map.put("totalPages", totalpage);
		return map;
	}
	
	public MailDTO mailDetail(String mail_no) {
		
		return mailDAO.mailDetail(mail_no);
	}

	public void mail_delete(String mail_no) {
		mailDAO.mail_delete(mail_no);
		
	}

	public List<String> mailFile(String mail_no) {
		
		return mailDAO.mailFile(mail_no);
	}

	public Map<String, Object> mail_all_delete(List<String> mail_nos) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		for (String mail_no : mail_nos) {
			mailDAO.mail_delete(mail_no);
		}

		return map;
	}

	public Map<String, Object> mailTempSave(Map<String, Object> param) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		mailDAO.mailTempSave(param);
		
		return map;
	}

	

	
}
