package com.mpp.dao;

import com.mpp.model.Notice;

import java.util.List;

/**
 * Created by pp on 2015/4/19.
 */
public interface NoticeDao {
    public List<Notice> getNoticeByTargetUser(Integer targetUser);
}
