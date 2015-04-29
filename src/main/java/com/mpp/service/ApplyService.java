package com.mpp.service;

import java.util.List;
import java.util.Map;

import com.mpp.model.Apply;

/**
 * Created by xiang.xu on 2015/4/20.
 */
public interface ApplyService {
    public void addApply(Apply apply);

    public List<Apply> getAllApply(Integer uid);

    public Map<String, Object> getCourseDisplayByLabId(Integer labId);
}
