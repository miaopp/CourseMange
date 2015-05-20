package com.mpp.service;

import com.mpp.model.Notice;
import com.mpp.model.entity.NoticeBean;

import java.util.List;
import java.util.Map;

/**
 * Created by pp on 2015/4/19.
 */
public interface NoticeService {
    public Map<String, Object> getNoticeByTargetUser(Integer targetUser, final Integer start, final Integer length, final List manageStates);
    public void addNotice(Notice notice);
    public void noticeStateChange(Integer applyId, Integer state);
    public List<NoticeBean> getAllNoticeOfManager(Integer targetUser);
    public void noticeIsReadByTeacher(Integer noticeId, Integer state);
}
