package com.mpp.model.entity;

import java.util.Date;

/**
 * Created by pp on 2015/4/21.
 */
public class NoticeBean {
    private String userRealName;
    private String courseName;
    private String labName;
    private int userId;
    private int labId;
    private int courseId;
    private int applyId;
    private int noticeId;
    private int state;
    private String applyTime;

    public String getUserRealName() {
        return userRealName;
    }

    public void setUserRealName(String userRealName) {
        this.userRealName = userRealName;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getLabName() {
        return labName;
    }

    public void setLabName(String labName) {
        this.labName = labName;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getLabId() {
        return labId;
    }

    public void setLabId(int labId) {
        this.labId = labId;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public int getApplyId() {
        return applyId;
    }

    public void setApplyId(int applyId) {
        this.applyId = applyId;
    }

    public int getNoticeId() {
        return noticeId;
    }

    public void setNoticeId(int noticeId) {
        this.noticeId = noticeId;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getApplyTime() {
        return applyTime;
    }

    public void setApplyTime(final String applyTime) {
        this.applyTime = applyTime;
    }

    @Override
    public String toString() {
        return "NoticeBean{" +
                "userRealName='" + userRealName + '\'' +
                ", courseName='" + courseName + '\'' +
                ", labName='" + labName + '\'' +
                ", userId=" + userId +
                ", labId=" + labId +
                ", courseId=" + courseId +
                ", applyId=" + applyId +
                ", noticeId=" + noticeId +
                ", state=" + state +
                ", applyTime=" + applyTime +
                '}';
    }
}
