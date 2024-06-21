package com.connec.tel.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.EmpDTO;

@Mapper
public interface EmpDAO {

	int empRegist(Map<String, String> param);

	void fileWrite(String emp_no, String fileName, String newFileName, String pho_division);

	List<EmpDTO> empList(int start, int pagePerCnt, int categoryNum);

	Object empAllCount(int pagePerCnt, int categoryNum);

	EmpDTO empDetail(String emp_no);

	void empStatus(String emp_no, String register, String join_date);

	EmpDTO UserPhotoLoad(String emp_no);

	void resetPw(String rawPassword);

}
