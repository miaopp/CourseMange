package com.mpp.dao.impl;

import com.google.common.base.Preconditions;
import com.google.common.collect.ImmutableMap;
import com.mpp.dao.NoticeDao;
import com.mpp.model.Notice;
import com.mpp.model.entity.NoticeBean;
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
    public List<Notice> getNoticeByTargetUser(final Integer targetUser, final Integer start, final Integer length, final List states) {
        ImmutableMap param = ImmutableMap.of("targetUser", targetUser, "start", start, "length", length, "states", states);
        return this.sqlSession.selectList("Notice.selectNoticeByTargetUser",param);
    }

    @Override
    public int getCountByTargetUser(final Integer targetUser, final List states) {
        ImmutableMap param = ImmutableMap.of("targetUser", targetUser, "states", states);
        return this.sqlSession.selectOne("Notice.selectCountByTargetUser",param);
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

    @Override
    public List<NoticeBean> getAllNoticeOfManager(final Integer targetUser) {
        Preconditions.checkNotNull(targetUser);
        return this.sqlSession.selectList("Notice.selectManagerAllNotices", targetUser);
    }

    @Override
    public void noticeIsReadByTeacher(final Integer noticeId, final Integer state) {
        Preconditions.checkNotNull(noticeId);
        Preconditions.checkNotNull(state);
        ImmutableMap param = ImmutableMap.of("noticeId", noticeId, "state", state);
        this.sqlSession.update("Notice.noticeOfTeacherIsRead", param);
    }
}
