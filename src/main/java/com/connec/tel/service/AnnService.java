package com.connec.tel.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.dao.AnnDAO;
import com.connec.tel.dto.AnnDTO;
import com.connec.tel.dto.EmpDTO;
import com.connec.tel.dto.FaqDTO;

@Service
public class AnnService {
	
	@Autowired AnnDAO annDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	private String file_root = "/Users/junmo/Desktop/photo/";
	
	public Map<String, Object> list(int currPage, int pagePerCnt, String ann_division, String ann_fixed, String ann_date) {
		Map<String, Object>result = new HashMap<String, Object>();
		List<AnnDTO>list = annDAO.list(pagePerCnt,currPage,ann_division,ann_fixed,ann_date);
		EmpDTO dto = new EmpDTO();
		String name = dto.geteName();
		
		result.put("list", list);
		result.put("currPage", currPage);
		result.put("ann_division", ann_division);
		result.put("ann_fixed", ann_fixed);
		result.put("totalPages", annDAO.allCount(pagePerCnt));
		result.put("register", name);
		result.put("ann_date", ann_date);

		
		return result;
	}
	public int deleteann(List<Integer> annNos) {
		return annDAO.deleteann(annNos);
	}
	public String write(MultipartFile[] photos, AnnDTO dto) {
		String page = "";
		int result = annDAO.write(dto);
		String ann_no = dto.getAnn_no();
		if(result > 0) {
			page ="redirect:/ann/empAnnList.go";
			fileSave(ann_no, photos);
		} else {
			page = "ann/empAnnList";
		}
		
		
		return page;
	}
	
public void fileSave(String ann_no, MultipartFile[] photos) {
		
		for (MultipartFile photo : photos) {
			// 1. 업로드할 파일명이 있는가?
			String fileName = photo.getOriginalFilename();
			logger.info("upload file name : "+fileName);
			if(!fileName.equals("")) {
				String ext = fileName.substring(fileName.lastIndexOf("."));
				// 2. 새파일명 생성
				String newFileName = System.currentTimeMillis()+ext;
				logger.info(fileName+" -> "+newFileName);
				//3. 파일 저장
				try {
					byte[] bytes = photo.getBytes(); // MultipartFile 로 부터 바이너리 추출
					Path path = Paths.get(file_root+newFileName);//저장경로지정
					Files.write(path, bytes);//저장
					annDAO.fileWrite(fileName,newFileName,ann_no);
					Thread.sleep(1);//파일명을 위해 강제 휴식 부여
				} catch (Exception e) {
					e.printStackTrace();
				}			
			}		
		}			
	}
public Map<String, Object> search(Map<String, Object> map, String textval) {
	    List<AnnDTO> list = annDAO.search(textval);
	    map.put("list", list);
	    return map;
	}
public ModelAndView annDetail(String ann_no) {
	ModelAndView mav = new ModelAndView();
	AnnDTO dto = annDAO.empanndetail(ann_no);
	
	
	logger.info("디테일");
	mav.addObject("dto", dto);
	mav.addObject("image", annDAO.photo(ann_no));
	
	
	return mav;
}
	
	

}
