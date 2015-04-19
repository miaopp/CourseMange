package com.mpp.dao.impl;

import com.mpp.dao.NoticeDao;
import com.mpp.model.Notice;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by pp on 2015/4/19.
 */

@Repository
public class NoticeDaoImpl implements NoticeDao {

    @Resource
    private SqlSession sqlSession;

    @Override
    public List<Notice> getNoticeByTargetUser(final Integer targetUser) {
        return this.sqlSession.selectList("Notice.selectNoticeByTargetUser",targetUser);
    }
}
