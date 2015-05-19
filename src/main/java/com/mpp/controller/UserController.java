package com.mpp.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import com.mpp.constants.MajorEnum;
import com.mpp.model.entity.UserInfoBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mpp.constants.AcademyEnum;
import com.mpp.constants.CodeMessage;
import com.mpp.constants.JsonReturn;
import com.mpp.constants.UserPowerEnum;
import com.mpp.model.User;
import com.mpp.service.UserService;

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
        MajorEnum major = MajorEnum.getMajor(user.getMajor());
        if (AcademyEnum.ERROR == academy || MajorEnum.ERROR == major) {
            return JsonReturn.getError("error academy or major");
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
//        System.out.println(user.getUsername());
        User u = userService.getUserByName(user.getUsername());
//        System.out.println(u);
        if (null != u && null != u.getPassword() && u.getPassword().equals(user.getPassword())) {
            httpSession.setAttribute("user", u);
            httpSession.setAttribute("uid", u.getUserId());
            httpSession.setAttribute("username", u.getUsername());
            httpSession.setAttribute("userdept", u.getDept());
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
        httpSession.removeAttribute("userdept");
    }

    @RequestMapping(method = RequestMethod.POST, value = "/loadUser", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage loadUser(@RequestBody User user) {
        List<UserInfoBean> list = userService.getUserByDept(user.getDept());
        return JsonReturn.getSuccess(list);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/userDelete", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage userDelete(@RequestBody User user) {
        userService.deleteUser(user.getUserId());
        return JsonReturn.getSuccess("success");
    }


    @RequestMapping(method = RequestMethod.POST, value = "/userChange", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage userChange(@RequestBody User user,HttpSession httpSession) {
        userService.changUser(user);
        User u = userService.getUserByUserId(user.getUserId());
        httpSession.removeAttribute("user");
        httpSession.setAttribute("user",u);
        return JsonReturn.getSuccess("success");
    }
}
