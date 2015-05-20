package com.mpp.controller;

import com.google.common.collect.ImmutableList;
import com.mpp.constants.CodeMessage;
import com.mpp.constants.JsonReturn;
import com.mpp.model.Notice;
import com.mpp.model.User;
import com.mpp.model.entity.NoticeBean;
import com.mpp.service.NoticeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * Created by pp on 2015/4/19.
 */
@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Resource
    private NoticeService noticeService;

    private static final ImmutableList teacherStates = ImmutableList.of(2, 3);
    private static final ImmutableList manageStates = ImmutableList.of(1);

    @RequestMapping(method = RequestMethod.POST, value = "/loadManagerNotice", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage loadManagerNotice(@RequestBody Notice notice, @RequestParam Integer start, @RequestParam Integer length) {
        Map<String, Object> rtn = noticeService.getNoticeByTargetUser(notice.getTargetUser(), start, length, manageStates);
        return JsonReturn.getSuccess(rtn);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/loadTeacherNotice", produces = "application/json; charset=utf-8")
    @ResponseBody
    public  CodeMessage loadTeacherNotice(@RequestBody Notice notice, @RequestParam Integer start, @RequestParam Integer length) {
        Map<String, Object> rtn = noticeService.getNoticeByTargetUser(notice.getTargetUser(), start, length, teacherStates);
        return JsonReturn.getSuccess(rtn);
    }


    @RequestMapping(method = RequestMethod.POST, value = "/noticeOfTeacherChange", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage noticeOfTeacherChange(@RequestParam Integer applyId, @RequestParam Integer state) {
        noticeService.noticeStateChange(applyId, state);
        return JsonReturn.getSuccess("success");
    }

    @RequestMapping(method = RequestMethod.POST, value = "/loadAllNoticesOfManager", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage loadAllNoticesOfManager(HttpSession httpSession) {
        User user = (User) httpSession.getAttribute("user");
        List<NoticeBean> list = noticeService.getAllNoticeOfManager(user.getUserId());
        return JsonReturn.getSuccess(list);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/noticeIsRead", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage noticeIsRead(@RequestBody Notice notice) {
        noticeService.noticeIsReadByTeacher(notice.getNoticeId(), notice.getState());
        return JsonReturn.getSuccess("success");
    }
}
