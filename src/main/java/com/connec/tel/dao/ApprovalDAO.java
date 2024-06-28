package com.connec.tel.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.ApprovalDTO;
import com.connec.tel.dto.EmpDTO;

@Mapper
public interface ApprovalDAO {

	int appLineSave(int idx, String emp_no, int procedure);

	int appLineName(String string, String name);

	void appLineName(ApprovalDTO appDTO);

	List<ApprovalDTO> lineCall(String emp_no);

	List<EmpDTO> saveListCall(int app_line_no);

	int saveLineDel(int app_line_no);

	int writeDraft(Map<String, Object> param);

	void approverWrite(String draft_no, String string, int i);

	void referrerWrite(String draft_no, String refer);

	void viewerWrite(String draft_no, String view);

	void fileSave(String oriFileName, String newFileName, String draft_no);
	
	void leaveMng(Map<String, Object> param);

	List<ApprovalDTO> myAppListCall(String search, int start, int cntt, String emp_no, String cate);

	int myAppTotalPage(String search, int cntt, String emp_no, String cate);

	ApprovalDTO draftDetail(String draft_no);

	List<ApprovalDTO> appLineCall(String draft_no);

	int reqAppTotalPage(String search, int cntt, String emp_no, String cate);

	List<ApprovalDTO> reqAppListCall(String search, int start, int cntt, String emp_no, String cate);

	List<Map<String, Object>> fileList(String draft_no);

	int approve(Map<String, Object> param);

	void draftApprove(Map<String, Object> param);

	void leave_mng_approve(Map<String, Object> param);

	void leave_history_add(Map<String, Object> param);

	int app_companion(Map<String, String> param);

	int draft_companion(Map<String, String> param);

	int leave_companion(Map<String, String> param);

}
