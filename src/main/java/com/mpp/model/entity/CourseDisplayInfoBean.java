package com.mpp.model.entity;

/**
 * Created by pp on 2015/5/13.
 */
public class CourseDisplayInfoBean {
    private String courseName;
    private String teacherName;
    private String labName;
    private int beginWeek;
    private int endWeek;
    private int dayOfWeek;
    private int orders;
    private int userId;
    private int courseId;
    private int labId;

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

    public String getLabName() {
        return labName;
    }

    public void setLabName(String labName) {
        this.labName = labName;
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

    public int getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(int dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    public int getOrders() {
        return orders;
    }

    public void setOrders(int orders) {
        this.orders = orders;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public int getLabId() {
        return labId;
    }

    public void setLabId(int labId) {
        this.labId = labId;
    }

    @Override
    public String toString() {
        return "CourseDisplayInfoBean{" +
                "courseName='" + courseName + '\'' +
                ", teacherName='" + teacherName + '\'' +
                ", labName='" + labName + '\'' +
                ", beginWeek=" + beginWeek +
                ", endWeek=" + endWeek +
                ", dayOfWeek=" + dayOfWeek +
                ", orders=" + orders +
                ", userId=" + userId +
                ", courseId=" + courseId +
                ", labId=" + labId +
                '}';
    }

    public String toInfoString() {
        StringBuilder builder = new StringBuilder();
        builder.append(courseName + "<br>");
        builder.append("任课老师：" + teacherName + "<br>");
        builder.append("第").append(beginWeek).append("周 - ").append("第").append(endWeek).append("周<br>");
        builder.append("上课地点：" + labName + "<br>");
        return builder.toString();
    }
}
