package com.mpp.service;

import java.util.List;
import java.util.Map;

import com.mpp.model.Apply;
import com.mpp.model.entity.ApplyChangeStateBean;
import com.mpp.model.entity.CourseDisplayInfoBean;

/**
 * Created by xiang.xu on 2015/4/20.
 */
public interface ApplyService {
    public void addApply(Apply apply);

    public List<CourseDisplayInfoBean> getAllApply(final Integer uid);

    public Map<String, Object> getCourseDisplayByLabId(Integer labId);

    public Map<String, Object> getCourseDisplayByCourse(Integer userId);

    public Map<String, Object> getCourseDisplayByLab(Integer labId);

    public void applyChangeState(final ApplyChangeStateBean bean);
}
