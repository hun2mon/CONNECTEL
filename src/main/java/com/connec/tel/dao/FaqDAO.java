package com.connec.tel.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.FaqDTO;


@Mapper
public interface FaqDAO {


	List<FaqDTO> list();



}
