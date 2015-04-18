package com.mpp.controller;

import com.google.common.base.Preconditions;
import com.mpp.constants.CodeMessage;
import com.mpp.constants.JsonReturn;
import com.mpp.model.entity.OrderFilter;
import com.mpp.service.ScheduledService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by xiang.xu on 2015/4/18.
 */
@Controller
@RequestMapping("/schedule")
public class ScheduleController {

    @Resource
    private ScheduledService scheduledService;

    @RequestMapping(method = RequestMethod.POST, value = "/availiableOrders", produces = "application/json; charset=utf-8")
    @ResponseBody
    public CodeMessage getAvailiableOrders(@RequestBody OrderFilter filter) {
        Preconditions.checkArgument(filter.getLabId() >= 0);
        Preconditions.checkArgument(filter.getBeginWeek() > 0);
        Preconditions.checkArgument(filter.getEndWeek() > 0);
        Preconditions.checkArgument(filter.getDayOfWeek() > 0);
        filter.setLength(filter.getEndWeek()-filter.getBeginWeek()+1);
        return JsonReturn.getSuccess(scheduledService.getAvailiableOrders(filter));
    }
}
