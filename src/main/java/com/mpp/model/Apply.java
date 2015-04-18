package com.mpp.model;

import com.google.common.base.Objects;

import java.util.Date;

/**
 * Created by xiang.xu on 2015/3/30.
 */
public class Apply {
    private int applyId;
    private int courseId;
    private int labId;
    private int userId;
    private int dayOfWeek;
    private int orders;
    private Date applyTime;

    public int getApplyId() {
        return applyId;
    }

    public void setApplyId(final int applyId) {
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

    public int getUserId() {
        return userId;
    }

    public void setUserId(final int userId) {
        this.userId = userId;
    }

    public int getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(final int dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    public int getOrders() {
        return orders;
    }

    public void setOrders(final int orders) {
        this.orders = orders;
    }

    @Override
    public String toString() {
        return Objects.toStringHelper(this)
                .add("applyId", applyId)
                .add("courseId", courseId)
                .add("labId", labId)
                .add("userId", userId)
                .add("dayOfWeek", dayOfWeek)
                .add("orders", orders)
                .add("applyTime", applyTime)
                .toString();
    }
}
