package com.mpp.model.entity;

import java.util.Comparator;

/**
 * Created by pp on 2015/5/12.
 */
public class LabInfoBean implements Comparable<LabInfoBean>{
    private int id;
    private String labName;
    private String labDept;
    private String labAddress;

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

    @Override
    public int compareTo(final LabInfoBean o) {
        return Integer.compare(id, o.id);
    }
}
