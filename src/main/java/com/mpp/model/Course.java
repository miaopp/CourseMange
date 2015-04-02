package com.mpp.model;

/**
 * Created by xiang.xu on 2015/3/30.
 */
public class Course {
    private int id;
    private String name;
    private int targetClass;
    private String courseBegineWeek;
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

    public String getCourseBegineWeek() {
        return courseBegineWeek;
    }

    public void setCourseBegineWeek(final String courseBegineWeek) {
        this.courseBegineWeek = courseBegineWeek;
    }

    public String getCourseEndWeek() {
        return courseEndWeek;
    }

    public void setCourseEndWeek(final String courseEndWeek) {
        this.courseEndWeek = courseEndWeek;
    }
}
