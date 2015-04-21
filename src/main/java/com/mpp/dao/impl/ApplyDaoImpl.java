package com.mpp.dao.impl;

import com.google.common.base.Preconditions;
import com.mpp.dao.ApplyDao;
import com.mpp.model.Apply;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by xiang.xu on 2015/4/20.
 */
@Repository
public class ApplyDaoImpl implements ApplyDao {

    @Resource
    private SqlSession sqlSession;

    @Override
    public void addApply(final Apply apply) {
        Preconditions.checkNotNull(apply);
        sqlSession.insert("Apply.insertApply", apply);
    }

    @Override
    public List<Apply> getAllApply(final Integer uid) {
        return sqlSession.selectList("Apply.selectAll", uid);
    }
}
