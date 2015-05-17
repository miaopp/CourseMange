package com.mpp.dao.impl;

import com.google.common.base.Preconditions;
import com.google.common.collect.ImmutableMap;
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
    public List<Notice> getNoticeByManager(final Integer targetUser) {
        return this.sqlSession.selectList("Notice.selectNoticeByManager",targetUser);
    }

    @Override
    public List<Notice> getNoticeByTeacher(final Integer targetUser) {
        return this.sqlSession.selectList("Notice.selectNoticeByTeacher",targetUser);
    }

    @Override
    public void addNotice(final Notice notice) {
        Preconditions.checkNotNull(notice);
        this.sqlSession.insert("Notice.insertNotice", notice);
    }

    @Override
    public void noticeStateChange(final Integer applyId, final Integer state) {
        Preconditions.checkNotNull(applyId);
        Preconditions.checkNotNull(state);
        ImmutableMap param = ImmutableMap.of("applyId", applyId, "state", state);
        this.sqlSession.update("Notice.noticeChecked", param);
    }

    @Override
    public Notice getNoticeByApply(final Integer applyId) {
        Preconditions.checkNotNull(applyId);
        return this.sqlSession.selectOne("Notice.selectNoticeByApplyId", applyId);
    }
}
