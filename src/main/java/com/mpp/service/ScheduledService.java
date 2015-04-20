package com.mpp.service;

import com.mpp.model.entity.CodeNameBean;
import com.mpp.model.entity.OrderFilter;

import java.util.List;

/**
 * Created by xiang.xu on 2015/4/18.
 */
public interface ScheduledService {
    public List<CodeNameBean> getAvailableOrders(OrderFilter filter);
}
