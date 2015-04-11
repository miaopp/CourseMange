package com.mpp.model;

/**
 * Created by xiang.xu on 2015/3/30.
 */
public class Lab {
    private int id;
    private String lab_name;
    private String lab_address;
    private String lab_dept;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLab_name() {
        return lab_name;
    }

    public void setLab_name(String lab_name) {
        this.lab_name = lab_name;
    }

    public String getLab_address() {
        return lab_address;
    }

    public void setLab_address(String lab_address) {
        this.lab_address = lab_address;
    }

    public String getLab_dept() {
        return lab_dept;
    }

    public void setLab_dept(String lab_dept) {
        this.lab_dept = lab_dept;
    }

    @Override
    public String toString() {
        return "Lab{" +
                "id=" + id +
                ", lab_name='" + lab_name + '\'' +
                ", lab_address='" + lab_address + '\'' +
                ", lab_dept='" + lab_dept + '\'' +
                '}';
    }
}
