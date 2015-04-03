package com.mpp.controller;

import com.mpp.model.User;
import com.mpp.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

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
    public String register(@RequestBody User user,HttpSession httpSession) {
        //System.out.println(user);
        userService.addUser(user);
        httpSession.setAttribute("uid", user.getUserId());
        httpSession.setAttribute("user", user.getUsername());
        return "success";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/login", produces = "application/json; charset=utf-8")

    @ResponseBody
    public String login(@RequestBody User user,HttpSession httpSession) {
        System.out.println(user.getUsername());
        String rtn = "failed";
        User u = userService.getUserByName(user.getUsername());
        System.out.println(u);
        if (null != u && null != u.getPassword() && u.getPassword().equals(user.getPassword())) {
            httpSession.setAttribute("uid", u.getUserId());
            httpSession.setAttribute("user", user.getUsername());
            rtn = "success";
        }
        return rtn;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/logout", produces = "application/json; charset=utf-8")
    @ResponseBody
    public void logout(HttpSession httpSession) {
        httpSession.removeAttribute("uid");
        httpSession.removeAttribute("user");
    }
}
