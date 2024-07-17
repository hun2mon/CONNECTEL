package com.connec.tel.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.connec.tel.dto.EmpDTO;
import com.connec.tel.dto.MainDTO;
import com.connec.tel.service.MainService;

@Controller
public class MainController {
	
	@Autowired MainService mainService;
	Logger logger = LoggerFactory.getLogger(getClass());
	

    private final NoticeController noticeController;

	
    @Autowired
    public MainController(NoticeController noticeController) {
        this.noticeController = noticeController;
    }
	
	

	// 메인 페이지 이동
	@RequestMapping(value = "/main")
	public String mainss(Model model, HttpSession session) throws IOException {
		EmpDTO empDTO = (EmpDTO) session.getAttribute("loginInfo");
		
		mainService.totalReserve(model);
	    String url = "https://www.sukbakmagazine.com/news/articleList.html?sc_sub_section_code=S2N10&view_type=sm"; // 페이지 번호를 쿼리 파라미터로 추가
	    Document doc = Jsoup.connect(url).get();
	    mainService.scrapeContent(doc, model);
	    
	    mainService.totalApproval(empDTO.getEmp_no(),model);
	    
	    return "main/main";
	}
	
	@GetMapping(value = "/reservation/count")
	@ResponseBody
	public List<MainDTO> reservess(Model model){
		mainService.totalReserve(model);
		List<MainDTO> event = mainService.nowaReserve();
		
		
		return event;
	}
	
	
    @GetMapping("/filterEventsByCategory")
    @ResponseBody
    public List<MainDTO> filterEventsByCategory(@RequestParam("category") String category, @RequestParam("emp_no") String emp_no) {
        logger.info("필터링 ㄱㄱ");
        logger.info(category + "ㅇㅇㅇㅇ");
        String content = "테스트야야야~~";
        switch (category) {
            case "금주":
                return mainService.getThisWeek(emp_no); // 금주 일정
            case "오늘":
                return mainService.getToday(emp_no); // 오늘 일정
            case "내일":
                return mainService.getTomorrow(emp_no); // 내일 일정
            default:
                return Collections.emptyList();
        }
    }

	
	
	// 페이지 이동
	@RequestMapping(value = "/{folder}/{jsp}" + ".go")
	public String move(@PathVariable String folder, @PathVariable String jsp, HttpSession session, Model model) {
		EmpDTO loginDTO = (EmpDTO) session.getAttribute("loginInfo");
		
		if (jsp.equals("appChart") || jsp.equals("draftWrite")) {
			model.addAttribute("emp_no", loginDTO.getEmp_no());
			model.addAttribute("name", loginDTO.getName());
			model.addAttribute("dept_name", loginDTO.getDept_name());
			model.addAttribute("rank_name", loginDTO.getRank_name());
		}
		
		
		return folder + "/" + jsp;
	}
	

}