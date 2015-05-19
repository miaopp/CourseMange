package com.mpp.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.google.common.collect.Lists;
import com.mpp.dao.ApplyDao;
import com.mpp.dao.ScheduleDao;
import com.mpp.model.Apply;
import com.mpp.model.entity.ScheduleStatus;
import org.springframework.stereotype.Service;

import com.mpp.dao.CourseDao;
import com.mpp.model.Course;
import com.mpp.model.entity.CourseBean;
import com.mpp.service.CourseService;

/**
 * Created by pp on 2015/4/12.
 */
@Service
public class CourseServiceImpl implements CourseService {

    @Resource
    private CourseDao courseDao;

    @Resource
    private ApplyDao applyDao;

    @Resource
    private ScheduleDao scheduleDao;

    @Override
    public List<CourseBean> getCourse(final int userId) {
        List<Course>list = courseDao.getCourseByUserId(userId);

        List<CourseBean> rtn = Lists.newArrayList();
        for (Course course : list) {
            CourseBean courseBean = new CourseBean(course);
            rtn.add(courseBean);
        }

        return rtn;
    }

    @Override
    public void addCourse(final Course course) {
        courseDao.addCourse(course);
    }

    @Override
    public void deleteCourse(Integer id) {
        List<Apply> applyList = applyDao.getApplyByCourseIdAndState(id, 0);
        applyList.addAll(applyDao.getApplyByCourseIdAndState(id, 2));
        Course course = courseDao.getCourse(id);
        for (Apply apply : applyList) {
            ScheduleStatus scheduleStatus = new ScheduleStatus();
            scheduleStatus.setBeginWeek(course.getCourseBeginWeek());
            scheduleStatus.setEndWeek(course.getCourseEndWeek());
            scheduleStatus.setDayOfWeek(apply.getDayOfWeek());
            scheduleStatus.setOrders(apply.getOrders());
            scheduleStatus.setLabId(apply.getLabId());
            scheduleStatus.setStatus(0);
            scheduleStatus.setCourseId(0);
            scheduleDao.setScheduleState(scheduleStatus);
            applyDao.delApply(apply.getApplyId());
        }
        courseDao.deleteCourse(id);
    }

    @Override
    public List<Course> getCourseByMajorAndClass(final Course course) {
        return courseDao.getCourseByMajorAndClass(course);
    }

    @Override
    public List<Course> getCourseByTeacherId(final Integer userId) {
        return courseDao.getCourseByTeacherId(userId);
    }
}
