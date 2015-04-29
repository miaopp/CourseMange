package com.mpp.model.entity;

import com.google.common.base.Objects;

/**
 * Created by pp on 2015/4/28.
 */
public class ApplyInfoBean {
    private String courseName;
    private String teacherName;
    private int beginWeek;
    private int endWeek;
    private int state;
    private int courseId;
    private int userId;
    private int dayOfWeek;
    private int orders;

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public int getBeginWeek() {
        return beginWeek;
    }

    public void setBeginWeek(int beginWeek) {
        this.beginWeek = beginWeek;
    }

    public int getEndWeek() {
        return endWeek;
    }

    public void setEndWeek(int endWeek) {
        this.endWeek = endWeek;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
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
                .add("courseName", courseName)
                .add("teacherName", teacherName)
                .add("beginWeek", beginWeek)
                .add("endWeek", endWeek)
                .add("state", state)
                .add("courseId", courseId)
                .add("userId", userId)
                .add("dayOfWeek", dayOfWeek)
                .add("orders", orders)
                .toString();
    }

    public String toInfoString() {
        StringBuilder builder = new StringBuilder();
        builder.append(courseName + "<br>");
        builder.append(teacherName + "<br>");
        builder.append("第").append(beginWeek).append("周 - ").append("第").append(endWeek).append("周<br>");
        builder.append("任课老师：" + teacherName + "<br>");
        return builder.toString();
    }
}
