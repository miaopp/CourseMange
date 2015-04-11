package com.mpp.model;

/**
 * Created by xiang.xu on 2015/3/30.
 */
public class Lab {
    private int id;
    private int courseId;
    private int userId;
    private String labBeginTime;
    private String labEndTime;

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

    public String getLabBeginTime()
    {
        return labBeginTime;
    }

    public void setLabBeginTime(final String labBeginTime)
    {
        this.labBeginTime = labBeginTime;
    }

    public String getLabEndTime()
    {
        return labEndTime;
    }

    public void setLabEndTime(final String labEndTime)
    {
        this.labEndTime = labEndTime;
    }
}
