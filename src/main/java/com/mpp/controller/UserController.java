package com.mpp.controller;

import com.google.common.collect.ImmutableMap;
import com.mpp.constants.AcademyEnum;
import com.mpp.constants.CodeMessage;
import com.mpp.constants.JsonReturn;
import com.mpp.constants.UserPowerEnum;
import com.mpp.model.User;
import com.mpp.service.UserService;
import com.sun.org.apache.bcel.internal.classfile.Code;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;
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
        AcademyEnum academy = AcademyEnum.getAcademy(user.getDept());
        if (AcademyEnum.ERROR == academy) {
            return JsonReturn.getError("error academy");
        }

        System.out.println(user.getPower());
        userService.addUser(user);
        httpSession.setAttribute("user", user);
        httpSession.setAttribute("uid", user.getUserId());
        httpSession.setAttribute("username", user.getUsername());
        UserPowerEnum powerEnum = UserPowerEnum.getType(user.getPower());
        return JsonReturn.getSuccess(powerEnum.getDispather());
    }

    @RequestMapping(method = RequestMethod.POST, value = "/login", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage login(@RequestBody User user,HttpSession httpSession) {
        System.out.println(user.getUsername());
        User u = userService.getUserByName(user.getUsername());
        System.out.println(u);
        if (null != u && null != u.getPassword() && u.getPassword().equals(user.getPassword())) {
            httpSession.setAttribute("user", u);
            httpSession.setAttribute("uid", u.getUserId());
            httpSession.setAttribute("username", u.getUsername());
            UserPowerEnum powerEnum = UserPowerEnum.getType(u.getPower());
            return JsonReturn.getSuccess(powerEnum.getDispather());
        }
        return JsonReturn.getError("failed");
    }

    @RequestMapping(method = RequestMethod.GET, value = "/logout", produces = "application/json; charset=utf-8")
    @ResponseBody
    public void logout(HttpSession httpSession) {
        httpSession.removeAttribute("user");
        httpSession.removeAttribute("uid");
        httpSession.removeAttribute("username");
    }

    @RequestMapping(method = RequestMethod.GET, value = "/loadUser", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage loadUser() {
        List<User> list = userService.gerUser();
        return JsonReturn.getSuccess(list);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/userDelete", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage userDelete(@RequestBody User user) {
        userService.deleteUser(user.getUserId());
        return JsonReturn.getSuccess("success");
    }

}
