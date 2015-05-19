package com.mpp.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.annotation.Resource;

/**
 * Created by xiang.xu on 2015/4/20.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath:spring/applicationContext.xml" })
@WebAppConfiguration
public class CourseDaoTest {

    @Resource
    private CourseDao courseDao;

    @Test
    public void runGet() {
        System.out.println(courseDao.getCourse(1));
    }
}
