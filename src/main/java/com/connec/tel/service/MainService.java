package com.connec.tel.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.connec.tel.dao.MainDAO;

@Service
public class MainService {
	
	@Autowired MainDAO mainDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	

}
