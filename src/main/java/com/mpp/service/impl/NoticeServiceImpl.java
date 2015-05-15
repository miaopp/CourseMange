package com.mpp.service.impl;

import com.mpp.dao.CourseDao;
import com.mpp.dao.LabDao;
import com.mpp.dao.NoticeDao;
import com.mpp.dao.UserDao;
import com.mpp.model.Course;
import com.mpp.model.Lab;
import com.mpp.model.Notice;
import com.mpp.model.User;
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

    @Override
    public List<NoticeBean> getNoticeByTargetUser(final Integer targetUser) {
        List<Notice> notice = noticeDao.getNoticeByTargetUser(targetUser);
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
            n.setNoticeId(no.getNoticeId());
            noticeBean.add(n);
        }
        return noticeBean;
    }

    @Override
    public void addNotice(final Notice notice) {
        noticeDao.addNotice(notice);
    }
}
