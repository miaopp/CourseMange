package com.mpp.dao;

import com.mpp.model.Notice;
import com.mpp.model.entity.NoticeBean;

import java.util.List;

/**
 * Created by pp on 2015/4/19.
 */
public interface NoticeDao {
    public List<Notice> getNoticeByManager(Integer targetUser);
    public List<Notice> getNoticeByTeacher(Integer targetUser);
    public void addNotice(Notice notice);
    public void noticeStateChange(Integer applyId, Integer state);
    public Notice getNoticeByApply(Integer applyId);
    public List<NoticeBean> getAllNoticeOfManager(Integer targetUser);
}
