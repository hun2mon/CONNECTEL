package com.connec.tel.service;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.dao.ApprovalDAO;
import com.connec.tel.dto.ApprovalDTO;
import com.connec.tel.dto.EmpDTO;

@Service
public class ApprovalService {

	
	@Autowired ApprovalDAO appDAO;
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
			dto = appDAO.draftTemporary(draft_no);
			
			mav.addObject("dto", dto);
		
			mav.setViewName("approval/draftWrite");
		} else {
			dto = appDAO.draftDetail(draft_no);
			
			mav.addObject("dto", dto);
			
			mav.setViewName("approval/approvalDetail");
		}
		
		
		return mav;
	}
	
	public Map<String, Object> approverCall(String draft_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ApprovalDTO> list = appDAO.appLineCall(draft_no);
		List<Map<String, Object>> fileList = appDAO.fileList(draft_no);
		
		map.put("fileList", fileList);
		map.put("approver", list);
		
		return map;
	}
	
	public Map<String, Object> draftWrite(Map<String, Object> params) {
		
		Map<String, Object>map = new HashMap<String, Object>();
		
		logger.info("params : {}", params);
		@SuppressWarnings("unchecked")
		Map<String, Object> param = (Map<String, Object>) params.get("param");
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> approvers = (List<Map<String, Object>>) params.get("approvers");
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> referrers = (List<Map<String, Object>>) params.get("referrer");
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> viewers = (List<Map<String, Object>>) params.get("viewer");
		
		
		int authNo = (int)(Math.random() * (99999 - 10000 + 1)) + 10000;
		String draft_no = "A" + authNo;
		param.put("draft_no", draft_no);
		
		int row = appDAO.writeDraft(param);
		String emp_no = "";
		
		if (row > 0) {
			for (int i = 0; i < approvers.size(); i++) {
				emp_no = String.valueOf(approvers.get(i).get("emp_no"));
				appDAO.approverWrite(draft_no, emp_no, i+1);				
			}
			
			for (int i = 0; i < referrers.size(); i++) {
				emp_no = String.valueOf(referrers.get(i).get("emp_no"));
				appDAO.referrerWrite(draft_no, emp_no);				
			}
			
			for (int i = 0; i < viewers.size(); i++) {
				emp_no = String.valueOf(viewers.get(i).get("emp_no"));
				appDAO.viewerWrite(draft_no, emp_no);				
			}
			
			appDAO.leaveMng(param);
			
			map.put("draft_no", draft_no);
		}
		return map;
	}
	
	public String fileSave(MultipartFile[] app_file, String draft_no) {
		if (app_file.length != 0) {
			for (MultipartFile file : app_file) {
				if (file.isEmpty()) {
					return "redirect:/approval/myApproval.go";
				}else {
					String oriFileName = file.getOriginalFilename();
					
					//2. 새 파일명 생성
					String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
					String newFileName = System.currentTimeMillis() + ext;
					CommonService.upload(file, newFileName);
					appDAO.fileSave(file.getOriginalFilename(), newFileName, draft_no);					
				}
			}			
		}
		return "redirect:/approval/myApproval.go";
	}
	
	public Map<String, Object> reqAppListCall(String search, String page, String cnt, String emp_no, String cate) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int currPage = Integer.parseInt(page);
		int cntt = Integer.parseInt(cnt);
		
		int start = (currPage-1) * cntt;
		
		search = "%" + search + "%";
		
		int totalpage = appDAO.reqAppTotalPage(search, cntt, emp_no, cate);
		
		List<ApprovalDTO> list = appDAO.reqAppListCall(search, start, cntt,emp_no, cate);
		
		map.put("list", list);
		map.put("currPage", currPage);
		map.put("totalPages", totalpage);
		return map;
		
	}
	public Map<String, Object> approve(Map<String, Object> param) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String emp_no = (String) param.get("emp_no");
		int procedure = Integer.parseInt((String) param.get("procedure"));
		int max_procedure = Integer.parseInt((String) param.get("max_procedure"));
		int row = 0;
		
		if (procedure != max_procedure) {
			logger.info("중간결재자 : {}", emp_no);
			row = appDAO.approve(param);
			if (row > 0) {
				map.put("msg", "결재 완료되었습니다.");
			}
		} else {
			logger.info("최종 결재자 : {}", emp_no);
			row = appDAO.approve(param);
			if (row > 0) {
				appDAO.draftApprove(param);
				appDAO.leave_mng_approve(param);
				appDAO.leave_history_add(param);
			}
		}
		
		return map;
	}
	public Map<String, Object> companion(Map<String, String> param) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int app_row = appDAO.app_companion(param);
		int draft_row = appDAO.draft_companion(param);
		int leave_row = appDAO.leave_companion(param);
		if (app_row > 0 && draft_row > 0 && leave_row > 0) {
			map.put("msg", "기안서가 반려되었습니다.");
		}
		
		return map;
	}
	public Map<String, Object> availableViewListCall(String search, String page, String cnt, String emp_no, String cate, String dept_code) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int currPage = Integer.parseInt(page);
		int cntt = Integer.parseInt(cnt);
		
		int start = (currPage-1) * cntt;
		
		search = "%" + search + "%";
		
		int totalpage = appDAO.availableTotalPage(search, cntt, emp_no, cate, dept_code);
		
		List<ApprovalDTO> list = appDAO.availableViewListCall(search, start, cntt,emp_no, cate, dept_code);
		
		map.put("list", list);
		map.put("currPage", currPage);
		map.put("totalPages", totalpage);
		return map;
	}
	
	public Map<String, Object> compReason(String draft_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		String reason = appDAO.compReason(draft_no);
		map.put("reason", reason);
	
		return map;
	}
	
	public Map<String, Object> compApproverCall(String draft_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<EmpDTO> appList = appDAO.approvers(draft_no);
		List<ApprovalDTO> refList = appDAO.referrers(draft_no);
		List<ApprovalDTO> viewList = appDAO.views(draft_no);
		map.put("appList", appList);
		map.put("refList", refList);
		map.put("viewList", viewList);
		return map;
	}
	
	public Map<String, Object> delDraft(String draft_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int row = appDAO.delDraft(draft_no);
		
		if (row > 0) {
			map.put("msg", "삭제되었습니다.");
		} else {
			map.put("msg", "삭제 되지 않았습니다.");
		}
		
		return map;
	}

	public void deadLineCheck() {
		
		LocalDate now = LocalDate.now();
		
		List<String> draft_no_list = appDAO.deadLineCheck(now);
		
		if (draft_no_list.size() > 0) {
			for (String draft_no : draft_no_list) {
				appDAO.rejectDraft(draft_no);
				appDAO.rejectLeave(draft_no);
			}
		}
	}
	
}
