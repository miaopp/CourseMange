package com.mpp.controller;

import com.mpp.constants.CodeMessage;
import com.mpp.constants.JsonReturn;
import com.mpp.model.Notice;
import com.mpp.service.NoticeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
        List<Notice> list = noticeService.getNoticeByTargetUser(notice.getTargetUser());
        return JsonReturn.getSuccess(list);
    }
}
