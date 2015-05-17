package com.mpp.model.entity;

/**
 * Created by xiang.xu on 2015/5/17.
 */
public class ApplyChangeStateBeans {
    private int applyId;
    private int state;
    private String msg;

    public int getApplyId() {
        return applyId;
    }

    public void setApplyId(final int applyId) {
        this.applyId = applyId;
    }

    public int getState() {
        return state;
    }

    public void setState(final int state) {
        this.state = state;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(final String msg) {
        this.msg = msg;
    }
}
