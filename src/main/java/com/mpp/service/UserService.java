package com.mpp.service;

import com.mpp.model.User;

import java.util.List;

/**
 * Created by xiang.xu on 2015/4/2.
 */
public interface UserService {
    public void addUser(User user);
    public User getUserByName(String username);
    public List<User> gerUser();
    public void deleteUser (Integer userId);
    public List<User> getUserByDept (Integer dept);
    public List<User> getManageByDept (User user);
    public User getUserByUserId(Integer userId);
}
