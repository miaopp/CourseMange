package com.mpp.dao;

import com.google.common.collect.ImmutableList;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.annotation.Resource;

/**
 * Created by xiang.xu on 2015/5/20.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath:spring/applicationContext.xml" })
@WebAppConfiguration
public class NoticeDaoTest {

    @Resource
    private NoticeDao noticeDao;

    @Test
    public void run() {
        System.out.println(noticeDao.getNoticeByTargetUser(0, 1 ,2, ImmutableList.of(2, 3)));
    }
}
