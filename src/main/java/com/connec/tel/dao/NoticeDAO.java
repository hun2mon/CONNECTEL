package com.connec.tel.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.NoticeDTO;

@Mapper
public interface NoticeDAO {

	void sendShare(String emp_no, String notificationContent, String noti_link);

	List<NoticeDTO> getNotice(String emp_no);

	boolean deleteId(String noti_idx);

}
