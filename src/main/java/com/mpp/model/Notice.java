package com.mpp.model;

/**
 * Created by pp on 2015/4/19.
 */
public class Notice {
    private int noticeId;
    private int applyId;
    private int courseId;
    private int labId;
    private int userId;
    private int targetUser;
    private int state;
    private String message;

    public Notice() {
        this.message = "";
    }

    public int getNoticeId() {
        return noticeId;
    }

    public void setNoticeId(int noticeId) {
        this.noticeId = noticeId;
    }

    public int getApplyId() {
        return applyId;
    }

    public void setApplyId(int applyId) {
        this.applyId = applyId;
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

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getTargetUser() {
        return targetUser;
    }

    public void setTargetUser(int targetUser) {
        this.targetUser = targetUser;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(final String message) {
        this.message = message;
    }
}
