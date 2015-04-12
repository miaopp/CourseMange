package com.mpp.controller;

import com.mpp.constants.CodeMessage;
import com.mpp.constants.JsonReturn;
import com.mpp.model.Lab;
import com.mpp.service.LabService;
import com.sun.org.apache.bcel.internal.classfile.Code;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by pp on 2015/4/11.
 */
@Controller
@RequestMapping("/lab")
public class LabController {

    @Resource
    private LabService labService;

    @RequestMapping(method = RequestMethod.GET, value = "/loadLab", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage loadLab() {
        List<Lab> list = labService.getLab();
        System.out.println(list);
        return JsonReturn.getSuccess(list);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/insertLabMessage", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage insertLabMessage(@RequestBody Lab lab) {
        labService.addLab(lab);
        return JsonReturn.getSuccess("success");
    }

    @RequestMapping(method = RequestMethod.POST, value = "/labDelete", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage labDelete(@RequestBody Integer id) {
        labService.deleteLab(id);
        return JsonReturn.getSuccess("success");
    }
}
