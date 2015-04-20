package com.mpp.model.entity;

import com.google.common.base.Objects;

/**
 * Created by xiang.xu on 2015/4/20.
 */
public class ScheduleStatus {
    private int labId;
    private int courseId;
    private int dayOfWeek;
    private int beginWeek;
    private int endWeek;
    private int length;
    private int status;
    private int orders;

    public ScheduleStatus() {
    }

    public ScheduleStatus(final int labId, final int courseId, final int dayOfWeek, final int beginWeek, final int endWeek, final int length, final int status, final int orders) {
        this.labId = labId;
        this.courseId = courseId;
        this.dayOfWeek = dayOfWeek;
        this.beginWeek = beginWeek;
        this.endWeek = endWeek;
        this.length = length;
        this.status = status;
        this.orders = orders;
    }

    public int getLabId() {
        return labId;
    }

    public void setLabId(final int labId) {
        this.labId = labId;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(final int courseId) {
        this.courseId = courseId;
    }

    public int getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(final int dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    public int getBeginWeek() {
        return beginWeek;
    }

    public void setBeginWeek(final int beginWeek) {
        this.beginWeek = beginWeek;
    }

    public int getEndWeek() {
        return endWeek;
    }

    public void setEndWeek(final int endWeek) {
        this.endWeek = endWeek;
    }

    public int getLength() {
        return length;
    }

    public void setLength(final int length) {
        this.length = length;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(final int status) {
        this.status = status;
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
                .add("labId", labId)
                .add("courseId", courseId)
                .add("dayOfWeek", dayOfWeek)
                .add("beginWeek", beginWeek)
                .add("endWeek", endWeek)
                .add("length", length)
                .add("status", status)
                .add("orders", orders)
                .toString();
    }
}
