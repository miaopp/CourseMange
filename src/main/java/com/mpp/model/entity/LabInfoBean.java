package com.mpp.model.entity;

/**
 * Created by pp on 2015/5/12.
 */
public class LabInfoBean {
    int id;
    String labName;
    String labDept;
    String labAddress;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLabName() {
        return labName;
    }

    public void setLabName(String labName) {
        this.labName = labName;
    }

    public String getLabDept() {
        return labDept;
    }

    public void setLabDept(String labDept) {
        this.labDept = labDept;
    }

    public String getLabAddress() {
        return labAddress;
    }

    public void setLabAddress(String labAddress) {
        this.labAddress = labAddress;
    }
}
