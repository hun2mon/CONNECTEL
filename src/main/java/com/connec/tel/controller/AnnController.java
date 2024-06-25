package com.connec.tel.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.dto.AnnDTO;
import com.connec.tel.dto.EmpDTO;
import com.connec.tel.service.AnnService;

@Controller
public class AnnController {
	
	@Autowired AnnService annService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	

    @RequestMapping(value="/empann/annList.ajax")
    @ResponseBody
    public Map<String, Object> annList(String page, String cnt, String ann_division, String ann_bHit, String ann_fixed, String register, String ann_date){
        logger.info("직원 공지사항 요청");
        logger.info("cnt :"+cnt);
        logger.info("직원 ="+ ann_division);
        logger.info("날짜 :"+ann_date);
        
        
        int currPage = Integer.parseInt(page);
        int pagePerCnt = Integer.parseInt(cnt);
        
        return annService.list(currPage, pagePerCnt, ann_division, ann_fixed, register);
    }
	@RequestMapping(value="/empannwrite.go")
	public String annwrite(HttpSession session, Model model) {
		EmpDTO loginDTO = (EmpDTO)session.getAttribute("loginInfo");
		model.addAttribute("name", loginDTO.getName());
		
		return"/ann/empAnnWrite";
	}
	
	@PostMapping("/empannwrite.do")
	public String write(@RequestParam("photos") MultipartFile[] photos,
	                          @RequestParam Map<String, String> param,HttpSession session) {
		logger.info("컨트롤러 도착");
		logger.info("param {}",param);
		logger.info("사진 :"+photos);
		EmpDTO empDTO = (EmpDTO) session.getAttribute("loginInfo");
	    AnnDTO dto = new AnnDTO();
	    dto.setAnn_subject(param.get("ann_subject")); // 예시: subject 필드를 DTO에 매핑
	    dto.setAnn_content(param.get("textcontent")); // 예시: textcontent 필드를 DTO에 매핑
	    dto.setAnn_division(param.get("ann_division")); // 예시: ann_division 필드를 DTO에 매핑
	    dto.setRegister(empDTO.getEmp_no());
	   
	    
	    return annService.write(photos, dto);
	}
	
	
	
	
	
	@PostMapping("/empann/deleteempann.ajax")
	@ResponseBody
	public ResponseEntity<String> deleteFaq(@RequestBody List<Integer> annNos) {
		logger.info("삭제 요청 공지 번호: " + annNos);
		
		int result = annService.deleteann	(annNos);
		if (result > 0) {
			return new ResponseEntity<>("공지 삭제 성공", HttpStatus.OK);
		} else {
			return new ResponseEntity<>("공지 삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@RequestMapping(value = "/empann/search.ajax")
	@ResponseBody
	public Map<String, Object> noticeSearch(@RequestParam("textval") String textval, @RequestParam("page") String page) {
	    Map<String, Object> map = new HashMap<>();
	    annService.search(map, textval);
	    logger.info("서칭");
	    logger.info("텍스트: " + textval);

	    return map;
	}
	
	@GetMapping(value="/empannDetail.go")
	public ModelAndView empannDetail(String ann_no) {
		logger.info("디테일 요청함");
		logger.info("넘버"+ann_no);
		return annService.annDetail(ann_no);
	}
	
	
	
	
	
	
	

}
