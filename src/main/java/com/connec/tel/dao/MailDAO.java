package com.connec.tel.dao;

import java.util.List;
import java.util.Map;

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

	void mail_delete(String mail_no);

	List<String> mailFile(String mail_no);

	void mailTempSave(Map<String, Object> param);

	int tempTotalPage(String search, int cntt, String emp_no);

	List<RoomDTO> TempMailList(String search, int start, int cntt, String emp_no);

	List<MailDTO> clientAddListCall();

	void addAddress(Map<String, Object> param);

	int myAddressTotalPage(String search, int cntt, String emp_no);

	List<RoomDTO> myAddressList(String search, int start, int cntt, String emp_no);

	int clentTotalPage(String search, int cntt);

	List<RoomDTO> clentList(String search, int start, int cntt);

	

}
