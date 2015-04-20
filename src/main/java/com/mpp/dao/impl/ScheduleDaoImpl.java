package com.mpp.dao.impl;

import com.mpp.dao.ScheduleDao;
import com.mpp.model.Schedule;
import com.mpp.model.entity.OrderFilter;
import com.mpp.model.entity.ScheduleStatus;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by xiang.xu on 2015/4/12.
 */
@Repository
public class ScheduleDaoImpl implements ScheduleDao {

    @Resource
    private SqlSession sqlSession;

    @Override
    public void saveScheduleList(final List<Schedule> scheduleList) {
        this.sqlSession.insert("Schedule.saveScheduleList", scheduleList);
    }

    @Override
    public List<Integer> getOrders(final OrderFilter filter) {
        return this.sqlSession.selectList("Schedule.selectOrders", filter);
    }

    @Override
    public void setScheduleState(final ScheduleStatus scheduleStatus) {
        this.sqlSession.update("Schedule.updateScheduleState", scheduleStatus);
    }
}
