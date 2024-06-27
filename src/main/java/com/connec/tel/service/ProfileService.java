package com.connec.tel.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.connec.tel.dao.ProfileDAO;
import com.connec.tel.dto.ProfileDTO;

@Service
public class ProfileService {
	
	@Autowired ProfileDAO profileDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	public void leaveList(Model model, String emp_no) {

		ProfileDTO leave = profileDAO.leaveDetail(emp_no);
		
		model.addAttribute("leave", leave);
		
	}


	public void changePassword(String new_password, String emp_no) {

		
        String encryptedPassword = encryptPassword(new_password);
        logger.info("암호화 된 비밀번호 ㅇㅇ" + encryptedPassword);
        profileDAO.changePassword(encryptedPassword,emp_no);
	}

	
	
    private String encryptPassword(String password) {
        // BCrypt를 사용한 비밀번호 암호화
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }	
}
