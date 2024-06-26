package com.connec.tel.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.connec.tel.dao.CommonDAO;
import com.connec.tel.dto.EmpDTO;

@Service
public class CommonService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired CommonDAO commonDAO;
	static String root = "/Users/jeounghun/upload/connectel/file/";
	
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
	
	
	public static void upload(MultipartFile uploadFile) {
		try {
			byte[] bytes = uploadFile.getBytes();
			Path path = Paths.get(root + "/" + uploadFile.getOriginalFilename());
			Files.write(path, bytes);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
}
