package com.mpp.dao;

import com.mpp.model.Apply;
import com.mpp.model.entity.ApplyInfoBean;
import com.mpp.model.entity.CourseDisplayInfoBean;

import java.util.List;
import java.util.Map;

/**
 * Created by xiang.xu on 2015/4/20.
 */
public interface ApplyDao {
    public void addApply(Apply apply);

    public List<Apply> getAllApply(Integer uid);

    public List<ApplyInfoBean> getApplyInfoByLabId(Integer labId);

    public List<CourseDisplayInfoBean> getCourseDisplayInfoByUid(Integer uid);

    public List<ApplyInfoBean> getCourseDisplayInfoByLab(Integer labId);

    public Apply getApplyIdByOtherAllMessage(Apply apply);

    public void applyChangeState(final Integer applyId, final Integer state);

    public List<Apply> getApplyByCourseIdAndState(final Integer courseId, final Integer state);

    public void delApply(final int applyId);

    public Apply getApplyByApplyId(Integer applyId);
}
