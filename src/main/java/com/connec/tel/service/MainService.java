package com.connec.tel.service;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.connec.tel.dao.MainDAO;
import com.connec.tel.dto.MainDTO;

@Service
public class MainService {
   
    @Autowired MainDAO mainDAO;
    Logger logger = LoggerFactory.getLogger(getClass());
    

    
    public List<MainDTO> getAllSchedules() {
        return mainDAO.getAllSchedules();
    }

    public List<MainDTO> getThisWeek() {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime startOfWeek = now.with(java.time.DayOfWeek.MONDAY);
        LocalDateTime endOfWeek = startOfWeek.plusDays(6);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd-HH-mm");
        return mainDAO.getThisWeek(startOfWeek.format(formatter), endOfWeek.format(formatter));
    }

    public List<MainDTO> getToday() {
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return mainDAO.getToday(today.format(formatter));
    }

    public List<MainDTO> getTomorrow() {
        LocalDate tomorrow = LocalDate.now().plusDays(1);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return mainDAO.getTomorrow(tomorrow.format(formatter));
    }


    public void scrapeContent(Document doc, Model model) {
        // 요소를 가져오는 방식은 js 방식과 css 셀렉터 방식이 있다.
        // 예) doc.getElementById("test")
        // 예) doc.select("#test")
        
        Elements elems = doc.select("ul.type2");
        logger.info("size : " + elems.size());
        
        if (!elems.isEmpty()) {
            Element elem = elems.get(0);
            Elements cardList = elem.select("div.view-cont");
            
            List<Map<String, String>> list = new ArrayList<>();
            
            for (Element card : cardList) {
                String title = card.select("h2 a").html();
                String link = card.select("h2 a").attr("href"); // 링크 가져오는 방식 수정
                String desc = card.select("p a").html();
                String date = card.select("span em:nth-last-child(1)").html();

                logger.info("title : {}", title);
                logger.info("link : {}", link);
                logger.info("desc : {}", desc);

                
                Map<String, String> article = new HashMap<>();
                article.put("title", title);
                article.put("link", "https://www.sukbakmagazine.com/" + link); // 링크 URL 수정
    			article.put("desc", desc.substring(0, 50) + "…");
    			article.put("date", date);
                list.add(article);
            }
            
            model.addAttribute("scrapedContent", list);
        } else {
            logger.warn("No elements found for div.node-list");
        }
    }
	}
