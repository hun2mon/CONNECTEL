package com.connec.tel.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.connec.tel.dto.RoomDTO;

@Mapper
public interface RoomDAO {

	List<RoomDTO> liveRoomManageAjax();

}
