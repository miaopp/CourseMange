package com.mpp.dao;

import com.mpp.model.Schedule;

import java.util.List;

/**
 * Created by xiang.xu on 2015/4/12.
 */
public interface ScheduleDao {
    public void saveScheduleList(List<Schedule> scheduleList);
}
