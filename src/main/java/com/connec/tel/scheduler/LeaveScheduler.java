package com.connec.tel.scheduler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.connec.tel.service.EmpService;


@Component
public class LeaveScheduler {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	private final EmpService empService;
	
	public LeaveScheduler (EmpService empService) {
		this.empService = empService;
	}
	
    @Scheduled(cron = "0 0 0 10 * ?")  // 매월 10일 00:00에 실행
    public void test() {
        logger.info("매월 10일 휴가 할당 작업 시작");
        empService.empScheduleLeave();
        logger.info("매월 10일 휴가 할당 작업 완료");
    }

}
