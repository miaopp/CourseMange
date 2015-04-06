package com.mpp.controller;

import com.google.common.collect.ImmutableMap;
import com.mpp.constants.CodeMessage;
import com.mpp.constants.JsonReturn;
import com.mpp.model.User;
import com.mpp.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.Map;

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
        String rtn = "failed";
        httpSession.setAttribute("uid", user.getUserId());
        httpSession.setAttribute("user", user.getUsername());
        if(user.getPower() == 0) {
            rtn = "student";
        }
        else if(user.getPower() == 1) {
            rtn = "teacher";
        }
        else if(user.getPower() == 2) {
            rtn = "manager";
        }
        return rtn;
    }

    @RequestMapping(method = RequestMethod.POST, value = "/login", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage login(@RequestBody User user,HttpSession httpSession) {
        System.out.println(user.getUsername());
        CodeMessage rtn = JsonReturn.getError("faild");
        User u = userService.getUserByName(user.getUsername());
        System.out.println(u);
        if (null != u && null != u.getPassword() && u.getPassword().equals(user.getPassword())) {
            httpSession.setAttribute("uid", u.getUserId());
            httpSession.setAttribute("user", user.getUsername());
            if(u.getPower() == 0) {
                rtn = JsonReturn.getSuccess("./index.jsp");
            }
            else if(u.getPower() == 1) {
                rtn = JsonReturn.getSuccess("./teacher.jsp");
            }
            else if(u.getPower() == 2) {
                rtn = JsonReturn.getSuccess("./manager.jsp");
            }
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
