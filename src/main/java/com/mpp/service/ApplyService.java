package com.mpp.service;

import com.mpp.model.Apply;

import java.util.List;

/**
 * Created by xiang.xu on 2015/4/20.
 */
public interface ApplyService {
    public void addApply(Apply apply);

    public List<Apply> getAllApply(Integer uid);
}