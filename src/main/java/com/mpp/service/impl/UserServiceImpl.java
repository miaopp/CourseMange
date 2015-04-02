package com.mpp.service.impl;

import com.mpp.dao.UserDao;
import com.mpp.model.User;
import com.mpp.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

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
}
