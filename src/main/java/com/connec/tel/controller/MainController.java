package com.connec.tel.controller;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

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
	

	// 메인 페이지 이동
	@RequestMapping(value = "/main")
	public String main() {
		logger.info("main 요청");
		
		return "main/main";
	}
	
	
    @GetMapping("/filterEventsByCategory")
    @ResponseBody
    public List<MainDTO> filterEventsByCategory(@RequestParam("category") String category) {
        logger.info("필터링 ㄱㄱ");
        logger.info(category + "ㅇㅇㅇㅇ");

        switch (category) {
            case "금주":
                return mainService.getThisWeek(); // 금주 일정
            case "오늘":
                return mainService.getToday(); // 오늘 일정
            case "내일":
                return mainService.getTomorrow(); // 내일 일정
            default:
                return Collections.emptyList();
        }
    }
	
	
	// 페이지 이동
	@RequestMapping(value = "/{folder}/{jsp}" + ".go")
	public String move(@PathVariable String folder, @PathVariable String jsp, HttpSession session, Model model) {
		EmpDTO loginDTO = (EmpDTO) session.getAttribute("loginInfo");
		
		if (jsp.equals("appChart")) {
			model.addAttribute("emp_no", loginDTO.getEmp_no());
			model.addAttribute("name", loginDTO.getName());
			model.addAttribute("dept_name", loginDTO.getDept_name());
			model.addAttribute("rank_name", loginDTO.getRank_name());
		}
		
		return folder + "/" + jsp;
	}
	

}