package com.mpp.model;

import com.google.common.base.Objects;

/**
 * Created by xiang.xu on 2015/3/30.
 */
public class User {
    private int userId;
    private String username;
    private String password;
    private String realName;
    private int classes;
    private String dept;
    private int power;
    private String course;

    public int getUserId() { return userId; }

    public void setUserId(final int userId) { this.userId = userId; }

    public String getUsername() {
        return username;
    }

    public void setUsername(final String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(final String password) {
        this.password = password;
    }

    public int getClasses() {
        return classes;
    }

    public void setClasses(final int classes) {
        this.classes = classes;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(final String dept) {
        this.dept = dept;
    }

    public int getPower() {
        return power;
    }

    public void setPower(final int power) {
        this.power = power;
    }

    public String getCourse() { return course; }

    public void setCourse(final String course) { this.course = course; }

    public String getRealName() { return realName; }

    public void setRealName(final String realName) { this.realName = realName; }

    @Override
    public String toString() {
        return Objects.toStringHelper(this)
                .add("userId", userId)
                .add("username", username)
                .add("password", password)
                .add("realName",realName)
                .add("classes", classes)
                .add("dept", dept)
                .add("power", power)
                .add("course",course)
                .toString();
    }
}
