package com.mpp.service.impl;

import javax.annotation.Resource;

import com.mpp.dao.*;
import com.mpp.model.*;
import com.mpp.model.entity.CourseDisplayBean;
import com.mpp.model.entity.ScheduleStatus;
import org.springframework.stereotype.Service;

import com.mpp.model.entity.OrderFilter;
import com.mpp.service.ApplyService;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xiang.xu on 2015/4/20.
 */
@Service
public class ApplyServiceImpl implements ApplyService{

    @Resource
    private ApplyDao applyDao;

    @Resource
    private CourseDao courseDao;

    @Resource
    private ScheduleDao scheduleDao;

    @Resource
    private NoticeDao noticeDao;

    @Resource
    private UserDao userDao;

    @Resource
    private LabDao labDao;

    @Override
    public void addApply(final Apply apply) {
        applyDao.addApply(apply);

        //获取需要处理的schedule表的区间
        Course course = courseDao.getCourse(apply.getCourseId());
        int len = course.getCourseEndWeek() - course.getCourseBeginWeek() + 1;
        ScheduleStatus scheduleStatus = new ScheduleStatus(apply.getLabId(), apply.getCourseId(), apply.getDayOfWeek(), course.getCourseBeginWeek(), course.getCourseEndWeek(), len, 1, apply.getOrders());
        scheduleDao.setScheduleState(scheduleStatus);

        //得到manager
        User u = userDao.getUserByUserId(apply.getUserId());
        User u1 = new User();
        u1.setDept(u.getDept());
        u1.setPower(2);
        List<User> managerList = userDao.getManageByDept(u1);
        for (User user : managerList) {
            Notice notice = new Notice();
            notice.setApplyId(apply.getApplyId());
            notice.setCourseId(apply.getCourseId());
            notice.setLabId(apply.getLabId());
            notice.setUserId(apply.getUserId());
            notice.setTargetUser(user.getUserId());
            notice.setState(1);
            noticeDao.addNotice(notice);
        }

    }

    @Override
    public List<Apply> getAllApply(final Integer uid) {
        return applyDao.getAllApply(uid);
    }

    @Override
    public List<CourseDisplayBean> getCourseDisplayByLabId(final Integer labId) {
        List<Apply> apply = applyDao.getApplyByLabId(labId);
        List<CourseDisplayBean> dis = new ArrayList<CourseDisplayBean>();
        for (Apply app : apply) {
            CourseDisplayBean cour = new CourseDisplayBean();
            User u = userDao.getUserByUserId(app.getUserId());
            cour.setUserId(u.getUserId());
            cour.setCourseName(u.getRealName());
            Course c = courseDao.getCourse(app.getCourseId());
            cour.setCourseId(c.getId());
            cour.setCourseName(c.getName());
            cour.setBeginWeek(c.getCourseBeginWeek());
            cour.setEndWeek(c.getCourseEndWeek());
            Lab l = labDao.getLabByLabId(labId);
            cour.setLabName(l.getLabName());
            cour.setState(app.getState());
            dis.add(cour);
        }
        return dis;
    }
}
