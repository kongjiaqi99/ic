package com.ic.icadmin.config.scheduled;

import com.ic.icadmin.service.IEventsService;
import com.ic.icadmin.service.IPurchasedFundsService;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

@EnableScheduling//开启定时任务
@Component
public class SpringTask {

    @Resource
    IEventsService eventsService;
    @Resource
    IPurchasedFundsService purchasedFundsService;

    @Scheduled(cron="0 5 0 * * ?")
    public void editEventStatus(){
        eventsService.editStatus();
    }

    @Scheduled(cron="0 0 10 1-5 * ? ")
    public void pushInvestmentMsg(){
        purchasedFundsService.pushInvestmentMsg();
    }

}
