package com.mpp.service.impl;

import com.mpp.dao.*;
import com.mpp.model.*;
import com.mpp.model.entity.NoticeBean;
import com.mpp.service.NoticeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by pp on 2015/4/19.
 */

@Service
public class NoticeServiceImpl implements NoticeService {

    @Resource
    private NoticeDao noticeDao;

    @Resource
    private UserDao userDao;

    @Resource
    private CourseDao courseDao;

    @Resource
    private LabDao labDao;

    @Resource
    private ApplyDao applyDao;

    @Override
    public List<NoticeBean> getNoticeByTargetUser(final Integer targetUser) {
        List<Notice> notice = noticeDao.getNoticeByManager(targetUser);
        List<NoticeBean> noticeBean = new ArrayList<NoticeBean>();
        for (Notice no : notice) {
            NoticeBean n = new NoticeBean();
            User u = userDao.getUserByUserId(no.getUserId());
            n.setUserRealName(u.getRealName());
            Course c = courseDao.getCourse(no.getCourseId());
            n.setCourseName(c.getName());
            Lab l = labDao.getLabByLabId(no.getLabId());
            n.setLabName(l.getLabName());
            n.setUserId(no.getUserId());
            n.setLabId(no.getLabId());
            n.setCourseId(no.getCourseId());
            n.setApplyId(no.getApplyId());
            Apply a = applyDao.getApplyByApplyId(no.getApplyId());
            n.setApplyTime(a.getApplyTime());
            n.setNoticeId(no.getNoticeId());
            n.setState(no.getState());
            noticeBean.add(n);
        }
        return noticeBean;
    }

    @Override
    public void addNotice(final Notice notice) {
        noticeDao.addNotice(notice);
    }

    @Override
    public void noticeStateChange(final Integer applyId,final Integer state) {
        noticeDao.noticeStateChange(applyId, state);
    }

    @Override
    public List<NoticeBean> getTeacherOfNotice(Integer targetUser) {
        List<Notice> notices = noticeDao.getNoticeByTeacher(targetUser);
        List<NoticeBean> list = new ArrayList<NoticeBean>();
        for (Notice notice : notices) {
            NoticeBean n = new NoticeBean();
            User u = userDao.getUserByUserId(notice.getUserId());
            n.setUserRealName(u.getRealName());
            Course c = courseDao.getCourse(notice.getCourseId());
            n.setCourseName(c.getName());
            Lab l = labDao.getLabByLabId(notice.getLabId());
            n.setLabName(l.getLabName());
            n.setUserId(notice.getUserId());
            n.setLabId(notice.getLabId());
            n.setCourseId(notice.getCourseId());
            n.setApplyId(notice.getApplyId());
            Apply a = applyDao.getApplyByApplyId(notice.getApplyId());
            n.setApplyTime(a.getApplyTime());
            n.setNoticeId(notice.getNoticeId());
            n.setState(notice.getState());
            list.add(n);
        }
        return list;
    }

    @Override
    public List<NoticeBean> getAllNoticeOfManager(final Integer targetUser) {
        return noticeDao.getAllNoticeOfManager(targetUser);
    }

    @Override
    public void noticeIsReadByTeacher(final Integer noticeId, final Integer state) {
        noticeDao.noticeIsReadByTeacher(noticeId, state);
    }
}
