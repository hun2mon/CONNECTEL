package com.connec.tel.dao;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.ProfileDTO;

@Mapper
public interface ProfileDAO {

	ProfileDTO leaveDetail(String emp_no);

	void changePassword(String encryptedPassword, String emp_no);

}
