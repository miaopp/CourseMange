package com.mpp.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.google.common.collect.Maps;
import com.mpp.dao.ApplyDao;
import com.mpp.dao.CourseDao;
import com.mpp.dao.LabDao;
import com.mpp.dao.NoticeDao;
import com.mpp.dao.ScheduleDao;
import com.mpp.dao.UserDao;
import com.mpp.model.Apply;
import com.mpp.model.Course;
import com.mpp.model.Lab;
import com.mpp.model.Notice;
import com.mpp.model.User;
import com.mpp.model.entity.CourseDisplayBean;
import com.mpp.model.entity.ScheduleStatus;
import com.mpp.service.ApplyService;

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
    public Map<String, Object> getCourseDisplayByLabId(final Integer labId) {
        HashMap<String, Object> rtn = Maps.newHashMap();
        Lab lab = labDao.getLabByLabId(labId);
        rtn.put("labName", lab.getLabName());

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
            cour.setState(app.getState());
            dis.add(cour);
        }
        rtn.put("list", dis);
        return rtn;
    }
}
