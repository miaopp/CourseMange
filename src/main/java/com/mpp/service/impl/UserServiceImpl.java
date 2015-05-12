package com.mpp.service.impl;

import com.mpp.dao.UserDao;
import com.mpp.model.User;
import com.mpp.model.entity.UserInfoBean;
import com.mpp.service.UserService;
import jdk.nashorn.internal.ir.ReturnNode;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by xiang.xu on 2015/4/2.
 */
@Service
public class UserServiceImpl implements UserService {

    @Resource
    private UserDao userDao;

    @Override
    public void addUser(final User user) {
        userDao.addUser(user);
    }
    public User getUserByName(final String username) {
        return userDao.getUserByName(username);
    }
    public List<User> gerUser() {
        return userDao.gerUser();
    }
    public void deleteUser (final Integer userId) {
        userDao.deleteUser(userId);
    }
    public List<UserInfoBean> getUserByDept (final Integer dept) {
        List<User> user = userDao.getUserByDept(dept);
        List<UserInfoBean> list = new ArrayList<UserInfoBean>();
        for (User user1 : user) {
            UserInfoBean u = new UserInfoBean();
            u.setUserId(user1.getUserId());
            u.setUserName(user1.getUsername());
            u.setRealName(user1.getRealName());
            u.setStatus(0);
            if(1 == user1.getDept()) {
                u.setDept("计算机学院");
            }
            else if(2 == user1.getDept()) {
                u.setDept("软件学院");
            }
            if(101 == user1.getMajor()) {
                u.setMajor("计算机科学与技术");
            }
            else if(102 == user1.getMajor()) {
                u.setMajor("数字媒体");
            }
            else if(201 == user1.getMajor()) {
                u.setMajor("软件工程");
            }
            if(0 == user1.getPower()) {
                u.setUserPower("学生");
            }
            else if(1 == user1.getPower()) {
                u.setUserPower("老师");
                u.setStatus(1);
            }
            else if(2 == user1.getPower()) {
                u.setUserPower("管理员");
            }
            list.add(u);
        }
        return list;
    }
    public List<User> getManageByDept (final User user) {
        return userDao.getManageByDept(user);
    }
    public User getUserByUserId(final Integer userId) {
        return userDao.getUserByUserId(userId);
    }
    public void changUser(final User user) {
        userDao.changUser(user);
    }
}
