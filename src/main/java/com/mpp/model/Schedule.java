package com.mpp.model;

import com.google.common.base.Objects;

/**
 * Created by xiang.xu on 2015/4/12.
 */
public class Schedule {
    private int id;
    private int labId;
    private int courseId;
    private int state;
    private int week;
    private int dayOfWeek;
    private int orders;

    public Schedule() {
    }

    public Schedule(final int state, final int week, final int dayOfWeek, final int orders) {
        this.state = state;
        this.week = week;
        this.dayOfWeek = dayOfWeek;
        this.orders = orders;
    }

    public int getId() {
        return id;
    }

    public void setId(final int id) {
        this.id = id;
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

    public int getState() {
        return state;
    }

    public void setState(final int state) {
        this.state = state;
    }

    public int getWeek() {
        return week;
    }

    public void setWeek(final int week) {
        this.week = week;
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
                .add("id", id)
                .add("labId", labId)
                .add("courseId", courseId)
                .add("state", state)
                .add("week", week)
                .add("dayOfWeek", dayOfWeek)
                .add("orders", orders)
                .toString();
    }
}
