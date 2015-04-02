package com.mpp.model;

/**
 * Created by xiang.xu on 2015/3/30.
 */
public class Course {
    private int id;
    private String name;
    private int targetClass;
    private String courseTime;

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

    public String getCourseTime() {
        return courseTime;
    }

    public void setCourseTime(final String courseTime) {
        this.courseTime = courseTime;
    }
}
