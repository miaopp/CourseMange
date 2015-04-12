package com.mpp.service.impl;

import com.mpp.dao.CourseDao;
import com.mpp.model.Course;
import com.mpp.service.CourseService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by pp on 2015/4/12.
 */
@Service
public class CourseServiceImpl implements CourseService {

    @Resource
    private CourseDao courseDao;

    @Override
    public List<Course> getCourse() {
        return courseDao.getCourse();
    }

    @Override
    public void addCourse(final Course course) {
        courseDao.addCourse(course);
    }

    @Override
    public void deleteCourse(Integer id) {
        courseDao.deleteCourse(id);
    }
}
