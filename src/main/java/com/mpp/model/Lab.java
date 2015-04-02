package com.mpp.model;

/**
 * Created by xiang.xu on 2015/3/30.
 */
public class Lab {
    private int id;
    private int courseId;
    private int userId;
    private String labTime;

    public int getId() {
        return id;
    }

    public void setId(final int id) {
        this.id = id;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(final int courseId) {
        this.courseId = courseId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(final int userId) {
        this.userId = userId;
    }

    public String getLabTime() {
        return labTime;
    }

    public void setLabTime(final String labTime) {
        this.labTime = labTime;
    }
}
