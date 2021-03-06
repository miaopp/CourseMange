package com.mpp.dao;

import com.mpp.model.Lab;

import java.util.List;

/**
 * Created by pp on 2015/4/11.
 */
public interface LabDao {
    public List<Lab> getLab();

    public List<Lab> getLabByDept(Integer labDept);

    public void addLab(Lab lab);

    public void deleteLab (Integer id);

    public Lab getLabByLabId (Integer id);

    public void labMessageModify(Lab lab);

}
