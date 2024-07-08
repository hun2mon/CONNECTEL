package com.connec.tel.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.dao.AnnDAO;
import com.connec.tel.dto.AnnDTO;
import com.connec.tel.dto.EmpDTO;
import com.connec.tel.dto.FaqDTO;

@Service
public class AnnService {
	
	@Autowired AnnDAO annDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	private String file_root = "/Users/junmo/Desktop/photo/";
	
	public Map<String, Object> list(int currPage, int pagePerCnt, String ann_division, String ann_fixed, String ann_date) {
		Map<String, Object>result = new HashMap<String, Object>();
		List<AnnDTO>list = annDAO.list(pagePerCnt,currPage,ann_division,ann_fixed,ann_date);
		EmpDTO dto = new EmpDTO();
		String name = dto.geteName();
		
		result.put("list", list);
		result.put("currPage", currPage);
		result.put("ann_division", ann_division);
		result.put("ann_fixed", ann_fixed);
		result.put("totalPages", annDAO.allCount(pagePerCnt));
		result.put("register", name);
		result.put("ann_date", ann_date);

		
		return result;
	}
	
	
	
	public int deleteempann(List<Integer> annNos) {
		return annDAO.deleteempann(annNos);
	}
	public String write(MultipartFile[] photos, AnnDTO dto) {
		String page = "";
		int result = annDAO.write(dto);
		String ann_no = dto.getAnn_no();
		if(result > 0) {
			page ="redirect:/ann/empAnnList.go";
			fileSave(ann_no, photos);
		} else {
			page = "ann/empAnnList";
		}
		
		
		return page;
	}
	
public void fileSave(String ann_no, MultipartFile[] photos) {
		
		for (MultipartFile photo : photos) {
			// 1. 업로드할 파일명이 있는가?
			String fileName = photo.getOriginalFilename();
			logger.info("upload file name : "+fileName);
			if(!fileName.equals("")) {
				String ext = fileName.substring(fileName.lastIndexOf("."));
				// 2. 새파일명 생성
				String newFileName = System.currentTimeMillis()+ext;
				logger.info(fileName+" -> "+newFileName);
				//3. 파일 저장
				try {
					byte[] bytes = photo.getBytes(); // MultipartFile 로 부터 바이너리 추출
					Path path = Paths.get(file_root+newFileName);//저장경로지정
					Files.write(path, bytes);//저장
					annDAO.fileWrite(fileName,newFileName,ann_no);
					Thread.sleep(1);//파일명을 위해 강제 휴식 부여
				} catch (Exception e) {
					e.printStackTrace();
				}			
			}		
		}			
	}
public Map<String, Object> search(Map<String, Object> map, String textval) {
	    List<AnnDTO> list = annDAO.search(textval);
	    map.put("list", list);
	    return map;
	}


public ModelAndView annDetail(String ann_no) {
	ModelAndView mav = new ModelAndView();
	AnnDTO dto = annDAO.empanndetail(ann_no);
	
	
	logger.info("디테일");
	mav.addObject("dto", dto);
	mav.addObject("image", annDAO.photo(ann_no));
	mav.setViewName("ann/empAnndetail");
	
	return mav;
}


public int countann_fixed(Map<String, String> param) {
	
	return  annDAO.count(param);
}
	
public int getFixedCount() {
    return annDAO.getFixedCount();
}

public void unfixAnnouncements(List<Integer> annNos) {
    for (Integer annNo : annNos) {
        annDAO.unfixAnnouncement(annNo);
    }
}


public Map<String, Object> annlist(int currPage, int pagePerCnt, String ann_division, String ann_fixed, String ann_date) {
	Map<String, Object>result = new HashMap<String, Object>();
	List<AnnDTO>list = annDAO.annlist(pagePerCnt,currPage,ann_division,ann_fixed,ann_date);
	EmpDTO dto = new EmpDTO();
	String name = dto.geteName();
	
	result.put("list", list);
	result.put("currPage", currPage);
	result.put("ann_division", ann_division);
	result.put("ann_fixed", ann_fixed);
	result.put("totalPages", annDAO.annallCount(pagePerCnt));
	result.put("register", name);
	result.put("ann_date", ann_date);

	
	return result;
}

public String empupdateann(AnnDTO annDTO, MultipartFile[] newphoto, MultipartFile[] newfile) {
	String page = "";
	logger.info("업데이트 서비스 셈");
	logger.info("ann_no: " + annDTO.getAnn_no());
	int result = annDAO.annupdate(annDTO);
	String ann_no = annDTO.getAnn_no();
	if(result > 0) {
		logger.info("데이터 들어감?");
		page ="redirect:/ann/empAnnList.go";
		empupdatefileSave(ann_no, newphoto);
		empupdateannfile(newfile, ann_no);
	} else {
		logger.info("팅긴거임 ㅋㅋ");
		page = "ann/empAnnList";
	}
	
	
	return page;	
}

public void empupdatefileSave(String ann_no, MultipartFile[] newphoto) {
    for (MultipartFile photo : newphoto) {
        String fileName = photo.getOriginalFilename();
        logger.info("upload file name : " + fileName);
        if(fileName.equals("")) {
        	annDAO.deletephoto(ann_no);
        }else if (!fileName.equals("")) {
            String ext = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = System.currentTimeMillis() + ext;
            logger.info(fileName + " -> " + newFileName);
            try {
                byte[] bytes = photo.getBytes();
                Path path = Paths.get(file_root + newFileName);
                Files.write(path, bytes);
                Map<String, String> paramMap = new HashMap<>();
                paramMap.put("ori_pho_name", fileName);
                paramMap.put("pho_name", newFileName);
                paramMap.put("ann_no", ann_no);
                if(annDAO.photoname(ann_no)== null) {
                	annDAO.annfileWrite(fileName, newFileName, ann_no);
                }else {
                annDAO.updatefileWrite(paramMap);
                }
                Thread.sleep(1);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

public void empupdateannfile(MultipartFile[] newfile, String ann_no) {
    for (MultipartFile files : newfile) {
        String fileName = files.getOriginalFilename();
        logger.info("upload file name : " + fileName);
        if(fileName.equals("")) {
        	annDAO.deletefile(ann_no);
        }else if (!fileName.equals("")) {
            String ext = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = System.currentTimeMillis() + ext;
            logger.info(fileName + " -> " + newFileName);
            try {
                byte[] bytes = files.getBytes();
                Path path = Paths.get(file_root + newFileName);
                Files.write(path, bytes);
                Map<String, String> paramMap = new HashMap<>();
                paramMap.put("ori_file_name", fileName);
                paramMap.put("file_name", newFileName);
                paramMap.put("ann_no", ann_no);
                if(annDAO.annfile(ann_no)==null) {
                	annDAO.annnewfileWrite(fileName, newFileName, ann_no);
                }else {	
                annDAO.updatenewfile(paramMap);
                }
                Thread.sleep(1);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}







/*                      고객 공지사항 서비스                    */




public String annwrite(MultipartFile[] photos, AnnDTO dto, MultipartFile[] file) {
	String page = "";
	int result = annDAO.annwrite(dto);
	String ann_no = dto.getAnn_no();
	if(result > 0) {
		page ="redirect:/ann/annList.go";
		annfileSave(ann_no, photos);
		annfilewrite(file, ann_no);
	} else {
		page = "ann/annList";
	}
	
	
	return page;
}

public void annfileSave(String ann_no, MultipartFile[] photos) {
	
	for (MultipartFile photo : photos) {
		// 1. 업로드할 파일명이 있는가?
		String fileName = photo.getOriginalFilename();
		logger.info("upload file name : "+fileName);
		if(!fileName.equals("")) {
			String ext = fileName.substring(fileName.lastIndexOf("."));
			// 2. 새파일명 생성
			String newFileName = System.currentTimeMillis()+ext;
			logger.info(fileName+" -> "+newFileName);
			//3. 파일 저장
			try {
				byte[] bytes = photo.getBytes(); // MultipartFile 로 부터 바이너리 추출
				Path path = Paths.get(file_root+newFileName);//저장경로지정
				Files.write(path, bytes);//저장
				annDAO.annfileWrite(fileName,newFileName,ann_no);
				Thread.sleep(1);//파일명을 위해 강제 휴식 부여
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}		
	}			
}

public void annfilewrite(MultipartFile[] file, String ann_no) {
	for (MultipartFile files : file) {
		// 1. 업로드할 파일명이 있는가?
		String fileName = files.getOriginalFilename();
		logger.info("upload file name : "+fileName);
		
		if(!fileName.equals("")) {
			String ext = fileName.substring(fileName.lastIndexOf("."));
			// 2. 새파일명 생성
			String newFileName = System.currentTimeMillis()+ext;
			logger.info(fileName+" -> "+newFileName);
			//3. 파일 저장
			try {
				byte[] bytes = files.getBytes(); // MultipartFile 로 부터 바이너리 추출
				Path path = Paths.get(file_root+newFileName);//저장경로지정
				Files.write(path, bytes);//저장
				annDAO.annnewfileWrite(fileName,newFileName,ann_no);
				Thread.sleep(1);//파일명을 위해 강제 휴식 부여
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}		
	}			
	
}



public int anncountann_fixed(Map<String, String> param) {
	
	return  annDAO.anncount(param);
}

public int anngetFixedCount() {
    return annDAO.anngetFixedCount();
}

public void annunfixAnnouncements(List<Integer> annNos) {
    for (Integer annNo : annNos) {
        annDAO.annunfixAnnouncement(annNo);
    }
}




public ModelAndView empannDetail(String ann_no) {
	ModelAndView mav = new ModelAndView();
	AnnDTO dto = annDAO.empanndetail(ann_no);
	
	annDAO.increasebHitCount(ann_no);
	logger.info("직원디테일");
	mav.addObject("dto", dto);
	mav.addObject("image", annDAO.photo(ann_no));
	mav.addObject("file", annDAO.annfile(ann_no));
	mav.setViewName("/ann/empAnndetail");
	
	return mav;
}

public ModelAndView annDetaildo(String ann_no) {
	ModelAndView mav = new ModelAndView();
	AnnDTO dto = annDAO.anndetail(ann_no);
	
	 annDAO.increaseCount(ann_no);
	logger.info("고객디테일");
	mav.addObject("dto", dto);
	mav.addObject("image", annDAO.annphoto(ann_no));
	mav.addObject("file", annDAO.annfile(ann_no));
	mav.setViewName("/ann/anndetail");
	
	return mav;
}

public int deleteann(List<Integer> annNos) {
	return annDAO.deleteann(annNos);
}

public Map<String, Object> annsearch(Map<String, Object> map, String textval) {
    List<AnnDTO> list = annDAO.annsearch(textval);
    map.put("list", list);
    return map;
}



public AnnDTO getannById(String ann_no) {
	
	return annDAO.getannbyId(ann_no);
}



public String updateAnn(AnnDTO annDTO, MultipartFile[] newphoto, MultipartFile[] newfile) {
    String page = "";
    logger.info("업데이트 서비스 셈");
    logger.info("ann_no: " + annDTO.getAnn_no());
    int result = annDAO.annupdate(annDTO);
    String ann_no = annDTO.getAnn_no();
    
    if (result > 0) {
        logger.info("데이터 업데이트 성공");
        page = "redirect:/ann/annList.go";
        
        // 기존 사진 삭제 처리
        if (newphoto == null || newphoto.length == 0) {
            annDAO.deletephoto(ann_no);
        } else {
            updatefileSave(ann_no, newphoto); // 새로운 사진 업로드
        }
        
        // 기존 파일 삭제 처리
        if (newfile == null || newfile.length == 0) {
            annDAO.deletefile(ann_no);
        } else {
            updateAnnFile(newfile, ann_no); // 새로운 파일 업로드
        }
    } else {
        logger.info("데이터 업데이트 실패");
        page = "ann/annList"; // 실패 시 처리할 페이지
    }
    
    return page;    
}

public void updatefileSave(String ann_no, MultipartFile[] newphoto) {
    for (MultipartFile photo : newphoto) {
        String fileName = photo.getOriginalFilename();
        logger.info("upload 사 name : " + fileName);
        if(fileName.equals("")) {
        	annDAO.deletephoto(ann_no);
        }
        else if (!fileName.equals("")) {
            String ext = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = System.currentTimeMillis() + ext;
            logger.info(fileName + " -> " + newFileName);
            try {
                byte[] bytes = photo.getBytes();
                Path path = Paths.get(file_root + newFileName);
                Files.write(path, bytes);
                Map<String, String> paramMap = new HashMap<>();
                paramMap.put("ori_pho_name", fileName);
                paramMap.put("pho_name", newFileName);
                paramMap.put("ann_no", ann_no);
                if(annDAO.photoname(ann_no)== null) {
                	
                	annDAO.annfileWrite(fileName, newFileName, ann_no);
                
                }else {
                annDAO.updatefileWrite(paramMap);
                }
                Thread.sleep(1);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
  
        
    }
}

public void updateAnnFile(MultipartFile[] newfile, String ann_no) {
    for (MultipartFile file : newfile) {
        String fileName = file.getOriginalFilename();
        logger.info("upload 파일 name : " + fileName);
        if(fileName.equals("")) {
        	annDAO.deletefile(ann_no);
        }else if (!fileName.equals("")) {
            String ext = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = System.currentTimeMillis() + ext;
            logger.info(fileName + " -> " + newFileName);
            try {
                byte[] bytes = file.getBytes();
                Path path = Paths.get(file_root + newFileName);
                Files.write(path, bytes);
                Map<String, String> paramMap = new HashMap<>();
                paramMap.put("ori_file_name", fileName);
                paramMap.put("file_name", newFileName);
                paramMap.put("ann_no", ann_no);
                if(annDAO.annfile(ann_no)==null) {
                	annDAO.annnewfileWrite(fileName, newFileName, ann_no);
                }else {	
                annDAO.updatenewfile(paramMap);
                }
                Thread.sleep(1);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}






public String photoname(String ann_no) {

	return annDAO.photoname(ann_no);
}



public String filename(String ann_no) {
	
	return annDAO.annfile(ann_no);
}




}
