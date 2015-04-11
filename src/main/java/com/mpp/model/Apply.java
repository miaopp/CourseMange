package com.mpp.model;

import java.util.Date;

/**
 * Created by xiang.xu on 2015/3/30.
 */
public class Apply {
    private int applyId;
    private int courseId;
    private int labId;
    private int userId;
    private Date applyTime;

    public int getApplyId()
    {
        return applyId;
    }

    public void setApplyId(final int applyId)
    {
        this.applyId = applyId;
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


    public int getUserId()
    {
        return userId;
    }

    public void setUserId(final int userId)
    {
        this.userId = userId;
    }
}
