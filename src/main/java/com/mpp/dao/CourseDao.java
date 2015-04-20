package com.mpp.dao;

import com.mpp.model.Course;

import java.util.List;

/**
 * Created by pp on 2015/4/12.
 */
public interface CourseDao {
    public List<Course> getCourse();
    public void addCourse(Course course);
    public void deleteCourse(Integer id);
    public Course getCourse(Integer id);
}
