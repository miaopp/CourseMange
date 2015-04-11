package com.mpp.service;

import com.mpp.model.Lab;

import java.util.List;

/**
 * Created by pp on 2015/4/11.
 */
public interface LabService {
    public void addLab(Lab lab);
    public List<Lab> getLab();
}
