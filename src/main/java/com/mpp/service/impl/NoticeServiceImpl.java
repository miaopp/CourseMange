package com.mpp.service.impl;

import com.mpp.dao.NoticeDao;
import com.mpp.model.Notice;
import com.mpp.service.NoticeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by pp on 2015/4/19.
 */

@Service
public class NoticeServiceImpl implements NoticeService {

    @Resource
    private NoticeDao noticeDao;

    @Override
    public List<Notice> getNoticeByTargetUser(final Integer targetUser) {
        return noticeDao.getNoticeByTargetUser(targetUser);
    }

    @Override
    public void addNotice(final Notice notice) {
        noticeDao.addNotice(notice);
    }
}
