package com.mpp.dao;

import com.mpp.model.Notice;
import com.mpp.model.entity.NoticeBean;

import java.util.List;

/**
 * Created by pp on 2015/4/19.
 */
public interface NoticeDao {
    public List<Notice> getNoticeByTargetUser(Integer targetUser, final Integer start, final Integer length, final List states);
    public int getCountByTargetUser(Integer targetUser, final List states);
    public void addNotice(Notice notice);
    public void noticeStateChange(Integer applyId, Integer state);
    public Notice getNoticeByApply(Integer applyId);
    public List<NoticeBean> getAllNoticeOfManager(Integer targetUser);
    public void noticeIsReadByTeacher(Integer noticeId, Integer state);
}
