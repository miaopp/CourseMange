package com.mpp.model;

import com.google.common.base.Objects;

/**
 * Created by xiang.xu on 2015/3/30.
 */
public class Lab {
    private int id;
    private String labName;
    private String labAddress;
    private int labDept;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLabName() {
        return labName;
    }

    public void setLabName(final String labName) {
        this.labName = labName;
    }

    public String getLabAddress() {
        return labAddress;
    }

    public void setLabAddress(final String labAddress) {
        this.labAddress = labAddress;
    }

    public int getLabDept() {
        return labDept;
    }

    public void setLabDept(final int labDept) {
        this.labDept = labDept;
    }

    @Override
    public String toString() {
        return Objects.toStringHelper(this)
                .add("id", id)
                .add("labName", labName)
                .add("labAddress", labAddress)
                .add("labDept", labDept)
                .toString();
    }
}
