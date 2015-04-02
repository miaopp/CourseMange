package com.mpp.model;

import java.util.Date;

/**
 * Created by xiang.xu on 2015/3/30.
 */
public class Apply {
    private int id;
    private int courseId;
    private int labId;
    private Date applyTime;
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

    public int getLabId() {
        return labId;
    }

    public void setLabId(final int labId) {
        this.labId = labId;
    }

    public Date getApplyTime() {
        return applyTime;
    }

    public void setApplyTime(final Date applyTime) {
        this.applyTime = applyTime;
    }

    public String getLabTime() {
        return labTime;
    }

    public void setLabTime(final String labTime) {
        this.labTime = labTime;
    }
}
