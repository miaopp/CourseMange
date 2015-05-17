package com.mpp.controller;

import com.mpp.constants.CodeMessage;
import com.mpp.constants.JsonReturn;
import com.mpp.model.Notice;
import com.mpp.model.entity.NoticeBean;
import com.mpp.service.NoticeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by pp on 2015/4/19.
 */
@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Resource
    private NoticeService noticeService;

    @RequestMapping(method = RequestMethod.POST, value = "/loadNotice", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage loadNotice(@RequestBody Notice notice) {
        List<NoticeBean> list = noticeService.getNoticeByTargetUser(notice.getTargetUser());
        return JsonReturn.getSuccess(list);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/loadTeacherNotice", produces = "application/json; charset=utf-8")
    @ResponseBody
    public  CodeMessage loadTeacherNotice(@RequestBody Notice notice) {
        List<NoticeBean> list = noticeService.getTeacherOfNotice(notice.getTargetUser());
        return JsonReturn.getSuccess(list);
    }


    @RequestMapping(method = RequestMethod.POST, value = "/noticeOfTeacherChange", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage noticeOfTeacherChange(@RequestParam Integer applyId, @RequestParam Integer state) {
        noticeService.noticeStateChange(applyId, state);
        return JsonReturn.getSuccess("success");
    }
}
