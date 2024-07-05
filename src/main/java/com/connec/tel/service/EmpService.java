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
	public String file_root = "/Users/jeounghun/upload/connectel/file/";
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



	public Map<String, Object> empList(int currPage, String searchType, String searchText, String categoryNum) {
		int pagePerCnt = 20;
		int start = (currPage-1)*pagePerCnt;
		logger.info("start" + start);
		Map<String, Object> result = new HashMap<String, Object>();
		List<EmpDTO> resultList = null;
		logger.info("categorynum = " + categoryNum);
	
		resultList = empDAO.empList(start,pagePerCnt,searchText,searchType,categoryNum);


	
		result.put("list", resultList);
		result.put("currPage", currPage);
		result.put("totalPages", empDAO.empAllCount(pagePerCnt,searchText,searchType,categoryNum));
		logger.info("직원 관리에서 받아온 allCount"+empDAO.empAllCount(pagePerCnt,searchText,searchType,categoryNum));
		
		return result;
	}

	public EmpDTO empDetail(String emp_no, Model model) {
	    logger.info("emp_no " + emp_no);
	    
	    // 사진 정보와 휴가 정보를 가져와 모델에 추가
	    EmpDTO photos = empDAO.UserPhotoLoad(emp_no);
	    EmpDTO leave  = empDAO.leaveDetail(emp_no);
	    model.addAttribute("P", photos);
	    model.addAttribute("leave", leave);

	    // 직원 상세 정보를 가져오기
	    EmpDTO dto = empDAO.empDetail(emp_no);

	    // 직급 코드 변환
	    int rank_code = dto.getRank_code();
	    String rank = getRankDescription(rank_code);
	    logger.info("rank: " + rank);
	    model.addAttribute("rank", rank);

	    // 부서 코드 변환
	    int dept_code = dto.getDept_code();
	    String dept = getDeptDescription(dept_code);
	    logger.info("dept: " + dept);
	    model.addAttribute("dept", dept);

	    // dto를 모델에 추가하고 반환
	    model.addAttribute("empDetail", dto);
	    return dto;
	}

	// 직급 코드를 설명으로 변환하는 메서드
	private String getRankDescription(int rank_code) {
	    switch (rank_code) {
	        case 1: return "사장";
	        case 2: return "이사";
	        case 3: return "팀장";
	        case 4: return "과장";
	        case 5: return "대리";
	        case 6: return "사원";
	        default: return "알 수 없음";
	    }
	}

	// 부서 코드를 설명으로 변환하는 메서드
	private String getDeptDescription(int dept_code) {
	    switch (dept_code) {
	        case 11: return "인사팀";
	        case 22: return "시설팀";
	        case 33: return "고객팀";
	        default: return "알 수 없음";
	    }
	}

	public void resetPw(String emp_no) {
		String rawPassword = "1111";
        String encryptedPassword = encryptPassword(rawPassword);
        logger.info("암호화 된 비밀번호 ㅇㅇ" + encryptedPassword);
        empDAO.resetPw(encryptedPassword,emp_no);
		
	}

	public void empEditDo(MultipartFile[] photos, Map<String, String> param, HttpSession session) {
		EmpDTO dto = new EmpDTO();
		dto.setPho_division(param.get("pho_division"));
		int row = empDAO.empEditDo(param);
		
		
		String pho_division = dto.getPho_division();
        if (row>0) {
        	String emp_no = param.get("emp_no");
            String page = "main/main";
            fileSave(emp_no,pho_division,photos);
		}
		
		
		
		
		
	
	}

	public Map<String, Object> leaveList(int currPage, String emp_no) {
		int pagePerCnt = 10;
		int start = (currPage-1)*pagePerCnt;
		logger.info("start" + start);
		Map<String, Object> result = new HashMap<String, Object>();
		List<EmpDTO> resultList = null;
	
		resultList = empDAO.leaveList(start,pagePerCnt,emp_no);

		
	
		result.put("list", resultList);
		result.put("currPage", currPage);
		result.put("totalPages", empDAO.leaveAllCount(pagePerCnt,emp_no));
		logger.info("직원 관리에서 받아온 allCount"+empDAO.leaveAllCount(pagePerCnt,emp_no));
		
		return result;
	}

	public List<EmpDTO> excelList() {
		return empDAO.excelList();
	}
	
}