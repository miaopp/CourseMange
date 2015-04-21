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

    @Override
    public void deleteLab(final Integer id) {
        Preconditions.checkNotNull(id);
        this.sqlSession.delete("Lab.deleteLab",id);
    }

    @Override
    public List<Lab> getLabByDept(Integer labDept) {
        return this.sqlSession.selectList("Lab.selectLabByDept",labDept);
    }

    @Override
    public Lab getLabByLabId (final Integer id) {
        Preconditions.checkNotNull(id);
        return sqlSession.selectOne("Lab.selectLabByLabId", id);
    }
}
