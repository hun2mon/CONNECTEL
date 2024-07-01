package com.connec.tel.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.connec.tel.dao.GuestManageDAO;
import com.connec.tel.dto.GuestManageDTO;
import com.connec.tel.dto.kakaoPayCancelDTO;

@Service
public class GuestManageService {
	
	@Autowired GuestManageDAO geustMngDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	public Map<String, Object> reserveList(String search, String page, String cnt, String searchDate) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int currPage = Integer.parseInt(page);
		int cntt = Integer.parseInt(cnt);
		
		int start = (currPage-1) * cntt;
		
		search = "%" + search + "%";
		
		int totalpage = geustMngDAO.totalPage(search, cntt,searchDate);
		
		List<GuestManageDTO> list = geustMngDAO.reserveList(search, start, cntt,searchDate);
		
		map.put("list", list);
		map.put("currPage", currPage);
		map.put("totalPages", totalpage);
		return map;

	}	
	
	public Map<String, Object> stayList(String search, String page, String cnt, String searchDate) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int currPage = Integer.parseInt(page);
		int cntt = Integer.parseInt(cnt);
		
		int start = (currPage-1) * cntt;
		
		search = "%" + search + "%";
		
		int totalpage = geustMngDAO.stayListTotalPage(search, cntt,searchDate);
		
		List<GuestManageDTO> list = geustMngDAO.stayList(search, start, cntt,searchDate);
		
		map.put("list", list);
		map.put("currPage", currPage);
		map.put("totalPages", totalpage);
		return map;
	}
	public Map<String, Object> cancelList(String search, String page, String cnt, String searchDate) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int currPage = Integer.parseInt(page);
		int cntt = Integer.parseInt(cnt);
		
		int start = (currPage-1) * cntt;
		
		search = "%" + search + "%";
		
		int totalpage = geustMngDAO.cancelTotalPage(search, cntt,searchDate);
		
		List<GuestManageDTO> list = geustMngDAO.cancelList(search, start, cntt,searchDate);
		
		map.put("list", list);
		map.put("currPage", currPage);
		map.put("totalPages", totalpage);
		return map;
	}
	public Map<String, Object> resCancelDate(String date) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String percent = geustMngDAO.resCancelDate(date);
		
		map.put("percent", percent);
		
		return map;
	}
	public kakaoPayCancelDTO reserveCancel(String res_no, String cancelPrice) {
		
		
		
		String tid = geustMngDAO.selectTid(res_no);
		logger.info("tid 값: " +tid);
		
		int cancel_price = Integer.parseInt(cancelPrice.replace(".", ""));	
		logger.info("cancel_price : " + cancel_price);
		
		kakaoPayCancelDTO res = null;
		
		if (cancel_price > 0) {
			// 카카오페이 취소 
			HttpHeaders headers = new HttpHeaders();
			
			headers.set("Authorization", "KakaoAK " + "c1217d95033551b5bbf6b58300e28030");
			headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			
			MultiValueMap<String, Object> payParams = new LinkedMultiValueMap<String, Object>();
			
			payParams.add("cid","TC0ONETIME");
			payParams.add("tid",tid);
			payParams.add("cancel_amount",cancelPrice);
			payParams.add("cancel_tax_free_amount",0);
			
			HttpEntity<Map> request = new HttpEntity<Map>(payParams,headers);
			
			RestTemplate template = new RestTemplate();
			String url = "https://kapi.kakao.com/v1/payment/cancel";
			
			res = template.postForObject(url, request, kakaoPayCancelDTO.class);
		}

		// 예약 구분 C로 바꿈
		geustMngDAO.reserveCancel(res_no);
		
		geustMngDAO.insert_res_cancel(res_no,cancelPrice);
		
		return res;
	}

	public Map<String, Object> reserveListCall(Map<String, Object> param) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<GuestManageDTO> resList = geustMngDAO.room_info();
		map.put("resList", resList);
		
		String in_date = (String) param.get("in_date");
		String out_date= (String) param.get("out_date");
		
		int standard_num = geustMngDAO.standard_num(in_date,out_date);
		int superior_num = geustMngDAO.superior_num(in_date,out_date);
		int delux_num = geustMngDAO.delux_num(in_date,out_date);
		int suite_num = geustMngDAO.suite_num(in_date,out_date);
		
		List<GuestManageDTO> list = geustMngDAO.reserveListCall(param);
		
		int standard = 0;
		int superior = 0;
		int delux = 0;
		int suite = 0;
		
		for (GuestManageDTO dto : list) {
			standard += dto.getStandard();
			superior += dto.getSuperior();
			delux += dto.getDelux();
			suite += dto.getSuite();
		}
		
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

	public Map<String, Object> getDate(String today) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<String> list = geustMngDAO.getDate(today);
		
		map.put("list", list);
		return map;
	}

}
