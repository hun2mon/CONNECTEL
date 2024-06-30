package com.connec.tel.service;


import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.dao.RoomDAO;
import com.connec.tel.dto.EmpDTO;
import com.connec.tel.dto.RoomDTO;

@Service
public class RoomService {

	@Autowired RoomDAO roomDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public String file_root = "C:/upload/";
	
	public Map<String, Object> liveRoomManageAjax() {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<RoomDTO> list = roomDAO.liveRoomManageAjax();
		
		map.put("list", list);
		
		return map;
	}

	public Map<String, Object> reservationList(Map<String, Object> param) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if (!param.get("name").equals("")) {
			List<RoomDTO> list = roomDAO.reservationSearchList(param);	
			map.put("list", list);
		}else {			
			List<RoomDTO> list = roomDAO.reservationList();			
			map.put("list", list);
		}
		
		return map;
	}

	public Map<String, Object> checkIn(Map<String, Object> param, HttpSession session) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		String checkIn = (String) param.get("check_in");		
		logger.info("checkIn : " +checkIn);
		
		String check_in = formatCheckDate(checkIn);	
		logger.info("[service]check_in : "+check_in);
		
		String regist_date = check_in.substring(0, 10);
		logger.info("regist_date : " + regist_date);
		
		EmpDTO emp = (EmpDTO) session.getAttribute("loginInfo");
		String emp_no = emp.getEmp_no();

		logger.info("emp_no : " + emp_no);
		
		String room_no = (String) param.get("room_no");
		// param에 check_in 넣고 그전에 regist_date 변환해서 넣고, emp_no 넣고 그다음에는 room 상태 바꾸기
		
		
		
		String room_div = roomDAO.selectRoomDiv(room_no);
		
		if (room_div.equals("A")) {
			roomDAO.roomCheckIn(room_no);
			
			param.put("check_in",check_in);
			param.put("regist_date", regist_date);
			param.put("emp_no",emp_no);
			roomDAO.checkIn(param);
			
			map.put("state", "success");
		}else {
			map.put("state", "false");
			
		}
		
		return map;
	}

	private String formatCheckDate(String checkDate) {
		 SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy. M. d. a h:mm:ss");
	        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        String formattedDate = null;
	        try {
	            Date date = (Date) inputFormat.parse(checkDate);
	            formattedDate = outputFormat.format(date);
	        } catch (Exception e) {
	            e.printStackTrace();

	        }
	        return formattedDate;
	    }

	public Map<String, Object> checkInInfo(String room_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		RoomDTO dto = roomDAO.checkInInfo(room_no);
		
		map.put("res_no", dto.getRes_no());
		map.put("stay_check_in",dto.getStay_check_in());
		
		return map;
	}

	public Map<String, Object> checkOut(String room_no, String res_no, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		EmpDTO emp = (EmpDTO) session.getAttribute("loginInfo");
		String emp_no = emp.getEmp_no();
		
		roomDAO.checkOut(room_no,res_no,emp_no);
		roomDAO.roomCheckOut(room_no);
		return map;
	}

	public Map<String, Object> roomStateList(String search, String page, String cnt) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int currPage = Integer.parseInt(page);
		int cntt = Integer.parseInt(cnt);
		
		int start = (currPage-1) * cntt;
		
		search = "%" + search + "%";
		
		int totalpage = roomDAO.totalPage(search, cntt);
		
		List<RoomDTO> list = roomDAO.roomStateList(search, start, cntt);
		
		map.put("list", list);
		map.put("currPage", currPage);
		map.put("totalPages", totalpage);
		return map;
	}
	
	public Map<String, Object> roomManageList(String search, String page, String cnt) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int currPage = Integer.parseInt(page);
		int cntt = Integer.parseInt(cnt);
		
		int start = (currPage-1) * cntt;
		
		search = "%" + search + "%";
		
		int totalpage = roomDAO.roomManagetotalPage(search, cntt);
		
		List<RoomDTO> list = roomDAO.roomManageList(search, start, cntt);
		
		
		map.put("list", list);
		map.put("currPage", currPage);
		map.put("totalPages", totalpage);
		return map;
	}

	public Map<String, Object> updateNotAvailable(String room_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		roomDAO.updateNotAvailable(room_no);
		
		map.put("msg","성공");
		
		return map;
	}

	public Map<String, Object> updateAvailable(String room_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		roomDAO.updateAvailable(room_no);
		
		map.put("msg","성공");
		
		return map;
	}

	public Map<String, Object> roomPirceList(Map<String, Object> param) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<RoomDTO> list = roomDAO.roomPirceList(param);
		
		map.put("list", list);
		
		return map;
	}

	public Map<String, Object> updateRoomPirceList(Map<String, Object> param) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		roomDAO.updateRoomPirceList(param);
		map.put("msg", "객실타입 가격 변경");
		
		String yearMonth = (String) param.get("year_month");		
		int year = Integer.parseInt(yearMonth.substring(0, 4));
		int month = Integer.parseInt(yearMonth.substring(5, 7));		
		List<String> daysAndWeekdays = getDaysOfMonth(year, month);

		String division = (String) param.get("dd_division");
		
		for (String days : daysAndWeekdays) {
			int startIndex = days.indexOf('(');
			int endIndex = days.indexOf(')');
			String day = days.substring(startIndex + 1, endIndex); // 요일
			String ddate = days.substring(0, startIndex); //2024-06-01
			param.put("ddate", ddate);
			
			
			/*
			 * if (roomDAO.roomPriceRow(ddate)>0) { roomDAO.updateRoomPrice(param); }
			 */
			
			if (division.equals("C")) {
				if (day.equals("SUNDAY")) {
					logger.info("일요일 : " + ddate);
					roomDAO.updateSundayPrice(param);
				}
			}else if (division.equals("B")) {
				if (day.equals("FRIDAY") || day.equals("SATURDAY")) {
					logger.info("금~토요일 : " + ddate);
					roomDAO.updateWeekendPrice(param);
				}
			}else  {
				if (!day.equals("SUNDAY") && !day.equals("FRIDAY") && !day.equals("SATURDAY")) {
					logger.info("월~목요일 : " + ddate);
					roomDAO.updateWeekdayPrice(param);
				}
			
			}
			
		}
		
		return map;
	}

	public Map<String, Object> insertRoomPirceList(Map<String, Object> param) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		roomDAO.insertRoomPirceList(param);
		map.put("msg", "객실타입 가격 변경");
		
		String yearMonth = (String) param.get("year_month");		
		int year = Integer.parseInt(yearMonth.substring(0, 4));
		int month = Integer.parseInt(yearMonth.substring(5, 7));		
		List<String> daysAndWeekdays = getDaysOfMonth(year, month);
		
		String division = (String) param.get("dd_division");
		
		
		for (String days : daysAndWeekdays) {
			int startIndex = days.indexOf('(');
			int endIndex = days.indexOf(')');
			String day = days.substring(startIndex + 1, endIndex); // 요일
			String ddate = days.substring(0, startIndex); //2024-06-01
			param.put("ddate", ddate);
			
			if (division.equals("C")) {
				if (day.equals("SUNDAY")) {
					logger.info("일요일 : " + ddate);
					roomDAO.sundayPrice(param);
				}
			}else if (division.equals("B")) {
				if (day.equals("FRIDAY") || day.equals("SATURDAY")) {
					logger.info("금~토요일 : " + ddate);
					roomDAO.weekendPrice(param);
				}
			}else  {
				if (!day.equals("SUNDAY") && !day.equals("FRIDAY") && !day.equals("SATURDAY")) {
					logger.info("월~목요일 : " + ddate);
					roomDAO.weekdayPrice(param);
				}
			
			}
						
        }
		
		return map;
	}


	private List<String> getDaysOfMonth(int year, int month) {
		List<String> daysAndWeekdays = new ArrayList<>();
        LocalDate date = LocalDate.of(year, month, 1);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        
        while (date.getMonthValue() == month) {
            String formattedDate = date.format(formatter);
            DayOfWeek dayOfWeek = date.getDayOfWeek();
            String dayOfWeekStr = dayOfWeek.toString();
            daysAndWeekdays.add(formattedDate + " (" + dayOfWeekStr + ")");
            date = date.plusDays(1);
        }
        
		return daysAndWeekdays;
	}

	public int row(String yearMonth, String division) {
		
		return roomDAO.row(yearMonth,division);
	}

	public Map<String, Object> roomPriceCalendarList(String year_month) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<RoomDTO> list = roomDAO.roomPriceCalendarList(year_month);
		
		map.put("list", list);
		return map;
	}

	public Map<String, Object> changeCheckIn(Map<String, Object> param) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String change_room_no = (String) param.get("changeRoom_no");
		String room_no = (String) param.get("room_no");
		String room_div = roomDAO.selectRoomDiv(change_room_no);
		
		if (room_div.equals("A")) {
			// stay테이블에서 투숙한 방번호 바꾸기.
			roomDAO.updateStay(param);
			
			//해당 호수를 이용가능한 방으로 바꾸기.
			roomDAO.updateAvailable(room_no);
			
			// 해당 호수 체크인

			roomDAO.roomCheckIn(change_room_no);
			
			map.put("status", "success");
		}else {
			
			map.put("status", "false");
		}
		
		
		return map;
	}


	public Map<String, Object> updateDayRoomPrice(Map<String, Object> param) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		roomDAO.updateDayRoomPrice(param);
		
		return map;
	}

	public Map<String, Object> roomList() {
		Map<String, Object> map = new HashMap<String, Object>();
				
		List<String> list = roomDAO.roomList();
		
		map.put("list", list);
		
		return map;
	}

	
	public int roomManageWrite(MultipartFile[] photos, RoomDTO room_dto ){
		logger.info("photos : {}",(Object[]) photos);
		int room_no = room_dto.getRoom_no();
		String roomNo = room_no+"";
		if (room_dto != null && "on".equals(room_dto.getUnavailable())) {
		    roomDAO.updateNotAvailable(roomNo);
		}

		
		String room_type ="";
		if (room_dto.getRoom_no() >= 301 || room_dto.getRoom_no()<= 420) {
			room_type = "스탠다드룸";
		} else if (room_dto.getRoom_no() >= 501 || room_dto.getRoom_no()<= 520) {
			room_type="슈페리어룸";
		} else if (room_dto.getRoom_no() >= 601 || room_dto.getRoom_no()<= 620) {
			room_type = "디럭스룸";
		}else {
			room_type = "스위트룸";
		}
		room_dto.setRoom_type(room_type);
		

		roomDAO.roomManageWrite(room_dto);
		
		int room_manage_no = room_dto.getRoom_manage_no();
		logger.info("room_manage_no : " + room_manage_no);
		
		for (MultipartFile photo : photos) {
	         String oriName = photo.getOriginalFilename();
	         logger.info("업로드 파일 이름 : " + oriName);
	         if (!oriName.equals("")) {
	            String ext = oriName.substring(oriName.lastIndexOf("."));
	            
	            String newFileName = System.currentTimeMillis() +ext;
	            logger.info(oriName +" -> "+newFileName);
	            
	            try {
	               byte[] bytes = photo.getBytes();
	               Path path = Paths.get(file_root+newFileName);
	               Files.write(path, bytes);
	               //mypageDAO.introFileCreate(newFileName,userId);
	               roomDAO.photoUpload(newFileName,oriName,room_manage_no);
	               Thread.sleep(1);
	            } catch (Exception e) {
	               
	               e.printStackTrace();
	            }
	   
	         }
	      }
		return room_manage_no;
	}
	
	public void roomManageUpdateDo(MultipartFile[] photos, Map<String, Object> param, int room_manage_no) {
		roomDAO.roomManageUpdateDo(param);
		
		for (MultipartFile photo : photos) {
	         String oriName = photo.getOriginalFilename();
	         logger.info("업로드 파일 이름 : " + oriName);
	         if (!oriName.equals("")) {
	            String ext = oriName.substring(oriName.lastIndexOf("."));
	            
	            String newFileName = System.currentTimeMillis() +ext;
	            logger.info(oriName +" -> "+newFileName);
	            
	            try {
	               byte[] bytes = photo.getBytes();
	               Path path = Paths.get(file_root+newFileName);
	               Files.write(path, bytes);
	               //mypageDAO.introFileCreate(newFileName,userId);
	               roomDAO.photoUpload(newFileName,oriName,room_manage_no);
	               Thread.sleep(1);
	            } catch (Exception e) {
	               
	               e.printStackTrace();
	            }
	   
	         }
	      }
		
	}

	public ModelAndView room_mng_detail(int room_manage_no, String authority) {
		ModelAndView mav = new ModelAndView();
		
		RoomDTO dto = roomDAO.room_mng_detail(room_manage_no);
		String emp_no = dto.getRegister();
		String name = roomDAO.findName(emp_no);		
		dto.setName(name);
		dto.setAuthority(authority);
		List<String> list = roomDAO.photoName(room_manage_no);
		
		mav.addObject("item", dto);
		mav.addObject("photo", list);
		mav.setViewName("/room/roomManageDetail");
		return mav;
	}

	public ModelAndView room_mng_update(int room_manage_no) {
		ModelAndView mav = new ModelAndView();
		
		RoomDTO dto = roomDAO.room_mng_detail(room_manage_no);
		String emp_no = dto.getRegister();
		String name = roomDAO.findName(emp_no);
		dto.setName(name);
		
		List<String> list = roomDAO.photoName(room_manage_no);
		
		mav.addObject("item", dto);
		mav.addObject("photo", list);
		mav.setViewName("/room/roomManageUpdate");
		return mav;
	}

	public void phoDelete(String pho_name) {
		roomDAO.phoDelete(pho_name);
		
	}

	public void room_manage_status_update(int room_manage_no, int room_no, String emp_no) {
		roomDAO.room_manage_status_update(room_manage_no,emp_no);
		String roomNO = room_no+"";
		roomDAO.updateAvailable(roomNO);
	}


}
	

