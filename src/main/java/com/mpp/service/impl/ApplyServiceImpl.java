package com.mpp.service.impl;

import java.util.*;

import javax.annotation.Resource;

import com.google.common.collect.ImmutableMap;
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
            notice.setApplyId(apply.getApplyId());
            notice.setCourseId(apply.getCourseId());
            notice.setLabId(apply.getLabId());
            notice.setUserId(apply.getUserId());
            notice.setTargetUser(user.getUserId());
            notice.setState(1);
            noticeDao.addNotice(notice);
        }

    }

    @Override
    public List<Apply> getAllApply(final Integer uid) {
        return applyDao.getAllApply(uid);
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
    public Map<String, Object> getCourseDisplayByCourse(final Integer userId, final Integer labId) {
        HashMap<String, Object> rtn = Maps.newHashMap();

        rtn.put("Title", "按课程显示课表");

        String[][] courseDisplay = new String[orders][dayOfWeeks];
        for (int i = 0; i < courseDisplay.length; i++) {
            for (int j = 0; j < courseDisplay[i].length; j++) {
                courseDisplay[i][j] = "";
            }
        }
        ImmutableMap param = ImmutableMap.of("uid", userId, "labId", labId);
        List<CourseDisplayInfoBean> infoList = applyDao.getCourseDisplayInfoByUid(param);
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
}
