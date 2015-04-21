package com.mpp.service;

import com.mpp.model.Lab;

import java.util.List;

/**
 * Created by pp on 2015/4/11.
 */
public interface LabService {
    public void addLab(Lab lab);
    public List<Lab> getLab();
    public void deleteLab (Integer id);
    public List<Lab> getLabNameByDept(Integer labDept);
    public Lab getLabByLabId (Integer id);
}
