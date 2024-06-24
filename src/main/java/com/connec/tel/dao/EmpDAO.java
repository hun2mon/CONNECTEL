package com.connec.tel.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.EmpDTO;

@Mapper
public interface EmpDAO {

	int empRegist(Map<String, String> param);

	void fileWrite(String emp_no, String fileName, String newFileName, String pho_division);

	List<EmpDTO> empList(int start, int pagePerCnt, String searchText, String searchType, String categoryNum);

	Object empAllCount(int pagePerCnt, String searchText, String searchType, String categoryNum);

	EmpDTO empDetail(String emp_no);

	void empStatus(String emp_no, String register, String join_date);

	EmpDTO UserPhotoLoad(String emp_no);

	void resetPw(String rawPassword);

	void empEdit(String emp_no);

	int empEditDo(Map<String, String> param);

	List<EmpDTO> leaveList(int start, int pagePerCnt, String emp_no);

	Object leaveAllCount(int pagePerCnt, String emp_no);

	EmpDTO leaveDetail(String emp_no);

}
