package com.mpp.model;

import com.google.common.base.Objects;

/**
 * Created by xiang.xu on 2015/3/30.
 */
public class Course {
    private int id;
    private int userId;
    private String name;
    private int courseDept;
    private String courseMajor;
    private int targetClass;
    private int courseBeginWeek;
    private int courseEndWeek;

    public int getId() {
        return id;
    }

    public void setId(final int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public int getTargetClass() {
        return targetClass;
    }

    public void setTargetClass(final int targetClass) {
        this.targetClass = targetClass;
    }

    public int getCourseBeginWeek() {
        return courseBeginWeek;
    }

    public void setCourseBeginWeek(final int courseBeginWeek) {
        this.courseBeginWeek = courseBeginWeek;
    }

    public int getCourseEndWeek() {
        return courseEndWeek;
    }

    public void setCourseEndWeek(final int courseEndWeek) {
        this.courseEndWeek = courseEndWeek;
    }

    public int getCourseDept() {
        return courseDept;
    }

    public void setCourseDept(final int courseDept) {
        this.courseDept = courseDept;
    }

    public String getCourseMajor() {
        return courseMajor;
    }

    public void setCourseMajor(String courseMajor) {
        this.courseMajor = courseMajor;
    }

    @Override
    public String toString() {
        return Objects.toStringHelper(this)
                .add("id", id)
                .add("userId", userId)
                .add("name", name)
                .add("courseDept", courseDept)
                .add("courseMajor", courseMajor)
                .add("targetClass", targetClass)
                .add("courseBeginWeek", courseBeginWeek)
                .add("courseEndWeek", courseEndWeek)
                .toString();
    }
}
