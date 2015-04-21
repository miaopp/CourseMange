package com.mpp.service.impl;

import com.google.common.collect.Lists;
import com.mpp.dao.LabDao;
import com.mpp.dao.ScheduleDao;
import com.mpp.dao.UserDao;
import com.mpp.model.Lab;
import com.mpp.model.Schedule;
import com.mpp.service.LabService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by pp on 2015/4/11.
 */
@Service
public class LabServiceImpl implements LabService{

    @Resource
    private LabDao labDao;

    @Resource
    private ScheduleDao scheduleDao;

    @Override
    public void addLab(final Lab lab) {
        labDao.addLab(lab);
        List<Schedule> scheduleList = Lists.newArrayList();
        for (int i = 1; i <= 25; i++) {
            for (int j = 1; j <= 7; j++) {
                for (int k = 1; k <= 12; k++) {
                    Schedule schedule = new Schedule(0, i, j, k);
                    schedule.setLabId(lab.getId());
                    scheduleList.add(schedule);
                }
            }
        }
        scheduleDao.saveScheduleList(scheduleList);
    }
    public List<Lab> getLab() {
        return labDao.getLab();
    }
    public void deleteLab(final Integer id) {
        labDao.deleteLab(id);
    }

    @Override
    public List<Lab> getLabNameByDept(final Integer labDept) {
        return labDao.getLabByDept(labDept);
    }

    @Override
    public Lab getLabByLabId (final Integer id) {
        return labDao.getLabByLabId(id);
    }
}
