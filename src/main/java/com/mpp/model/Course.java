package com.mpp.model;

/**
 * Created by xiang.xu on 2015/3/30.
 */
public class Course {
    private int id;
    private String name;
    private String courseDept;
    private String courseMajor;
    private int targetClass;
    private String courseBeginWeek;
    private String courseEndWeek;

    public int getId() {
        return id;
    }

    public void setId(final int id) {
        this.id = id;
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

    public String getCourseBeginWeek() {
        return courseBeginWeek;
    }

    public void setCourseBeginWeek(final String courseBeginWeek) {
        this.courseBeginWeek = courseBeginWeek;
    }

    public String getCourseEndWeek() {
        return courseEndWeek;
    }

    public void setCourseEndWeek(final String courseEndWeek) {
        this.courseEndWeek = courseEndWeek;
    }

    public String getCourseDept() {
        return courseDept;
    }

    public void setCourseDept(String courseDept) {
        this.courseDept = courseDept;
    }

    public String getCourseMajor() {
        return courseMajor;
    }

    public void setCourseMajor(String courseMajor) {
        this.courseMajor = courseMajor;
    }
}
