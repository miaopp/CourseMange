package com.mpp.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mpp.constants.AcademyEnum;
import com.mpp.constants.CodeMessage;
import com.mpp.constants.JsonReturn;
import com.mpp.model.Lab;
import com.mpp.model.User;
import com.mpp.service.LabService;

/**
 * Created by pp on 2015/4/11.
 */
@Controller
@RequestMapping("/lab")
public class LabController {

    @Resource
    private LabService labService;

    @RequestMapping(method = RequestMethod.POST, value = "/loadLab", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage loadLab(@RequestBody Lab lab) {
        List<Lab> list = labService.getLabNameByDept(lab.getLabDept());
//        System.out.println(list);
        return JsonReturn.getSuccess(list);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/insertLabMessage", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage insertLabMessage(@RequestBody Lab lab) {
        AcademyEnum academy = AcademyEnum.getAcademy(lab.getLabDept());
        if (AcademyEnum.ERROR == academy) {
            return JsonReturn.getError("error academy");
        }
        labService.addLab(lab);
        return JsonReturn.getSuccess("success");
    }

    @RequestMapping(method = RequestMethod.POST, value = "/labDelete", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage labDelete(@RequestBody Lab lab) {
        labService.deleteLab(lab.getId());
        return JsonReturn.getSuccess("success");
    }

    @RequestMapping(method = RequestMethod.POST, value = "/getLabListByTeacher", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage getLabList(HttpSession httpSession) {
        User user = (User) httpSession.getAttribute("user");
        List<Lab> list = labService.getLabNameByDept(user.getDept());
        return JsonReturn.getSuccess(list);
    }
}
