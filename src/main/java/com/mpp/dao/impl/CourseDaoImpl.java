package com.mpp.dao.impl;

import com.google.common.base.Preconditions;
import com.mpp.dao.CourseDao;
import com.mpp.model.Course;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by pp on 2015/4/12.
 */
@Repository
public class CourseDaoImpl implements CourseDao {

    @Resource
    private SqlSession sqlSession;

    @Override
    public List<Course> getCourseByUserId(final int userId) {
        Preconditions.checkArgument(userId >= 0);
        return this.sqlSession.selectList("Course.selectCoursesByUserId", userId);
    }

    @Override
    public void addCourse(final Course course) {
        Preconditions.checkNotNull(course);
        this.sqlSession.insert("Course.insertCourse",course);
    }

    @Override
    public void deleteCourse(final Integer id) {
        Preconditions.checkNotNull(id);
        this.sqlSession.delete("Course.deleteCourse",id);
    }

    @Override
    public Course getCourse(final Integer id) {
        Preconditions.checkArgument(id >= 0);
        return this.sqlSession.selectOne("Course.selectCourse", id);
    }

    @Override
    public List<Course> getCourseByMajorAndClass(final Course course) {
        Preconditions.checkNotNull(course);
        return this.sqlSession.selectList("Course.selectCourseByMajorAndClass", course);
    }

    @Override
    public List<Course> getCourseByTeacherId(final Integer userId) {
        Preconditions.checkNotNull(userId);
        return this.sqlSession.selectList("Course.selectCourseByTeacherId", userId);
    }
}
