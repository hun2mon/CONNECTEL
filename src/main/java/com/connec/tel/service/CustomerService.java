package com.connec.tel.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.dao.CustomerDAO;
import com.connec.tel.dto.AnnDTO;
import com.connec.tel.dto.EmpDTO;
import com.connec.tel.dto.GuestManageDTO;

@Service
public class CustomerService {
	
	@Autowired CustomerDAO customerDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private JavaMailSender javaMailSender; 
	
	
	@Value("${spring.mail.username}")
    private String senderEmail;
	
	
	
	public Map<String, Object> noticelist(int currPage, int pagePerCnt, String ann_division, String ann_fixed, String register, String ann_date) {
		Map<String, Object>result = new HashMap<String, Object>();
		List<AnnDTO>list = customerDAO.noticelist(pagePerCnt,currPage);
		EmpDTO dto = new EmpDTO();
		String name = dto.geteName();
		result.put("list", list);
		result.put("currPage", currPage);
		result.put("ann_division", ann_division);
		result.put("ann_fixed", ann_fixed);
		result.put("totalPages", customerDAO.noticeCount(pagePerCnt));
		result.put("register", name);
		result.put("ann_date", ann_date);
		
		return result;
	}



	public Map<String, Object> noticeSearch(Map<String, Object> map, String textval) {
		List<AnnDTO> list = customerDAO.noticeSearch(textval);
		map.put("list", list);
		
		return map;
		
	}



	public ModelAndView noticeDetail(String ann_no) {
		ModelAndView mav = new ModelAndView();
		AnnDTO dto = customerDAO.noticedetail(ann_no);
		
		customerDAO.bHit(ann_no);
		logger.info("고객디테일");
		mav.addObject("dto", dto);
		mav.addObject("image", customerDAO.noticephoto(ann_no));
		mav.setViewName("/customer/noticeDetail");
		
		
		
		return mav;
	}



	public Map<String, Object> reserveListCall(Map<String, Object> param) {
		Map<String, Object> map = new HashMap<String, Object>();
		

		List<GuestManageDTO> resList = customerDAO.room_info();
		map.put("resList", resList);
		
		map.put("standard_detail", customerDAO.standard_detail());
		map.put("superior_detail", customerDAO.superior_detail());
		map.put("delux_detail", customerDAO.delux_detail());
		map.put("suite_detail", customerDAO.suite_detail());
		
		map.put("standard_extent", customerDAO.standard_extent());
		map.put("superior_extent", customerDAO.superior_extent());
		map.put("delux_extent", customerDAO.delux_extent());
		map.put("suite_extent", customerDAO.suite_extent());
		
		map.put("standard_amenity", customerDAO.standard_amenity());
		map.put("superior_amenity", customerDAO.superior_amenity());
		map.put("delux_amenity", customerDAO.delux_amenity());
		map.put("suite_amenity", customerDAO.suite_amenity());
		

		
		map.put("standard_roomview", customerDAO.standard_roomview());
		map.put("superior_roomview", customerDAO.superior_roomview());
		map.put("delux_roomview", customerDAO.delux_roomview());
		map.put("suite_roomview", customerDAO.suite_roomview());
		
		
	
		
		String in_date = (String) param.get("in_date");
		String out_date= (String) param.get("out_date");
		
		int standard_num = customerDAO.standard_num(in_date,out_date);
		int superior_num = customerDAO.superior_num(in_date,out_date);
		int delux_num = customerDAO.delux_num(in_date,out_date);
		int suite_num = customerDAO.suite_num(in_date,out_date);
		
		List<GuestManageDTO> list = customerDAO.reserveListCall(param);
		
		int standard = 0;
		int superior = 0;
		int delux = 0;
		int suite = 0;
		
		String standard_photo = "";
		String superior_photo = "";
		String delux_photo = "";
		String suite_photo = "";
		
		
		for (GuestManageDTO dto : list) {
			standard += dto.getStandard();
			superior += dto.getSuperior();
			delux += dto.getDelux();
			suite += dto.getSuite();
		}
		
		GuestManageDTO roomPrices = customerDAO.getRoomPrices(in_date, out_date);
	    int minStandardPrice = roomPrices.getStandard();
	    int minSuperiorPrice = roomPrices.getSuperior();
	    int minDeluxePrice = roomPrices.getDelux();
	    int minSuitePrice = roomPrices.getSuite();
		
	    map.put("minStandardPrice", minStandardPrice);
	    map.put("minSuperiorPrice", minSuperiorPrice);
	    map.put("minDeluxePrice", minDeluxePrice);
	    map.put("minSuitePrice", minSuitePrice);
	   
	    map.put("standard_image", customerDAO.standardphoto(standard_photo));
	    map.put("superior_image", customerDAO.superiorphoto(superior_photo));
	    map.put("delux_image", customerDAO.deluxphoto(delux_photo));
	    map.put("suite_image", customerDAO.suitephoto(suite_photo));
	   
		map.put("standard_num", standard_num);
		map.put("superior_num", superior_num);
		map.put("delux_num", delux_num);
		map.put("suite_num", suite_num);
		
		map.put("standard", standard);
		map.put("superior", superior);
		map.put("delux", delux);
		map.put("suite", suite);
		
		return map;
	}

	
	
	
	
	/*           메일인증                */


	public void emailcode(String email, String code) {
		sendEmail(email,code);
	}
	
	private void sendEmail(String email, String code) {
		MimeMessage message = javaMailSender.createMimeMessage();
				
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			helper.setFrom(senderEmail); // 발신자 이메일 주소 설정
			 helper.setTo(email); // 수신자 이메일 주소 설정
			 helper.setSubject("이메일 인증코드입니다.");
			 helper.setText("이메일 인증코드입니다. :"+code +"을 입력해주세요.", true); // 내용 설정
		
		
			 javaMailSender.send(message); // 이메일 전송
	            logger.info("메일 전송 완료: {}", email);
		
		} catch (Exception e) {
			logger.error("메일 전송 실패: {}", e.getMessage());
			
			e.printStackTrace();
		}		
		
	}

	
	
	
	

}
