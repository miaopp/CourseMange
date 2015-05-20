package com.mpp.service.impl;

import com.google.common.collect.Maps;
import com.mpp.dao.*;
import com.mpp.model.*;
import com.mpp.model.entity.NoticeBean;
import com.mpp.service.NoticeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
    public Map<String, Object> getNoticeByTargetUser(final Integer targetUser, final Integer start, final Integer length, final List manageStates) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        List<Notice> notice = noticeDao.getNoticeByTargetUser(targetUser, start, length, manageStates);
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
            n.setApplyTime(sdf.format(a.getApplyTime()));
            n.setNoticeId(no.getNoticeId());
            n.setState(no.getState());
            noticeBean.add(n);
        }
        int count = noticeDao.getCountByTargetUser(targetUser, manageStates);
        Map<String, Object> rtn = Maps.newHashMap();
        rtn.put("notice", noticeBean);
        rtn.put("count", count);
        return rtn;
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
    public List<NoticeBean> getAllNoticeOfManager(final Integer targetUser) {
        return noticeDao.getAllNoticeOfManager(targetUser);
    }

    @Override
    public void noticeIsReadByTeacher(final Integer noticeId, final Integer state) {
        noticeDao.noticeIsReadByTeacher(noticeId, state);
    }
}
