package com.connec.tel.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.connec.tel.dao.EquipmentDAO;

@Service
public class EquipmentService {
	
	@Autowired EquipmentDAO equipDAO;
	Logger logger = LoggerFactory.getLogger(getClass());

}
