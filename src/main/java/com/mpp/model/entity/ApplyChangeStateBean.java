package com.mpp.model.entity;

import com.google.common.base.Objects;

/**
 * Created by xiang.xu on 2015/5/17.
 */
public class ApplyChangeStateBean {
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

    @Override
    public String toString() {
        return Objects.toStringHelper(this)
                .add("applyId", applyId)
                .add("state", state)
                .add("msg", msg)
                .toString();
    }
}
