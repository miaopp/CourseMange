package com.mpp.model.entity;

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
                '}';
    }

    public String toNoticeOfTeacherString() {
        StringBuilder builder = new StringBuilder();
        if(state == 2) {
            builder.append("管理员").append(userRealName).append("同意您就课程").append(courseName).append("对实验室").append(labName).append("提出的申请。");
        }
        else if(state == 3) {
            builder.append("很抱歉，当前您就课程").append(userRealName).append("对实验室").append(labName).append("提出的申请失败，请重新申请");
        }
        return builder.toString();
    }
}
