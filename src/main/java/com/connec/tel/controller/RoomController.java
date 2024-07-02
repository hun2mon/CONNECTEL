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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.dto.EmpDTO;
import com.connec.tel.dto.RoomDTO;
import com.connec.tel.service.RoomService;

@Controller
public class RoomController {

	@Autowired
	RoomService roomService;
	Logger logger = LoggerFactory.getLogger(getClass());

	@PostMapping(value = "/room/roomManageWrite.do")
	public String roomManageWrite(@RequestParam("multipartFiles") MultipartFile[] photos,
			@ModelAttribute RoomDTO room_dto, Model model, HttpSession session) {
		logger.info("roomManageWrite.do 요청!!");
		logger.info("photos : {}",(Object[]) photos);
		
		EmpDTO emp = (EmpDTO) session.getAttribute("loginInfo");
		String emp_no = emp.getEmp_no();
		room_dto.setRegister(emp_no);
		
		logger.info("room_dto : {}", room_dto);
		int row = roomService.roomManageWrite(photos,room_dto);
		
		

		return "redirect:/room/roomManageDetail.go?room_manage_no="+row;
	}
	
	@RequestMapping(value = "/room/roomManageUpdate.do")
	public String roomManageUpdateDo(@RequestParam("multipartFiles") MultipartFile[] photos,
			@RequestParam Map<String, Object> param) {
		logger.info("roomManageUpdate.DO 요청!!");
		logger.info("photos : "+photos);
		logger.info("param : {} ",param);
		String room_manageNo = (String) param.get("room_manage_no") ;
		int room_manage_no = Integer.parseInt(room_manageNo);
		roomService.roomManageUpdateDo(photos,param,room_manage_no);
		
		return "redirect:/room/roomManageDetail.go?room_manage_no="+room_manage_no;
	}
	
	@RequestMapping(value = "/room/roomManageDetail.go")
	public ModelAndView roomManageDetail(int room_manage_no,HttpSession session) {
		logger.info("roomManageDetail 요청!!");
		logger.info("room_manage_no : "+room_manage_no);
		EmpDTO dto = (EmpDTO) session.getAttribute("loginInfo");
		String authority = dto.getAuthority();
		logger.info("authority : " + authority);
		
		return roomService.room_mng_detail(room_manage_no,authority);
	}
	
	@RequestMapping(value = "/room/roomManageUpdate.go")
	public ModelAndView roomManageUpdate(int room_manage_no) {
		logger.info("roomManageUpdate 요청!!");
		logger.info("room_manage_no : "+room_manage_no);

		return roomService.room_mng_update(room_manage_no);
	}
	
	
	
	
	

	@GetMapping(value = "/room/liveRoomManage.ajax")
	@ResponseBody
	public Map<String, Object> liveRoomManageAjax() {
		logger.info(" liveRoomManageAjax 요청!!!");

		return roomService.liveRoomManageAjax();
	}

	@PostMapping(value = "/room/reservationList.ajax")
	@ResponseBody
	public Map<String, Object> reservationList(@RequestParam Map<String, Object> param) {
		logger.info("reservationListAjax 요청!!!");
		logger.info("name = " + param.get("name"));

		return roomService.reservationList(param);
	}

	@PostMapping(value = "/room/checkIn.ajax")
	@ResponseBody
	public Map<String, Object> chekIn(@RequestParam Map<String, Object> param, HttpSession session) {
		logger.info("param : {}", param);

		return roomService.checkIn(param, session);
	}

	@PostMapping(value = "/room/checkInInfo.ajax")
	@ResponseBody
	public Map<String, Object> checkInInfo(@RequestParam String room_no) {

		logger.info("checkInInfo.axax 요청!!!");
		logger.info("param : " + room_no);

		return roomService.checkInInfo(room_no);
	}

	@PostMapping(value = "/room/checkOut.ajax")
	@ResponseBody
	public Map<String, Object> checkOut(@RequestParam String room_no, @RequestParam String res_no,
			HttpSession session) {

		logger.info("checkOut.axax 요청!!!");
		logger.info("param : " + room_no);
		logger.info("param : " + res_no);

		return roomService.checkOut(room_no, res_no, session);
	}

	@PostMapping(value = "/room/roomStateList.ajax")
	@ResponseBody
	public Map<String, Object> roomStateList(String search, String page, String cnt) {

		logger.info("RoomStateList.axax 요청!!!");
		logger.info("search : "+ search);
		logger.info("search : "+ page);
		logger.info("search : "+ cnt);

		return roomService.roomStateList(search, page, cnt);
	}
	
	@PostMapping(value = "/room/roomManageList.ajax")
	@ResponseBody
	public Map<String, Object> roomManageList(String search, String page, String cnt){
		logger.info("roomManageList.axax 요청!!!");
		logger.info("search : "+ search);
		logger.info("search : "+ page);
		logger.info("search : "+ cnt);
		
		return roomService.roomManageList(search, page, cnt);
	}

	@PostMapping(value = "/room/updateNotAvailable.ajax")
	@ResponseBody
	public Map<String, Object> updateNotAvailable(@RequestParam String room_no) {

		logger.info("updateNotAvailable.axax 요청!!!");
		logger.info("room_no : " + room_no);

		return roomService.updateNotAvailable(room_no);
	}

	@PostMapping(value = "/room/updateAvailable.ajax")
	@ResponseBody
	public Map<String, Object> updateAvailable(@RequestParam String room_no) {

		logger.info("updateAvailable.axax 요청!!!");
		logger.info("room_no : " + room_no);

		return roomService.updateAvailable(room_no);
	}

	@PostMapping(value = "/room/roomPirceList.ajax")
	@ResponseBody
	public Map<String, Object> roomPirceList(@RequestParam Map<String, Object> param) {

		logger.info("roomPirceList.axax 요청!!!");
		logger.info("param : {}", param);

		return roomService.roomPirceList(param);
	}

	@PostMapping(value = "/room/saveRoomPriceList.ajax")
	@ResponseBody
	public Map<String, Object> saveRoomPriceList(@RequestParam Map<String, Object> param, HttpSession session) {

		logger.info("saveRoomPriceList.axax 요청!!!");

		EmpDTO emp = (EmpDTO) session.getAttribute("loginInfo");
		String emp_no = emp.getEmp_no();

		param.put("emp_no", emp_no);
		logger.info("param : {}", param);

		String yearMonth = (String) param.get("year_month");
		String division = (String) param.get("dd_division");
		logger.info("yearMonth : " + yearMonth);
		logger.info("division : " + division);

		
		if (roomService.row(yearMonth,division)>0) {
			return roomService.updateRoomPirceList(param);
		 }else { 
			 return roomService.insertRoomPirceList(param);
			 }
		 

	}
	
	@PostMapping(value = "/room/roomPriceCalendarList.ajax")
	@ResponseBody
	public Map<String, Object> roomPriceCalendarList(
			@RequestParam String year_month){
		logger.info("roomPriceCalendarList 요청!!!");
		logger.info("year_month : " + year_month);
		
		
		
		return roomService.roomPriceCalendarList(year_month);
	}
	
	
	@PostMapping(value = "/room/changeCheckIn.ajax")
	@ResponseBody
	public Map<String, Object> changeCheckIn(
			@RequestParam Map<String, Object>param,HttpSession session){
		logger.info("changeCheckIn 요청!!!");
		
		EmpDTO emp = (EmpDTO) session.getAttribute("loginInfo");
		String emp_no = emp.getEmp_no();

		param.put("emp_no", emp_no);
		logger.info("param : {}", param);
		
		
		
		return roomService.changeCheckIn(param);
	}

	@PostMapping(value = "/room/updateDayRoomPrice.ajax")
	@ResponseBody
	public Map<String, Object> updateDayRoomPrice(
			@RequestParam Map<String, Object> param){
		logger.info("updateDayRoomPrice 요청!!!");
		logger.info("param : {}", param);
	
		return roomService.updateDayRoomPrice(param);
	}
	
	@PostMapping(value = "/room/roomList.ajax")
	@ResponseBody
	public Map<String, Object> roomList(){
		logger.info("roomList 요청!!!");
	
		return roomService.roomList();
	}
	
	@GetMapping(value = "/room/phoDelete.do")
	public String phoDelete(String pho_name,String room_manage_no) {
		logger.info("phoDelete 요청!");
		logger.info("pho_name : "+pho_name);
		logger.info("room_manage_no : "+room_manage_no);
		
		roomService.phoDelete(pho_name);
		
		return "redirect:/room/roomManageUpdate.go?room_manage_no="+room_manage_no;
	}
	
	@GetMapping(value = "/room/room_manage_status_update.do")
	public String room_manage_status_update(int room_manage_no,int room_no,HttpSession session) {
		logger.info("room_manage_status_update 요청!");
		logger.info("room_manage_no : "+room_manage_no);
		EmpDTO dto = (EmpDTO) session.getAttribute("loginInfo");
		String emp_no = dto.getEmp_no();
		roomService.room_manage_status_update(room_manage_no,room_no,emp_no);
		
		return "redirect:/room/roomManageDetail.go?room_manage_no="+room_manage_no;
	}
	
	@PostMapping(value = "/room/getCheckoutRooms.ajax")
	@ResponseBody
	public Map<String, Object> getCheckoutRooms(){
		logger.info("getCheckoutRooms 요청!!!");
	
		return roomService.getCheckoutRooms();
	}
	
	@PostMapping(value = "/room/setRoomsToAvailable.ajax")
	@ResponseBody
	public Map<String, Object> setRoomsToAvailable(@RequestBody Map<String, Object> params){
		logger.info("setRoomsToAvailable 요청!!!");
		logger.info("params : {}",params);
	
	    List<String> rooms = (List<String>) params.get("rooms");
	    logger.info("rooms : {}", rooms);
		
		
		return roomService.setRoomsToAvailable(rooms);
	}
	
	@PostMapping(value = "/room/roomInfoList.ajax")
	@ResponseBody
	public Map<String, Object> roomInfoList(@RequestParam String type_code){
		logger.info("roomInfoList 요청!!!");
		logger.info("type_code : {}",type_code);

		return roomService.roomInfoList(type_code);
	}

	@PostMapping(value = "/room/roomInfoUpdate.do")
	public String roomInfoUpdate(@RequestParam("photo") MultipartFile photo,
			@RequestParam Map<String, Object> param,Model model) {
		logger.info("roomInfoUpdate 요청!!!");
		logger.info("param : {}",param);
		logger.info("photo : "+photo);
		
		roomService.roomInfoUpdate(photo,param);
		
		model.addAttribute("room_type", param.get("room_type_code"));
		return "/room/roomInfoUpdate";
	}
}
