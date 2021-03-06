package com.mpp.dao.impl;

import com.google.common.base.Preconditions;
import com.mpp.dao.UserDao;
import com.mpp.model.User;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by xiang.xu on 2015/3/30.
 */
@Repository
public class UserDaoImpl implements UserDao {

    @Resource
    private SqlSession sqlSession;

    @Override
    public User getUserByName(final String username) {
        Preconditions.checkNotNull(username);
        return this.sqlSession.selectOne("User.selectByName", username);
    }

    @Override
    public void addUser(final User user) {
        Preconditions.checkNotNull(user);
        this.sqlSession.insert("User.insertUser", user);
    }

    @Override
    public List<User> gerUser() {
        return this.sqlSession.selectList("User.selectUsers");
    }

    @Override
    public void deleteUser (final Integer userId) {
        Preconditions.checkNotNull(userId);
        this.sqlSession.delete("User.deleteUser", userId);
    }

    @Override
    public List<User> getUserByDept (final Integer dept) {
        Preconditions.checkNotNull(dept);
        return this.sqlSession.selectList("User.selectUserByDept", dept);
    }

    @Override
    public List<User> getManageByDept (final User user) {
        Preconditions.checkNotNull(user);
        return this.sqlSession.selectList("User.selectManagerByDept", user);
    }

    @Override
    public User getUserByUserId(final Integer userId) {
        Preconditions.checkNotNull(userId);
        return this.sqlSession.selectOne("User.selectByUserId", userId);
    }

    @Override
    public void changUser(final User user) {
        Preconditions.checkNotNull(user);
        this.sqlSession.update("User.changeUser", user);
    }
}
