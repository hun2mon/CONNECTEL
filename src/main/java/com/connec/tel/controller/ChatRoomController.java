package com.connec.tel.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.connec.tel.dao.MessengerDAO;
import com.connec.tel.dto.ChatRoom;
import com.connec.tel.dto.EmpDTO;
import com.connec.tel.service.ChatRoomRepository;
import com.connec.tel.service.CommonService;

@Controller
@RequestMapping("/chat")
public class ChatRoomController {

	@Autowired MessengerDAO msgDAO;
	 private final ChatRoomRepository chatRoomRepository;
	 Logger logger = LoggerFactory.getLogger(getClass());
	 
	 public ChatRoomController(ChatRoomRepository chatRoomRepository) {
		 this.chatRoomRepository = chatRoomRepository;
	 }
	
	 // 채팅 리스트 화면
	 @GetMapping("/room")
	 public String rooms(Model model) {
	     return "/chat/room";
	 }
	 // 모든 채팅방 목록 반환
	 @GetMapping("/rooms")
	 @ResponseBody
	 public List<ChatRoom> room(String emp_no) {
	     return chatRoomRepository.findAllRoom(emp_no);
	 }
	 // 채팅방 생성
	 @PostMapping("/room")
	 @ResponseBody
	 public ChatRoom createRoom(@RequestBody Map<String, Object> params) {
		 String name = (String) params.get("name");
		 @SuppressWarnings("unchecked")
		 List<String> memberList = (List<String>) params.get("memberList");
	     
		 return chatRoomRepository.createChatRoom(name, memberList);
	 }
	 // 채팅방 입장 화면
	 @GetMapping("/room/enter/{roomId}")
	 @ResponseBody
	 public Map<String, Object> roomDetail(Model model, @PathVariable String roomId) {
		 Map<String, Object> map = new HashMap<String, Object>();
		 List<EmpDTO> chatMemberList = chatRoomRepository.chatMemberList(roomId);
		 map.put("chatMemberList", chatMemberList);
		 map.put("roomId", roomId);
	     return map;
	 }
	 // 특정 채팅방 조회
	 @GetMapping("/room/{roomId}")
	 @ResponseBody
	 public Map<String, ChatRoom> roomInfo(@PathVariable String roomId) {
	     return chatRoomRepository.findRoomById(roomId);
	 }
	 
	 @GetMapping("/content/{roomId}")
	 @ResponseBody
	 public Map<String, Object> contentsCall(@PathVariable String roomId) {
	     return chatRoomRepository.contentsCall(roomId);
	 }
	 
	 @PostMapping("/sendImg")
	 @ResponseBody
	 public Map<String, Object> sendImg(MultipartFile img){
		 Map<String, Object> map = new HashMap<String, Object>();
		 
		 String oriFileName = img.getOriginalFilename();
		 	
		String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
		String newFileName = System.currentTimeMillis() + ext;
		CommonService.upload(img, newFileName);
		
		map.put("newFileName", newFileName);
		
		return map;
	 }
	 
	 @PostMapping("/sendFile")
	 @ResponseBody
	 public Map<String, Object> sendFile(MultipartFile file){
		 Map<String, Object> map = new HashMap<String, Object>();
		 
		 String oriFileName = file.getOriginalFilename();
		 	
		String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
		String newFileName = System.currentTimeMillis() + "_" + oriFileName;
		CommonService.upload(file, newFileName);
		
		map.put("newFileName", newFileName);
		
		return map;
	 }
	 
	 @PostMapping("/plusMember")
	 @ResponseBody
	 public Map<String, Object> plusMember(@RequestBody Map<String, Object> params){
		 return chatRoomRepository.plusMember(params);
	 }
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
}