package com.mpp.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
    public CodeMessage loadCourse() {
        List<Course> list = courseService.getCourse();
        return JsonReturn.getSuccess(list);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/insertCourseMessage", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage insertCourseMessage(@RequestBody Course course) {
        courseService.addCourse(course);
        return JsonReturn.getSuccess("success");
    }

    @RequestMapping(method = RequestMethod.POST, value = "/courseDelete", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage courseDelete(@RequestBody Course course) {
        courseService.deleteCourse(course.getId());
        return JsonReturn.getSuccess("success");
    }
}
