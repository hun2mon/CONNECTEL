package com.connec.tel.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.connec.tel.service.RoomService;

@Controller
public class RoomController {
	
	@Autowired RoomService roomService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@PostMapping(value = "/room/roomManageWrite.go")
	public String roomManageWrite(@RequestParam Map<String, String> param,
			@RequestParam("multipartFiles") List<MultipartFile> files, Model model) {
		logger.info("roomManageWrite.go 요청!!");
		logger.info("param : {}",param);
		
		String page = "/room/roomManageDetail";
		// 파일 이름 저장하고 내용 저장하고 등등 처리
		// 모델에 넣기... 상세보기로 감
		
		
		return page;
	}
	
	@GetMapping(value = "/room/liveRoomManage.ajax")
	@ResponseBody
	public Map<String, Object> liveRoomManageAjax(){
		logger.info(" liveRoomManageAjax 요청!!!");
		
		
		return roomService.liveRoomManageAjax();
	}

	@PostMapping(value = "/room/reservationList.ajax")
	@ResponseBody
	public Map<String, Object> reservationList(@RequestParam Map<String, Object> param){
		logger.info("reservationListAjax 요청!!!");
		logger.info("name = " + param.get("name"));
		
		return roomService.reservationList(param);
	}
	
	@PostMapping(value = "/room/checkIn.ajax")
	@ResponseBody
	public Map<String, Object> chekIn(@RequestParam Map<String, Object> param,
									HttpSession session){
		logger.info("param : {}",param);
		
		return roomService.checkIn(param,session);
	}
	
	@PostMapping(value = "/room/checkInInfo.ajax")
	@ResponseBody
	public Map<String, Object> checkInInfo(@RequestParam String room_no){
		
		logger.info("checkInInfo.axax 요청!!!");
		logger.info("param : " + room_no);
		
		return roomService.checkInInfo(room_no);
	}
	
	@PostMapping(value = "/room/checkOut.ajax")
	@ResponseBody
	public Map<String, Object> checkOut(@RequestParam String room_no,
			@RequestParam String res_no,HttpSession session){
		
		logger.info("checkOut.axax 요청!!!");
		logger.info("param : " + room_no);
		logger.info("param : " + res_no);
		
		
		return roomService.checkOut(room_no,res_no,session);
	}
}
