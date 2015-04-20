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
    public List<Course> getCourse() {
        return this.sqlSession.selectList("Course.selectCourses");
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
}
