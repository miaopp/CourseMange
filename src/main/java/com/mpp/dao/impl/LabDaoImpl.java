package com.mpp.dao.impl;

import com.google.common.base.Preconditions;
import com.mpp.dao.LabDao;
import com.mpp.model.Lab;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by pp on 2015/4/11.
 */

@Repository
public class LabDaoImpl implements LabDao {


    @Resource
    private SqlSession sqlSession;

    @Override
    public List<Lab> getLab() {
        return this.sqlSession.selectList("Lab.selectLabs");
    }

    @Override
    public void addLab(final Lab lab) {
        Preconditions.checkNotNull(lab);
        this.sqlSession.insert("Lab.insertLab",lab);
    }
}
