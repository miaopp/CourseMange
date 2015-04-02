package com.mpp.controller;

import com.mpp.model.User;
import com.mpp.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by xiang.xu on 2015/3/30.
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;

    @RequestMapping(method = RequestMethod.POST, value = "/register", produces = "application/json; charset=utf-8")
    @ResponseBody
    public String register(@RequestBody User user) {
        System.out.println(user);
        userService.addUser(user);
        return "success";
    }
}
