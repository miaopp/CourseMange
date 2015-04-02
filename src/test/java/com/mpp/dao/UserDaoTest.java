package com.mpp.dao;

import com.mpp.model.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.annotation.Resource;

/**
 * Created by xiang.xu on 2015/3/30.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "classpath:spring/applicationContext.xml" })
@WebAppConfiguration
public class UserDaoTest {

    @Resource
    private UserDao userDao;

    @Test
    public void testByName() {
        System.out.println(userDao.getUserByName("asdf"));
    }

    @Test
    public void testAddUser() {
        User user = new User();
        user.setUsername("asdf");
        user.setPassword("asdf");
        user.setClasses(1);
        user.setDept("asdf");
        user.setPower(1);
        System.out.println(user);
        userDao.addUser(user);
    }
}
