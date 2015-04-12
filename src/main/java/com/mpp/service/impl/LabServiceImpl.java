package com.mpp.service.impl;

import com.mpp.dao.LabDao;
import com.mpp.dao.UserDao;
import com.mpp.model.Lab;
import com.mpp.service.LabService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by pp on 2015/4/11.
 */
@Service
public class LabServiceImpl implements LabService{


    @Resource
    private LabDao labDao;

    @Override
    public void addLab(final Lab lab) {
        labDao.addLab(lab);
    }
    public List<Lab> getLab() {
        return labDao.getLab();
    }
    public void deleteLab(final String labName) {
        labDao.deleteLab(labName);
    }
}
