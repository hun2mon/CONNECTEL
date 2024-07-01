package com.connec.tel.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.EmpDTO;

@Mapper
public interface LoginDAO {

	EmpDTO login(String id);

	float leftOver(String emp_no);

}
