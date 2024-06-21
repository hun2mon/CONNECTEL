package com.connec.tel.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.connec.tel.dao.EmpDAO;
import com.connec.tel.dto.EmpDTO;

@Service
public class EmpService {
	public String file_root = "C:/upload/";
	@Autowired EmpDAO empDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	public int empRegist(MultipartFile[] photos, Map<String, String> param, HttpSession session) {
		EmpDTO dto = new EmpDTO();
	    String emp_no = generateRandomEmpNo();
	    EmpDTO sessionDTO = (EmpDTO) session.getAttribute("loginInfo");
	    dto.setEmp_no(emp_no);
	    String register = sessionDTO.getEmp_no();
	    logger.info("regist : {}", register);
	    logger.info("전달된 데이터: {}", param);
	    
	    dto.setPho_division(param.get("pho_division"));
	    dto.setRegister(emp_no);
	    param.put("emp_no", emp_no);
	    param.put("register", register);
	    
	    
        String rawPassword = "1111";
        
        String encryptedPassword = encryptPassword(rawPassword);
	    // 이후 dto에 필요한 다른 값들을 설정하고 DB에 등록하는 로직 추가
        param.put("password", encryptedPassword);
        int row = empDAO.empRegist(param);
        String pho_division = dto.getPho_division();
        String join_date = param.get("join_date");
        	
        empDAO.empStatus(emp_no,register,join_date);
        
        if (row>0) {
            String page = "main/main";
            fileSave(emp_no,pho_division,photos);
		}
         
	    return row; // 반환값은 필요에 따라 수정
	}

	// "SH" + 랜덤 숫자 8자리 생성 메서드
	private String generateRandomEmpNo() {
	    Random random = new Random();
	    StringBuilder empNo = new StringBuilder("SH");
	    for (int i = 0; i < 8; i++) {
	        empNo.append(random.nextInt(10)); // 0부터 9까지의 숫자 중에서 랜덤 선택
	    }
	    return empNo.toString();
	}
	
    private String encryptPassword(String password) {
        // BCrypt를 사용한 비밀번호 암호화
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }	
	
    
	public void fileSave(String emp_no, String pho_division, MultipartFile[] photos) {
		logger.info("filesave 도착");
		logger.info(emp_no,pho_division,photos);
	    for (MultipartFile photo : photos) {
	        // 1. 업로드할 파일명이 있는가?
	    	logger.info("emp_no = " + emp_no + "pho_division = " + pho_division);
	        String fileName = photo.getOriginalFilename();
	        logger.info("upload file name : " + fileName);
	        if (!fileName.equals("")) {//파일명이 있다면 == 업로드 파일이 있다면
	            // 1. 기존 파일명에서 확장자 추출(high.gif)
	            /* 1-1. split 활용 방법
	            String arr[] = fileName.split("\\.");            
	            String ext = "." + arr[arr.length-1];
	            */
	            //1-2. subString 활용 방법
	            String ext = fileName.substring(fileName.lastIndexOf("."));
	            // 2. 새파일명 생성
	            String newFileName = System.currentTimeMillis() + ext;
	            logger.info(fileName + " -> " + newFileName);
	            //3. 파일 저장
	            try {
	                byte[] bytes = photo.getBytes(); // MultipartFile 로 부터 바이너리 추출
	                Path path = Paths.get(file_root + newFileName);//저장경로지정
	                Files.write(path, bytes);//저장
	                empDAO.fileWrite(emp_no, fileName, newFileName,  pho_division);
	                Thread.sleep(1);//파일명을 위해 강제 휴식 부여
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
	    }
	}



	public Map<String, Object> empList(int currPage, int categoryNum) {
		int pagePerCnt = 20;
		int start = (currPage-1)*pagePerCnt;
		logger.info("start" + start);
		Map<String, Object> result = new HashMap<String, Object>();
		List<EmpDTO> resultList = null;
		
		resultList = empDAO.empList(start,pagePerCnt,categoryNum);

		for (EmpDTO empDto : resultList) {
			logger.info(empDto.getEmp_no());
		}
	
		result.put("list", resultList);
		result.put("currPage", currPage);
		result.put("totalPages", empDAO.empAllCount(pagePerCnt,categoryNum));
		logger.info("직원 관리에서 받아온 allCount"+empDAO.empAllCount(pagePerCnt,categoryNum));
		
		return result;
	}

	public EmpDTO empDetail(String emp_no, Model model) {
		logger.info("emp_no " + emp_no);
		EmpDTO photos = empDAO.UserPhotoLoad(emp_no);
		
		model.addAttribute("P",photos);
		
		return empDAO.empDetail(emp_no);
	}

	public void resetPw() {
		String rawPassword = "1111";
        String encryptedPassword = encryptPassword(rawPassword);
        
        empDAO.resetPw(rawPassword);

		
	}
	
}