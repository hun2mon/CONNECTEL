package com.connec.tel.controller;

import java.util.Collections;
import java.util.List;

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

import com.connec.tel.dto.MainDTO;
import com.connec.tel.service.MainService;

@Controller
public class MainController {
	
	@Autowired MainService mainService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value = "/")
	public String main(Model model) {	
		// 오늘 일정 출력
		List<MainDTO> today = mainService.getToday();
		model.addAttribute("events",today);

		
		
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
	
	
	@RequestMapping(value = "/{folder}/{jsp}" + ".go")
	public String move(@PathVariable String folder, @PathVariable String jsp) {
		return folder + "/" + jsp;
	}
	

}