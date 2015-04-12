package com.mpp.controller;

import com.mpp.constants.CodeMessage;
import com.mpp.constants.JsonReturn;
import com.mpp.model.Course;
import com.mpp.service.CourseService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

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
}
