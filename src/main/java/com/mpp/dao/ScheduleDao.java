package com.mpp.dao;

import com.mpp.model.Schedule;
import com.mpp.model.entity.OrderFilter;
import com.mpp.model.entity.ScheduleStatus;

import java.util.List;

/**
 * Created by xiang.xu on 2015/4/12.
 */
public interface ScheduleDao {
    public void saveScheduleList(List<Schedule> scheduleList);

    public List<Integer> getOrders(OrderFilter filter);

    public void setScheduleState(ScheduleStatus scheduleStatus);
}
