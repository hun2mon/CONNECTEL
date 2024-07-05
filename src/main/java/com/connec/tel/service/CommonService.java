package com.connec.tel.service;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.connec.tel.dao.CommonDAO;
import com.connec.tel.dto.EmpDTO;
import com.connec.tel.dto.kakaoPayApproveDTO;
import com.connec.tel.dto.kakaoPayReadyDTO;




@Service
public class CommonService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired CommonDAO commonDAO;
	static String root = "/Users/jeounghun/upload/connectel/file/";
	
	public Map<String, Object> treeCall(String word) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<EmpDTO> list = commonDAO.treeCall(word);
		
		map.put("list", list);
		
		return map;
	}

	public Map<String, Object> listCall(String search, String page, String cnt) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int currPage = Integer.parseInt(page);
		int cntt = Integer.parseInt(cnt);

		
		int start = (currPage-1) * cntt;
		
		search = "%" + search + "%";

		int totalpage = commonDAO.totalPage(search, cntt);
		
		List<EmpDTO> list = commonDAO.listCall(search, start, cntt);
		
		map.put("list", list);
		map.put("currPage", currPage);
		map.put("totalPages", totalpage);
		
		return map;
	}
	
	
	public static void upload(MultipartFile uploadFile, String newFileName) {
		try {
			byte[] bytes = uploadFile.getBytes();
			Path path = Paths.get(root + "/" + newFileName);
			Files.write(path, bytes);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public ResponseEntity<Resource> download(String fileName) {
		
		Resource resource = new FileSystemResource(root + "/" + fileName);
		HttpHeaders header = new HttpHeaders();
			
		try {
			header.add("content-type", "application/octet-stream");
			String oriFile = URLEncoder.encode("첨부파일" + fileName,"UTF-8");
			logger.info("oriFile : {}", oriFile);
			header.add("content-Disposition", "attachment;filename=\""+ oriFile +"\"");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
	}

	
	public kakaoPayReadyDTO kakaoPay(Map<String, Object> params, HttpSession session) {
		
		if (params.get("total_amount") != null) {
			HttpHeaders headers = new HttpHeaders();
			headers.set("Authorization", "KakaoAK "+ "c1217d95033551b5bbf6b58300e28030"); //발급받은 adminkey
			
			MultiValueMap<String, Object> payParmas = new LinkedMultiValueMap<String, Object>();
			
			LocalDate today = LocalDate.now();
			String currDate = today.format(DateTimeFormatter.ofPattern("yyMMdd")); //오늘 ex)240629 로 변환해서 가져오기
			int res_no = 0;
			if (commonDAO.todayResSearch(currDate) > 0) { // res_no이 240629로 시작하는 번호가 있는지 확인
				int recently_no = commonDAO.todayResNumSearch(currDate); // 있으면 가장 최근 번호 가져옴
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
			payParmas.add("approval_url", "http://localhost:8080/common/success"); // 성공할 경우 요청할 주소
			payParmas.add("cancel_url", "http://localhost:8080/common/cancel"); // 취소할 경우 요청할 주소
			payParmas.add("payment_method_type","MONEY"); // 현금과 카드 중 현금만 가능
			payParmas.add("fail_url", "http://localhost:8080/common/fail"); //실패할 경우 주소
			
			HttpEntity<Map> request = new HttpEntity<Map>(payParmas, headers);
			
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
		}else {
			
			String date = (String) params.get("current_date");
			int room_no = Integer.parseInt((String)params.get("room_no")) ;
			int changeRoom_no = Integer.parseInt((String) params.get("changeRoom_no")) ;
			
			logger.info("date : " +date);
			logger.info("room_no : " +room_no);
			logger.info("changeRoom_no : " +changeRoom_no);
			// 이제 jsp 에서 보낸 날짜에 현재 room_no 과 변경할 changeRoom_no이 각각 무슨 룸인지 구하고 
			// 쿼리문으로 빼기를 할 번에구 해서 가져오기
			/*if (room_no) {
				
			}*/
			
			
			HttpHeaders headers = new HttpHeaders();
			headers.set("Authorization", "KakaoAK "+ "c1217d95033551b5bbf6b58300e28030"); //발급받은 adminkey
			MultiValueMap<String, Object> payParmas = new LinkedMultiValueMap<String, Object>();
			
			payParmas.add("cid", "TC0ONETIME"); //가맹점 코드,10자
			payParmas.add("partner_order_id", params.get("res_no")); //가맹점 주문번호(테이블 pk값=res_no) String 타입이어야 해서 ""더함
			payParmas.add("partner_user_id", "kakaopayTest"); //회원ID 이나 우리는 회원 관리를 따로 하지 않으니 X
			payParmas.add("item_name", params.get("item_name")); //객실타입 ex)스탠다드룸
			payParmas.add("quantity", params.get("quantity")); // 개수 그냥 1개 고정값(몇박 주기 귀찮음ㅋ)
			// 계산후 payParmas.add("total_amount", ); //결제금액
			payParmas.add("tax_free_amount", params.get("tax_free_amount")); // 상품 비과세 금액 우리는 0
			payParmas.add("approval_url", "http://localhost:8080/common/plusSuccess"); // 성공할 경우 요청할 주소
			payParmas.add("cancel_url", "http://localhost:8080/common/cancel"); // 취소할 경우 요청할 주소
			payParmas.add("payment_method_type","MONEY"); // 현금과 카드 중 현금만 가능
			payParmas.add("fail_url", "http://localhost:8080/common/fail"); //실패할 경우 주소
			
			HttpEntity<Map> request = new HttpEntity<Map>(payParmas, headers);
			
			RestTemplate template = new RestTemplate();
			String url = "https://kapi.kakao.com/v1/payment/ready";
			
			kakaoPayReadyDTO res = template.postForObject(url, request,kakaoPayReadyDTO.class);
			
			// 여기에 업데이트할 값들 세션 저장
			
			
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
		
		commonDAO.reservation(param); // 예약 테이블에 추가
		
		
		return res;
	}
	
}
