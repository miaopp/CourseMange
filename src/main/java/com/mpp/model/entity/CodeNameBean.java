package com.mpp.model.entity;

import com.google.common.base.Objects;

/**
 * Created by xiang.xu on 2015/4/18.
 */
public class CodeNameBean {
    private int code;
    private String name;

    public CodeNameBean() {
    }

    public CodeNameBean(final int code, final String name) {
        this.code = code;
        this.name = name;
    }

    public int getCode() {
        return code;
    }

    public void setCode(final int code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return Objects.toStringHelper(this)
                .add("code", code)
                .add("name", name)
                .toString();
    }
}
