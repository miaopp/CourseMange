package com.mpp.service.impl;

import com.google.common.collect.Lists;
import com.mpp.constants.OrdersClassEnum;
import com.mpp.dao.ScheduleDao;
import com.mpp.model.Schedule;
import com.mpp.model.entity.CodeNameBean;
import com.mpp.model.entity.OrderFilter;
import com.mpp.service.ScheduledService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by xiang.xu on 2015/4/18.
 */
@Service
public class ScheduledServiceImpl implements ScheduledService {

    @Resource
    private ScheduleDao scheduleDao;

    @Override
    public List<CodeNameBean> getAvailiableOrders(final OrderFilter filter) {
        filter.setStatus(0);
        List<Integer> orders = scheduleDao.getOrders(filter);
        List<CodeNameBean> beans = Lists.newArrayList();
        for (Integer order : orders) {
            OrdersClassEnum ordersClassEnum = OrdersClassEnum.getByCode(order);
            beans.add(new CodeNameBean(ordersClassEnum.getCode(), ordersClassEnum.getDesc()));
        }
        return beans;
    }
}
