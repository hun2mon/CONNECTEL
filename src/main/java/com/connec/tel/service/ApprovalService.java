package com.connec.tel.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.dao.ApprovalDAO;
import com.connec.tel.dto.ApprovalDTO;
import com.connec.tel.dto.EmpDTO;

@Service
public class ApprovalService {

	
	@Autowired ApprovalDAO appDAO;
	@Value("${spring.servlet.multipart.location}") private String root;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	
	public Map<String, Object> appLineSave(String[] appLine, String name) {
		Map<String, Object> map = new HashMap<String, Object>();
		ApprovalDTO appDTO = new ApprovalDTO();
		
		appDTO.setApp_line_name(name);
		appDTO.setEmp_no(appLine[0]);
		
		appDAO.appLineName(appDTO);
		
		int idx = appDTO.getApp_line_no();
		logger.info("========idx===========" + idx);
		int procedure = 1;
		int row = 0;
		for (String emp_no : appLine) {
			row = appDAO.appLineSave(idx,emp_no,procedure);
			procedure += 1;
		}
		
		
		map.put("row", row);
		
		
		
		return map;
	}
	public Map<String, Object> lineCall(String emp_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ApprovalDTO> list = appDAO.lineCall(emp_no);
		map.put("list", list);
		return map;
	}
	public Map<String, Object> saveListCall(int app_line_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<EmpDTO> list = appDAO.saveListCall(app_line_no);
		
		map.put("list", list);
		return map;
	}
	public Map<String, Object> savaLineDel(int app_line_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		int row = appDAO.saveLineDel(app_line_no);
		if (row>0) {
			map.put("msg", "삭제되었습니다.");
		}
		return map;
	}
	public String writeDraft(List<String> emp_no, List<String> referrer, List<String> viewer, Map<String, Object> param, MultipartFile[] app_file) {
		String page = "redirect:/approval/draftWrite.go";
		
		int authNo = (int)(Math.random() * (99999 - 10000 + 1)) + 10000;
		String draft_no = "A" + authNo;
		param.put("draft_no", draft_no);
		
		int row = appDAO.writeDraft(param);
		
		if (row > 0) {
			for (int i = 0; i < emp_no.size(); i++) {
				appDAO.approverWrite(draft_no,emp_no.get(i), i+1);				
			}
			
			for (String refer : referrer) {
				if (!refer.equals("0")) {
					appDAO.referrerWrite(draft_no,refer);					
				}
			}
			
			for (String view : viewer) {
				if (!view.equals("0")) {
					appDAO.viewerWrite(draft_no,view);					
				}
			}
			
			appDAO.leaveMng(param);
			
			for (MultipartFile file : app_file) {
				if (!file.isEmpty()) {
					upload(file, draft_no);					
				}
			}	
			page = "redirect:/approval/myApproval.go";
		}
		
		logger.info("row : {}", row);
		
		return page;
	}
	
	
	public void upload(MultipartFile uploadFile, String draft_no) {
		//1. 파일명 추출
		String oriFileName = uploadFile.getOriginalFilename();
		
		//2. 새 파일명 생성
		String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
		String newFileName = System.currentTimeMillis() + ext;
		logger.info(oriFileName + " -> " + newFileName);
		
		//3. 파일 저장
		try {
			byte[] bytes = uploadFile.getBytes();
			Path path = Paths.get(root + "/" + newFileName);
			Files.write(path, bytes);
			appDAO.fileSave(oriFileName, newFileName, draft_no);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	public Map<String, Object> myAppListCall(String search, String page, String cnt, String emp_no, String cate) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int currPage = Integer.parseInt(page);
		int cntt = Integer.parseInt(cnt);
		
		int start = (currPage-1) * cntt;
		
		search = "%" + search + "%";
		
		int totalpage = appDAO.myAppTotalPage(search, cntt, emp_no, cate);
		
		List<ApprovalDTO> list = appDAO.myAppListCall(search, start, cntt,emp_no, cate);
		
		map.put("list", list);
		map.put("currPage", currPage);
		map.put("totalPages", totalpage);
		return map;
	}
	public ModelAndView draftDetail(String draft_no, String draft_status) {
		
		ModelAndView mav = new ModelAndView();
		ApprovalDTO dto;
		
		if (draft_status.equals("T")) {
			logger.info("임시저장");;
		} else {
			dto = appDAO.draftDetail(draft_no);
			mav.addObject("dto", dto);
			logger.info("dto : {}", dto);
			mav.setViewName("approval/approvalDetail");
		}
		
		
		return mav;
	}
	public Map<String, Object> approverCall(String draft_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ApprovalDTO> list = appDAO.appLineCall(draft_no);
		
		map.put("approver", list);
		
		return map;
	}
	
}
