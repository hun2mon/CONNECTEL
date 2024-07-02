package com.connec.tel.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MessengerDAO {

	void createRoom(String roomId, String name, String emp_no);

}
