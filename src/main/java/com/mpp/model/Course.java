package com.mpp.model;

/**
 * Created by xiang.xu on 2015/3/30.
 */
public class Course {
    private int id;
    private String name;
    private int targetClass;
    private int courseBegineWeek;
    private int courseEndWeek;

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

    public int getCourseBegineWeek() { return courseBegineWeek; }

    public void setCourseBegineWeek(final int courseBegineWeek) { this.courseBegineWeek = courseBegineWeek; }

    public int getCourseEndWeek() { return courseEndWeek; }

    public void setCourseEndWeek(final int courseEndWeek) { this.courseEndWeek = courseEndWeek; }
}
