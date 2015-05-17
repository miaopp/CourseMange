package com.mpp.controller;

import java.sql.Timestamp;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import com.mpp.model.Lab;
import com.mpp.model.User;
import com.mpp.model.entity.ApplyChangeStateBean;
import com.sun.org.apache.bcel.internal.classfile.Code;
import jdk.nashorn.internal.ir.RuntimeNode;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mpp.constants.CodeMessage;
import com.mpp.constants.JsonReturn;
import com.mpp.model.Apply;
import com.mpp.service.ApplyService;

/**
 * Created by xiang.xu on 2015/4/20.
 */
@Controller
@RequestMapping("/apply")
public class ApplyController {

    @Resource
    private ApplyService applyService;

    @RequestMapping(method = RequestMethod.POST, value = "/addApply", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage addNew(@RequestBody Apply apply) {
        apply.setApplyTime(new Timestamp(System.currentTimeMillis()));
        applyService.addApply(apply);
        return JsonReturn.getSuccess(null);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/loadAll", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage getAll(HttpSession session) {
        Integer uid = (Integer) session.getAttribute("uid");
        return JsonReturn.getSuccess(applyService.getAllApply(uid));
    }

    @RequestMapping(method = RequestMethod.POST, value = "/courseDisplay", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage courseDisplay(@RequestParam Integer LabId) {
        Map<String, Object> rtn = applyService.getCourseDisplayByLabId(LabId);
        return JsonReturn.getSuccess(rtn);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/courseDisplayByCourse", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage courseDisplayByCourse(HttpSession session) {
        Integer uid = (Integer) session.getAttribute("uid");
        Map<String, Object> rtn = applyService.getCourseDisplayByCourse(uid);
        return JsonReturn.getSuccess(rtn);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/courseDisplayByLab", produces = "application/json; charset=utf-8")
    @ResponseBody
    public  CodeMessage courseDisplayByLab(@RequestParam Integer labId) {
        Map<String, Object> rtn = applyService.getCourseDisplayByLab(labId);
        return JsonReturn.getSuccess(rtn);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/applyChangeState", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage applyChangeState(@RequestBody ApplyChangeStateBean bean) {
        applyService.applyChangeState(bean);
        return JsonReturn.getSuccess("success");
    }
}
