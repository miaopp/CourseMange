package com.mpp.dao;

import com.mpp.model.Lab;

import java.util.List;

/**
 * Created by pp on 2015/4/11.
 */
public interface LabDao {
    public List<Lab> getLab();

    public void addLab(Lab lab);

    public void deleteLab (Integer id);
}
