package com.mpp.service.impl;

import java.util.*;

import javax.annotation.Resource;

import com.google.common.collect.Sets;
import com.mpp.model.entity.ApplyInfoBean;
import com.mpp.model.entity.CourseDisplayInfoBean;
import com.mpp.model.entity.LabInfoBean;
import org.springframework.stereotype.Service;

import com.google.common.collect.Maps;
import com.mpp.dao.ApplyDao;
import com.mpp.dao.CourseDao;
import com.mpp.dao.LabDao;
import com.mpp.dao.NoticeDao;
import com.mpp.dao.ScheduleDao;
import com.mpp.dao.UserDao;
import com.mpp.model.Apply;
import com.mpp.model.Course;
import com.mpp.model.Lab;
import com.mpp.model.Notice;
import com.mpp.model.User;
import com.mpp.model.entity.ScheduleStatus;
import com.mpp.service.ApplyService;

/**
 * Created by xiang.xu on 2015/4/20.
 */
@Service
public class ApplyServiceImpl implements ApplyService{

    @Resource
    private ApplyDao applyDao;

    @Resource
    private CourseDao courseDao;

    @Resource
    private ScheduleDao scheduleDao;

    @Resource
    private NoticeDao noticeDao;

    @Resource
    private UserDao userDao;

    @Resource
    private LabDao labDao;

    @Override
    public void addApply(final Apply apply) {
        applyDao.addApply(apply);

        //获取需要处理的schedule表的区间
        Course course = courseDao.getCourse(apply.getCourseId());
        int len = course.getCourseEndWeek() - course.getCourseBeginWeek() + 1;
        ScheduleStatus scheduleStatus = new ScheduleStatus(apply.getLabId(), apply.getCourseId(), apply.getDayOfWeek(), course.getCourseBeginWeek(), course.getCourseEndWeek(), len, 1, apply.getOrders());
        scheduleDao.setScheduleState(scheduleStatus);

        //得到manager
        User u = userDao.getUserByUserId(apply.getUserId());
        User u1 = new User();
        u1.setDept(u.getDept());
        u1.setPower(2);
        List<User> managerList = userDao.getManageByDept(u1);
        for (User user : managerList) {
            Notice notice = new Notice();
            Apply app = applyDao.getApplyIdByOtherAllMessage(apply);
            notice.setApplyId(app.getApplyId());
            notice.setCourseId(app.getCourseId());
            notice.setLabId(app.getLabId());
            notice.setUserId(app.getUserId());
            notice.setTargetUser(user.getUserId());
            notice.setState(1);
            noticeDao.addNotice(notice);
        }

    }

    @Override
    public List<CourseDisplayInfoBean> getAllApply(final Integer uid) {
        List<Apply> applies = applyDao.getAllApply(uid);
        List<CourseDisplayInfoBean> infoBeans = new ArrayList<CourseDisplayInfoBean>();
        for (Apply apply : applies) {
            CourseDisplayInfoBean info = new CourseDisplayInfoBean();
            Course c = courseDao.getCourse(apply.getCourseId());
            info.setCourseId(c.getId());
            info.setCourseName(c.getName());
            Lab l = labDao.getLabByLabId(apply.getLabId());
            info.setLabName(l.getLabName());
            info.setLabId(l.getId());
            User u = userDao.getUserByUserId(uid);
            info.setTeacherName(u.getRealName());
            info.setUserId(u.getUserId());
            info.setBeginWeek(c.getCourseBeginWeek());
            info.setEndWeek(c.getCourseEndWeek());
            info.setDayOfWeek(apply.getDayOfWeek());
            info.setOrders(apply.getOrders());
            infoBeans.add(info);
        }
        return infoBeans;
    }

    private final static int dayOfWeeks = 7;
    private final static int orders = 12;

    @Override
    public Map<String, Object> getCourseDisplayByLabId(final Integer labId) {
        HashMap<String, Object> rtn = Maps.newHashMap();
        Lab lab = labDao.getLabByLabId(labId);
        rtn.put("labName", lab.getLabName());

        List<ApplyInfoBean> applyInfoBeans= applyDao.getApplyInfoByLabId(labId);
        String[][] info = new String[orders][dayOfWeeks];
        for (int i = 0; i < info.length; i++) {
            for (int j = 0; j < info[i].length; j++) {
                info[i][j] = "";
            }
        }
        for (ApplyInfoBean applyInfo : applyInfoBeans) {
            info[applyInfo.getOrders()-1][applyInfo.getDayOfWeek()-1] += applyInfo.toInfoString();
        }
        rtn.put("list", info);
        return rtn;
    }

    @Override
    public Map<String, Object> getCourseDisplayByCourse(final Integer userId) {
        HashMap<String, Object> rtn = Maps.newHashMap();

        rtn.put("Title", "按课程显示课表");

        String[][] courseDisplay = new String[orders][dayOfWeeks];
        for (int i = 0; i < courseDisplay.length; i++) {
            for (int j = 0; j < courseDisplay[i].length; j++) {
                courseDisplay[i][j] = "";
            }
        }
        List<CourseDisplayInfoBean> infoList = applyDao.getCourseDisplayInfoByUid(userId);
        for (CourseDisplayInfoBean courseDisplayInfoBean : infoList) {
            courseDisplay[courseDisplayInfoBean.getOrders()-1][courseDisplayInfoBean.getDayOfWeek()-1] += courseDisplayInfoBean.toInfoString();
        }
        rtn.put("list", courseDisplay);

        Set<LabInfoBean> labTreeSet = Sets.newTreeSet();
        for (CourseDisplayInfoBean courseDisplayInfoBean : infoList) {
            LabInfoBean labInfoBean = new LabInfoBean();
            labInfoBean.setId(courseDisplayInfoBean.getLabId());
            labInfoBean.setLabName(courseDisplayInfoBean.getLabName());
            labTreeSet.add(labInfoBean);
        }
        LabInfoBean allLabInfoBean = new LabInfoBean();
        allLabInfoBean.setId(-1);
        allLabInfoBean.setLabName("All");
        labTreeSet.add(allLabInfoBean);

        rtn.put("labInfo", labTreeSet);
        return rtn;
    }

    @Override
    public Map<String, Object> getCourseDisplayByLab(final Integer labId) {
        HashMap<String, Object> rtn = new HashMap<String, Object>();
        Lab lab = labDao.getLabByLabId(labId);

        rtn.put("labName", lab.getLabName());

        List<ApplyInfoBean> applyInfoBeans = applyDao.getCourseDisplayInfoByLab(labId);
        String[][] info = new String[orders][dayOfWeeks];
        for (int i = 0; i < info.length; i++) {
            for (int j = 0; j < info[i].length; j++) {
                info[i][j] = "";
            }
        }
        for (ApplyInfoBean applyInfoBean : applyInfoBeans) {
            info[applyInfoBean.getOrders()-1][applyInfoBean.getDayOfWeek()-1] = applyInfoBean.toDisplayInfoString();
        }
        rtn.put("list", info);
        return rtn;
    }

    @Override
    public void applyChangeState(final Integer applyId, final Integer state) {
        applyDao.applyChangeState(applyId, state);
        noticeDao.noticeStateChange(applyId, state);
        Notice no = noticeDao.getNoticeByApply(applyId);
        Notice notice = new Notice();
        notice.setState(state);
        notice.setApplyId(applyId);
        notice.setTargetUser(no.getUserId());
        notice.setUserId(no.getTargetUser());
        notice.setCourseId(no.getCourseId());
        notice.setLabId(no.getLabId());
        noticeDao.addNotice(notice);
    }
}
