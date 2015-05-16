package com.mpp.service;

import com.mpp.model.Notice;
import com.mpp.model.entity.NoticeBean;

import java.util.List;

/**
 * Created by pp on 2015/4/19.
 */
public interface NoticeService {
    public List<NoticeBean> getNoticeByTargetUser(Integer targetUser);
    public List<String> getTeacherOfNotice(Integer targetUser);
    public void addNotice(Notice notice);
    public void noticeStateChange(Integer applyId, Integer state);
}
