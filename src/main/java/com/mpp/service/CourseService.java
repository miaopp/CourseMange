package com.mpp.service;

import java.util.List;

import com.mpp.model.Course;
import com.mpp.model.entity.CourseBean;

/**
 * Created by pp on 2015/4/12.
 */
public interface CourseService {
    public List<CourseBean> getCourse();
    public void addCourse(Course course);
    public void deleteCourse(Integer id);
}
