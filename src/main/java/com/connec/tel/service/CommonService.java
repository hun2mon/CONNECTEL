package com.connec.tel.service;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.connec.tel.dao.CommonDAO;
import com.connec.tel.dto.EmpDTO;

@Service
public class CommonService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired CommonDAO commonDAO;
	static String root = "/Users/junmo/Desktop/photo/";
	
	public Map<String, Object> treeCall() {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<EmpDTO> list = commonDAO.treeCall();
		
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
		// 특정 경로에서 파일을 읽어와 Resourse로 만든다.
		Resource resource = new FileSystemResource(root + "/" + fileName);
		HttpHeaders header = new HttpHeaders();
			
		try {
			// image/... 는 이미지, text/.... 는 문자열, application/octet-stream 는 바이너리
			header.add("content-type", "application/octet-stream");
			// 보낼 파일 이름
			// content-Disposition 는 내다 보내려는 컨텐트의 형태를 의미한다. inline 이면 문자열, attachment 는 다운로드 파일을 의미
			// attachment;filename="fileName.jpg"
			// 이때 파일명이 한글일 경우 깨져서 다운로드 된다. 그래서 안전하게 인코딩 해준다,
			String oriFile = URLEncoder.encode("첨부파일" + fileName,"UTF-8");
			logger.info("oriFile : {}", oriFile);
			header.add("content-Disposition", "attachment;filename=\""+ oriFile +"\"");
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 보낼 내용, 헤더, 상태(200 또느 OK는 정상이라는 뜻)
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
	}
	
}
