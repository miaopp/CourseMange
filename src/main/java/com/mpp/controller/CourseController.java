package com.mpp.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import com.google.common.collect.Lists;
import com.mpp.constants.AcademyEnum;
import com.mpp.model.User;
import com.mpp.model.entity.CourseBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mpp.constants.CodeMessage;
import com.mpp.constants.JsonReturn;
import com.mpp.model.Course;
import com.mpp.service.CourseService;

/**
 * Created by pp on 2015/4/12.
 */
@Controller
@RequestMapping("/course")
public class CourseController {

    @Resource
    private CourseService courseService;

    @RequestMapping(method = RequestMethod.GET, value = "/loadCourse", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage loadCourse(HttpSession httpSession) {
        User user = (User) httpSession.getAttribute("user");
        List<CourseBean> list = courseService.getCourse(user.getUserId());
        return JsonReturn.getSuccess(list);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/insertCourseMessage", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage insertCourseMessage(@RequestBody Course course) {
        AcademyEnum academy = AcademyEnum.getAcademy(course.getCourseDept());
        if (AcademyEnum.ERROR == academy) {
            return JsonReturn.getError("error academy");
        }
        courseService.addCourse(course);
        return JsonReturn.getSuccess("success");
    }

    @RequestMapping(method = RequestMethod.POST, value = "/loadCourseByTeacher", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage loadCourseByTeacher(HttpSession httpSession) {
        User user = (User) httpSession.getAttribute("user");
        List<Course> list = courseService.getCourseByTeacherId(user.getUserId());
        return JsonReturn.getSuccess(list);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/delCourse", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage delCourse(@RequestParam Integer courseId) {
        courseService.deleteCourse(courseId);
        return JsonReturn.getSuccess("success");
    }
}
