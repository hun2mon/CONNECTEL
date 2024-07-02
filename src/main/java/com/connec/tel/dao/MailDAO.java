package com.connec.tel.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.MailDTO;
import com.connec.tel.dto.RoomDTO;

@Mapper
public interface MailDAO {

	void mailSave(MailDTO mailDTO);

	void fileUpload(String newFileName, String oriName, int mail_no);

	int totalPage(String search, int cntt, String emp_no);

	List<RoomDTO> sendMailList(String search, int start, int cntt, String emp_no);

	MailDTO mailDetail(String mail_no);

	

}
