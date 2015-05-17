package com.mpp.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.google.common.collect.Lists;
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

    @Override
    public List<CourseBean> getCourse() {
        List<Course>list = courseDao.getCourse();

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
