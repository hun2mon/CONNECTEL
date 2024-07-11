package com.connec.tel.scheduler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.connec.tel.service.ApprovalService;
import com.connec.tel.service.EmpService;


@Component
public class LeaveScheduler {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	private final EmpService empService;
	@Autowired ApprovalService appService;
	
	public LeaveScheduler (EmpService empService) {
		this.empService = empService;
	}
	
    @Scheduled(cron = "0 0 0 1 * *")  // 매월 10일 00:00에 실행
    public void test() {
        logger.info("매월 1일 휴가 할당 작업 시작");
        empService.empScheduleLeave();
        logger.info("매월 1일 휴가 할당 작업 완료");
    }
    
	@Scheduled(cron = "0 0 0 * * *")	// 매일 00시 정각
	public void test2() throws Exception {
		logger.info("매일 자정 기안서 마감 확인");
		appService.deadLineCheck();
	}

}
