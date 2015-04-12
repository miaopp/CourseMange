package com.mpp.service;

import com.mpp.model.Course;

import java.util.List;

/**
 * Created by pp on 2015/4/12.
 */
public interface CourseService {
    public List<Course> getCourse();
    public void addCourse(Course course);
    public void deleteCourse(Integer id);
}
