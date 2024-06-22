package com.connec.tel.dao;

import java.util.List;

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

}
