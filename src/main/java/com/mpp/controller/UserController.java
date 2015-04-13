package com.mpp.controller;

import com.google.common.collect.ImmutableMap;
import com.mpp.constants.CodeMessage;
import com.mpp.constants.JsonReturn;
import com.mpp.constants.UserPowerEnum;
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
    public CodeMessage register(@RequestBody User user,HttpSession httpSession) {
        System.out.println(user.getPower());
        userService.addUser(user);
        CodeMessage rtn = JsonReturn.getError("faild");
        httpSession.setAttribute("uid", user.getUserId());
        httpSession.setAttribute("user", user.getUsername());
        UserPowerEnum powerEnum = UserPowerEnum.getType(user.getPower());
        rtn = JsonReturn.getSuccess(powerEnum.getDispather());
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
            httpSession.setAttribute("realname",u.getRealName());
            UserPowerEnum powerEnum = UserPowerEnum.getType(u.getPower());
            rtn = JsonReturn.getSuccess(powerEnum.getDispather());
        }
        return rtn;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/logout", produces = "application/json; charset=utf-8")
    @ResponseBody
    public void logout(HttpSession httpSession) {
        httpSession.removeAttribute("uid");
        httpSession.removeAttribute("user");
        httpSession.removeAttribute("realname");
    }
}
