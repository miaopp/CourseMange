package com.mpp.dao;

import com.mpp.model.User;

import java.util.List;

/**
 * Created by xiang.xu on 2015/3/30.
 */
public interface UserDao {
    public User getUserByName(String username);

    public void addUser(User user);

    public List<User> gerUser();

    public void deleteUser (Integer userId);

    public List<User> getUserByDept (Integer dept);

    public List<User> getManageByDept (User user);

    public User getUserByUserId(Integer userId);
}
