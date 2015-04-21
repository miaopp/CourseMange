package com.mpp.dao;

import com.mpp.model.Apply;

import java.util.List;

/**
 * Created by xiang.xu on 2015/4/20.
 */
public interface ApplyDao {
    public void addApply(Apply apply);

    public List<Apply> getAllApply(final Integer uid);
}
