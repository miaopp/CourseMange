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
}
