package com.mpp.service;

import com.mpp.model.Notice;

import java.util.List;

/**
 * Created by pp on 2015/4/19.
 */
public interface NoticeService {
    public List<Notice> getNoticeByTargetUser(Integer targetUser);
}
