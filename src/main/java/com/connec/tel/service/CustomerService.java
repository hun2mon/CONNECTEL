package com.connec.tel.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.dao.CustomerDAO;
import com.connec.tel.dto.AnnDTO;
import com.connec.tel.dto.EmpDTO;
import com.connec.tel.dto.GuestManageDTO;
import com.connec.tel.dto.RoomDTO;
import com.connec.tel.dto.kakaoPayApproveDTO;
import com.connec.tel.dto.kakaoPayReadyDTO;

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



	public kakaoPayReadyDTO kaPay(Map<String, Object> params, HttpSession session) {
		
		if (params.get("total_amount") != null) {
			HttpHeaders headers = new HttpHeaders();
			headers.set("Authorization", "KakaoAK "+ "c1217d95033551b5bbf6b58300e28030"); //발급받은 adminkey
			
			MultiValueMap<String, Object> payParmas = new LinkedMultiValueMap<String, Object>();
			
			LocalDate today = LocalDate.now();
			String currDate = today.format(DateTimeFormatter.ofPattern("yyMMdd")); //오늘 ex)240629 로 변환해서 가져오기
			int res_no = 0;
			if (customerDAO.todayResSearch(currDate) > 0) { // res_no이 240629로 시작하는 번호가 있는지 확인
				int recently_no = customerDAO.todayResNumSearch(currDate); // 있으면 가장 최근 번호 가져옴
				res_no = recently_no+1;		//그번호에 1 더하기
			}else {
				String sum = currDate+"001"; // 없으면 240629에 001 더해서 res_no 만들기
				res_no = Integer.parseInt(sum); // int로 바꿔줌
			}
	
			payParmas.add("cid", "TC0ONETIME"); //가맹점 코드,10자
			payParmas.add("partner_order_id", res_no+""); //가맹점 주문번호(테이블 pk값=res_no) String 타입이어야 해서 ""더함
			payParmas.add("partner_user_id", "kakaopayTest"); //회원ID 이나 우리는 회원 관리를 따로 하지 않으니 X
			payParmas.add("item_name", params.get("item_name")); //객실타입 ex)스탠다드룸
			payParmas.add("quantity", params.get("quantity")); // 개수 그냥 1개 고정값(몇박 주기 귀찮음ㅋ)
			payParmas.add("total_amount", params.get("total_amount")); //결제금액
			payParmas.add("tax_free_amount", params.get("tax_free_amount")); // 상품 비과세 금액 우리는 0
			payParmas.add("approval_url", "http://localhost:8080/customer/success"); // 성공할 경우 요청할 주소
			payParmas.add("cancel_url", "http://localhost:8080/customer/cancel"); // 취소할 경우 요청할 주소
			payParmas.add("payment_method_type","MONEY"); // 현금과 카드 중 현금만 가능
			payParmas.add("fail_url", "http://localhost:8080/common/fail"); //실패할 경우 주소
			
			
			HttpEntity<Map> request = new HttpEntity<Map>(payParmas, headers);
			logger.info("payParams : {}",payParmas);
			RestTemplate template = new RestTemplate();
			String url = "https://kapi.kakao.com/v1/payment/ready";
			
			kakaoPayReadyDTO res = template.postForObject(url, request,kakaoPayReadyDTO.class);
			
			int type_code = 0;
			String type = (String) params.get("item_name");
			if (type.equals("스탠다드룸")) {
				type_code = 1001;
			}else if (type.equals("슈페리어룸")) {
				type_code = 1002;
			}else if (type.equals("디럭스룸")) {
				type_code = 1003;
			}else {
				type_code = 1004;
			}

			String tid = res.getTid();
						
			params.put("tid", tid);
			params.put("res_no", res_no);
			params.put("type_code", type_code);
			session.setAttribute("params", params);
			
			
		
			return res;	
			}else {// 추가결제
				
				String date = (String) params.get("current_date");
				int room_no = Integer.parseInt((String)params.get("room_no")) ;
				int changeRoom_no = Integer.parseInt((String) params.get("changeRoom_no")) ;
				int curr_no = Integer.parseInt((String)params.get("curr_no")) ;
				int after_no = Integer.parseInt((String)params.get("after_no")) ;
				logger.info("date : " +date);
				logger.info("room_no : " +room_no);
				logger.info("changeRoom_no : " +changeRoom_no);			
				logger.info("curr_no : " +curr_no);
				logger.info("after_no : " +after_no);
				
				String room_type="";
				String change_room_type="";

				// 이제 jsp 에서 보낸 날짜에 현재 room_no 과 변경할 changeRoom_no이 각각 무슨 룸인지 구하고 
				// 쿼리문으로 빼기를 할 번에구 해서 가져오기
				
				int price = customerDAO.price(params.get("res_no"));
				logger.info("price : " + price);

				if (after_no == 3 || after_no == 4) {
					change_room_type="standard";
				}else if (after_no == 5) {
					change_room_type="superior";
				}else if (after_no == 6) {
					change_room_type="delux";
				}else {
					change_room_type="suite";
				}
				
				int total_price = customerDAO.plus_price(date,price,change_room_type);
				logger.info("total_price : " +total_price);
				
				
				
				HttpHeaders headers = new HttpHeaders();
				headers.set("Authorization", "KakaoAK "+ "c1217d95033551b5bbf6b58300e28030"); //발급받은 adminkey
				MultiValueMap<String, Object> payParam = new LinkedMultiValueMap<String, Object>();
				
				payParam.add("cid", "TC0ONETIME"); //가맹점 코드,10자
				payParam.add("partner_order_id", "KA020230318001"); //가맹점 주문번호(테이블 pk값=res_no) String 타입이어야 해서 ""더함
				payParam.add("partner_user_id", "kakaopayTest"); //회원ID 이나 우리는 회원 관리를 따로 하지 않으니 X
				payParam.add("item_name", params.get("item_name")); //객실타입 ex)스탠다드룸
				payParam.add("quantity", params.get("quantity")); // 개수 그냥 1개 고정값(몇박 주기 귀찮음ㅋ)
				payParam.add("total_amount",total_price); //결제금액
				payParam.add("tax_free_amount", params.get("tax_free_amount")); // 상품 비과세 금액 우리는 0
				payParam.add("approval_url", "http://localhost:8080/common/plusSuccess"); // 성공할 경우 요청할 주소
				payParam.add("cancel_url", "http://localhost:8080/common/cancel"); // 취소할 경우 요청할 주소
				payParam.add("payment_method_type","MONEY"); // 현금과 카드 중 현금만 가능
				payParam.add("fail_url", "http://localhost:8080/common/fail"); //실패할 경우 주소
				
				logger.info("payParam : {}",payParam);
				
				HttpEntity<Map> request = new HttpEntity<Map>(payParam, headers);
				
				RestTemplate template = new RestTemplate();
				String url = "https://kapi.kakao.com/v1/payment/ready";
				
				kakaoPayReadyDTO res = template.postForObject(url, request,kakaoPayReadyDTO.class);
				
				// 여기에 업데이트할 값들 세션 저장
				String tid = res.getTid();
				
				session.setAttribute("res_no", params.get("res_no"));
				session.setAttribute("plus_price", total_price);
				session.setAttribute("changeRoom_no", changeRoom_no);
				session.setAttribute("tid", tid);
				return res;
			}
			
		}

	public kakaoPayApproveDTO kakaoPayApprove(String pgToken, HttpSession session) {
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "KakaoAK "+ "c1217d95033551b5bbf6b58300e28030" );
		headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		MultiValueMap<String, Object> payParams = new LinkedMultiValueMap<String, Object>();
		Map<String, Object> param = (Map<String, Object>) session.getAttribute("params");
		
		payParams.add("cid","TC0ONETIME");
		payParams.add("tid",param.get("tid"));
		payParams.add("partner_order_id", param.get("res_no"));
		payParams.add("partner_user_id", "kakaopayTest");
		payParams.add("pg_token", pgToken);
		
		HttpEntity<Map> request = new HttpEntity<Map>(payParams,headers);
		
		RestTemplate template = new RestTemplate();
		String url = "https://kapi.kakao.com/v1/payment/approve";
		
		kakaoPayApproveDTO res = template.postForObject(url, request, kakaoPayApproveDTO.class);
		
		customerDAO.reservation(param); // 예약 테이블에 추가
		
		
		return res;
	}



	public void successmailsend(String successsend) {
		MimeMessage message = javaMailSender.createMimeMessage();
		
		String res_no = customerDAO.getres_no(successsend);
		
		
		
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			helper.setFrom(senderEmail); // 발신자 이메일 주소 설정
			 helper.setTo(successsend); // 수신자 이메일 주소 설정
			 helper.setSubject("The Sheilla Hotel에 예약이 완료되었습니다!");
			 helper.setText("예약을 축하드립니다! 고객님의 예약번호는 ["+res_no+"] 입니다. 예약조회 및 취소를 하실 때 사용하길 바랍니다.! 편안한 휴식이 되시길 바랍니다. -The Sheilla Hotel- ", true); // 내용 설정
			 
		
		
			 javaMailSender.send(message); // 이메일 전송
	            logger.info("메일 전송 완료: {}", senderEmail);
		
		} catch (Exception e) {
			logger.error("메일 전송 실패: {}", e.getMessage());
			
			e.printStackTrace();
		}		
		
		
	}


	public Map<String, Object> reservationcheck(String name, String phone, String reservationNo, HttpSession session) {
	    Map<String, Object> response = new HashMap<String, Object>();
	    
	    RoomDTO dto = customerDAO.checkReservation(name, phone, reservationNo);
	    
	  
	    
	   if(dto == null) {
		   response.put("error", "오류");
	   } else {
	    	response.put("success", dto);
	    	session.setAttribute("reservationNo", reservationNo);
	    	
	    }
	    
	    return response;
	}



	public ModelAndView myresercheckDetail(String res_no) {
		ModelAndView mav = new ModelAndView();
		RoomDTO dto = customerDAO.reservedetail(res_no);
		RoomDTO info = customerDAO.room_detail_infomation(res_no);
		mav.addObject("dto",dto);
		mav.addObject("info", info);
		mav.setViewName("/customer/myreservationdetail");
		
		return mav;
	}

	
	











}

