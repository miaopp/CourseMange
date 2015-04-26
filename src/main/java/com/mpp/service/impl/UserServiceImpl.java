package com.mpp.service.impl;

import com.mpp.dao.UserDao;
import com.mpp.model.User;
import com.mpp.service.UserService;
import jdk.nashorn.internal.ir.ReturnNode;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
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
    public List<User> getUserByDept (final Integer dept) {
        return userDao.getUserByDept(dept);
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
