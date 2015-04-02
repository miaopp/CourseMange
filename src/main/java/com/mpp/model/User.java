package com.mpp.model;

import com.google.common.base.Objects;

/**
 * Created by xiang.xu on 2015/3/30.
 */
public class User {
    private int userId;
    private String username;
    private String password;
    private String userNo;
    private int classes;
    private String dept;
    private int power;

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

    public String getUserNo() {
        return userNo;
    }

    public void setUserNo(final String userNo) {
        this.userNo = userNo;
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

    @Override
    public String toString() {
        return Objects.toStringHelper(this)
                .add("userId", userId)
                .add("username", username)
                .add("password", password)
                .add("userNo", userNo)
                .add("classes", classes)
                .add("dept", dept)
                .add("power", power)
                .toString();
    }
}
