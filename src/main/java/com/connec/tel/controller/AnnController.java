package com.connec.tel.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.dto.AnnDTO;
import com.connec.tel.dto.EmpDTO;
import com.connec.tel.dto.FaqDTO;
import com.connec.tel.service.AnnService;

@Controller
public class AnnController {
	
	@Autowired AnnService annService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
// 직원 공지사항 리스트 아작스
    @RequestMapping(value="/empann/annList.ajax")
    @ResponseBody
    public Map<String, Object> empannList(String page, String cnt, String ann_division, String ann_bHit, String ann_fixed, String register, String ann_date){
        logger.info("직원 공지사항 요청");
        logger.info("cnt :"+cnt);
        logger.info("직원 ="+ ann_division);
        logger.info("날짜 :"+ann_date);
        
        int currPage = Integer.parseInt(page);
        int pagePerCnt = Integer.parseInt(cnt);
        
        return annService.list(currPage, pagePerCnt, ann_division, ann_fixed, register);
    }
    
    
    
// 직원 공지사항 글쓰기 페이지 가기.
	@RequestMapping(value="/empannwrite.go")
	public String empannwrite(HttpSession session, Model model) {
		EmpDTO loginDTO = (EmpDTO)session.getAttribute("loginInfo");
		model.addAttribute("name", loginDTO.getName());
		
		return"/ann/empAnnWrite";
	}
	
// 직원 공지 글  쓰기.
	@PostMapping("/empannwrite.do")
	public String write(@RequestParam("photos") MultipartFile[] photos,
	                    @RequestParam Map<String, String> param,
	                    HttpSession session,
	                    Model model) {
	    logger.info("컨트롤러 도착");
	    logger.info("param {}", param);
	    logger.info("사진 :" + photos);

	    EmpDTO empDTO = (EmpDTO) session.getAttribute("loginInfo");
	    AnnDTO dto = new AnnDTO();
	    dto.setAnn_subject(param.get("ann_subject"));
	    dto.setAnn_content(param.get("textcontent"));
	    dto.setAnn_division(param.get("ann_division"));
	    dto.setAnn_fixed(param.get("ann_fixed"));
	    dto.setRegister(empDTO.getEmp_no());

	    int countann_fixed = annService.countann_fixed(param);

	    // 상단고정된 공지사항이 5개 이상인 경우 등록을 막음
	    if ("Y".equals(dto.getAnn_fixed()) && countann_fixed >= 5) {
	        model.addAttribute("error", "최대 5개까지 등록이 가능합니다. 목록에서 지우고 다시 시도해주세요.");
	        model.addAttribute("ann_subject", param.get("ann_subject"));
	        model.addAttribute("textcontent", param.get("textcontent"));
	        model.addAttribute("ann_division", param.get("ann_division"));
	        model.addAttribute("ann_fixed", param.get("ann_fixed"));
	        model.addAttribute("name", empDTO.getName()); // 작성자 이름 추가
	        return "/ann/empAnnWrite";  // 글쓰기 페이지로 다시 이동
	    }

	    annService.write(photos, dto);
	    return "redirect:/ann/empAnnList.go";  // 성공 시 목록 페이지로 이동
	}
	
	
	
	@GetMapping("/empann/fixedCount.ajax")
	@ResponseBody
	public Map<String, Integer> getFixedCount() {
	    int fixedCount = annService.getFixedCount();
	    Map<String, Integer> response = new HashMap<>();
	    response.put("fixedCount", fixedCount);
	    return response;
	}

	@PostMapping("/empann/unfixann.ajax")
	@ResponseBody
	public String unfixAnnouncements(@RequestBody List<Integer> annNos) {
	    try {
	        annService.unfixAnnouncements(annNos);
	        return "success";
	    } catch (Exception e) {
	        return "error";
	    }
	}
	
	
	
	
	
	@PostMapping("/empann/deleteempann.ajax")
	@ResponseBody
	public ResponseEntity<String> deleteFaq(@RequestBody List<Integer> annNos) {
		logger.info("삭제 요청 공지 번호: " + annNos);
		
		int result = annService.deleteempann(annNos);
		if (result > 0) {
			return new ResponseEntity<>("공지 삭제 성공", HttpStatus.OK);
		} else {
			return new ResponseEntity<>("공지 삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	
	@RequestMapping(value = "/empann/search.ajax")
	@ResponseBody
	public Map<String, Object> noticeSearch(@RequestParam("textval") String textval, @RequestParam("page") String page) {
	    Map<String, Object> map = new HashMap<>();
	    annService.search(map, textval);
	    logger.info("서칭");
	    logger.info("텍스트: " + textval);

	    return map;
	}
	
	@GetMapping(value="/empannDetail.go")
	public ModelAndView empannDetail(String ann_no) {
		logger.info("디테일 요청함");
		logger.info("넘버"+ann_no);
		return annService.empannDetail(ann_no);
	}
	
	
	
	@GetMapping("/empannupdate.go")
 	public ModelAndView empUpdateForm(@RequestParam("ann_no") String ann_no) {
 	    AnnDTO ann = annService.getannById(ann_no);
 	    logger.info("업데이트 창 이동");
 	    String image = annService.photoname(ann_no); // 변수명을 image로 수정
 	    String file = annService.filename(ann_no);
 	    ModelAndView mav = new ModelAndView("/ann/empAnnEdit");
 	    mav.addObject("dto", ann);
 	    mav.addObject("image", image); // JSP에서 사용할 변수명을 image로 설정
 	    mav.addObject("file", file);
 	    return mav;
 	}
	
 	@PostMapping("/ann/empannupdate.do")
 	public String empupdateAnn(AnnDTO annDTO,
 	                        @RequestParam("new_photo") MultipartFile[] newphoto,
 	                        @RequestParam("new_file") MultipartFile[] newfile,
 	                        HttpSession session) {
 	    logger.info("업데이트 시도");
 	   EmpDTO empDTO = (EmpDTO) session.getAttribute("loginInfo");
 	  annDTO.setUpdater(empDTO.getEmp_no()); // updater 필드 설정
 	    
 	    return annService.empupdateann(annDTO, newphoto, newfile);
 	}
	
	
	
	
	
	

	
	
/*                        고객 공지사항                       */	
	
	@GetMapping(value="/annDetail.go")
	public ModelAndView annDetail(String ann_no) {
		logger.info("디테일 요청함");
		logger.info("넘버"+ann_no);
		return annService.annDetaildo(ann_no);
	}
	
	
	
	// 고객 공지사항 리스트 아작스    
    @RequestMapping(value="/ann/annList.ajax")
    @ResponseBody
    public Map<String, Object> annList(String page, String cnt, String ann_division, String ann_bHit, String ann_fixed, String register, String ann_date){
        logger.info("직원 공지사항 요청");
        logger.info("cnt :"+cnt);
        logger.info("직원 ="+ ann_division);
        logger.info("날짜 :"+ann_date);
        
        int currPage = Integer.parseInt(page);
        int pagePerCnt = Integer.parseInt(cnt);
        
        return annService.annlist(currPage, pagePerCnt, ann_division, ann_fixed, register);
    }
	
    
 // 고객 공지사항 글쓰기 페이지 가기.
 	@RequestMapping(value="/annwrite.go")
 	public String annwrite(HttpSession session, Model model) {
 		EmpDTO loginDTO = (EmpDTO)session.getAttribute("loginInfo");
 		model.addAttribute("name", loginDTO.getName());
 		
 		return"/ann/annWrite";
 	}
 	

 	
	
// 고객 공지사항 쓰기.
 	
 	@PostMapping("/annwrite.do")
 	public String annwrite(@RequestParam("photos") MultipartFile[] photos, 
 	                       @RequestParam("file") MultipartFile[] file, 
 	                       @RequestParam Map<String, String> param,
 	                       HttpSession session,
 	                       Model model) {
 	    logger.info("컨트롤러 도착");
 	    logger.info("param {}", param);
 	    logger.info("사진 :" + photos);
 	    logger.info("파일 :"+ file);

 	    EmpDTO empDTO = (EmpDTO) session.getAttribute("loginInfo");
 	    AnnDTO dto = new AnnDTO();
 	    dto.setAnn_subject(param.get("ann_subject"));
 	    dto.setAnn_content(param.get("textcontent"));
 	    dto.setAnn_division(param.get("ann_division"));
 	    dto.setAnn_fixed(param.get("ann_fixed"));
 	    dto.setRegister(empDTO.getEmp_no());

 	    int countann_fixed = annService.anncountann_fixed(param);

 	    // 상단고정된 공지사항이 5개 이상인 경우 등록을 막음
 	    if ("Y".equals(dto.getAnn_fixed()) && countann_fixed >= 5) {
 	        model.addAttribute("error", "최대 5개까지 등록이 가능합니다. 목록에서 지우고 다시 시도해주세요.");
 	        model.addAttribute("ann_subject", param.get("ann_subject"));
 	        model.addAttribute("textcontent", param.get("textcontent"));
 	        model.addAttribute("ann_division", param.get("ann_division"));
 	        model.addAttribute("ann_fixed", param.get("ann_fixed"));
 	        model.addAttribute("name", empDTO.getName()); // 작성자 이름 추가
 	        return "/ann/annWrite";  // 글쓰기 페이지로 다시 이동
 	    }
 	    annService.annwrite(photos, dto, file);
 	    return "redirect:/ann/annList.go";  // 성공 시 목록 페이지로 이동
 	}
 	
 	
 	
 	
 	
	
 	
 	//수정
 	@GetMapping("/annupdate.go")
 	public ModelAndView showUpdateForm(@RequestParam("ann_no") String ann_no) {
 	    AnnDTO ann = annService.getannById(ann_no);
 	    logger.info("업데이트 창 이동");
 	    String image = annService.photoname(ann_no); // 변수명을 image로 수정
 	    String file = annService.filename(ann_no);
 	    ModelAndView mav = new ModelAndView("/ann/annEdit");
 	    mav.addObject("dto", ann);
 	    mav.addObject("image", image); // JSP에서 사용할 변수명을 image로 설정
 	    mav.addObject("file", file);
 	    return mav;
 	}
	
 	@PostMapping("annupdate.do")
 	public String updateAnn(AnnDTO annDTO,
 	                        @RequestParam(value = "new_photo", required = false) MultipartFile[] newphoto,
 	                        @RequestParam(value = "new_file", required = false) MultipartFile[] newfile,
 	                        HttpSession session) {
 	    logger.info("업데이트 시도");
 	    EmpDTO empDTO = (EmpDTO) session.getAttribute("loginInfo");
 	    annDTO.setUpdater(empDTO.getEmp_no()); // updater 필드 설정

 	    return annService.updateAnn(annDTO, newphoto, newfile);
 	}
 	
	
	
 	@GetMapping("/ann/fixedCount.ajax")
 	@ResponseBody
 	public Map<String, Integer> anngetFixedCount() {
 		int fixedCount = annService.anngetFixedCount();
 		Map<String, Integer> response = new HashMap<>();
 		response.put("fixedCount", fixedCount);
 		return response;
 	}
 	
 	@PostMapping("/ann/unfixann.ajax")
 	@ResponseBody
 	public String annunfixAnnouncements(@RequestBody List<Integer> annNos) {
 		try {
 			annService.annunfixAnnouncements(annNos);
 			return "success";
 		} catch (Exception e) {
 			return "error";
 		}
 	}
	
 	
 	@PostMapping("/ann/deleteann.ajax")
 	@ResponseBody
 	public ResponseEntity<String> deleteann(@RequestBody List<Integer> annNos) {
 		logger.info("삭제 요청 공지 번호: " + annNos);
 		
 		int result = annService.deleteann(annNos);
 		if (result > 0) {
 			return new ResponseEntity<>("공지 삭제 성공", HttpStatus.OK);
 		} else {
 			return new ResponseEntity<>("공지 삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
 		}
 	}
 	
 	@RequestMapping(value = "/ann/annsearch.ajax")
 	@ResponseBody
 	public Map<String, Object> annnoticeSearch(@RequestParam("textval") String textval, @RequestParam("page") String page) {
 		Map<String, Object> map = new HashMap<>();
 		annService.annsearch(map, textval);
 		logger.info("서칭");
 		logger.info("텍스트: " + textval);
 		
 		return map;
 	}
	
}

