package com.mpp.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.annotation.Resource;

/**
 * Created by xiang.xu on 2015/5/19.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath:spring/applicationContext.xml" })
@WebAppConfiguration
public class NoticeServiceTest {
    @Resource
    private NoticeService noticeService;

    @Test
    public void run() {
        System.out.println(noticeService.getNoticeByTargetUser(1));
    }
}
