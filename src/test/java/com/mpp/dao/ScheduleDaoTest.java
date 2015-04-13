package com.mpp.dao;

import com.google.common.collect.Lists;
import com.mpp.model.Schedule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by xiang.xu on 2015/4/13.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath:spring/applicationContext.xml" })
@WebAppConfiguration
public class ScheduleDaoTest {

    @Resource
    private ScheduleDao scheduleDao;

    @Test
    public void run() {
        List<Schedule> list = Lists.newArrayList();
        Schedule schedule = new Schedule(0, 1, 1, 1);
        schedule.setLabId(1);
        list.add(schedule);
        schedule = new Schedule(0, 1, 2, 1);
        schedule.setLabId(1);
        list.add(schedule);
        scheduleDao.saveScheduleList(list);
    }
}
