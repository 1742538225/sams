package com.id0304.ssy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.id0304.ssy.dao.CourseMapper;
import com.id0304.ssy.pojo.Course;
import com.id0304.ssy.pojo.User;
import com.id0304.ssy.service.CourseService;

@Service
public class CourseServiceImpl implements CourseService {
	@Autowired
	private CourseMapper courseMapper;

	@Override
	public Course selectCourseById(Integer co_id) {
		return courseMapper.selectCourseById(co_id);
	}

	@Override
	public List<Course> selectCourseByCourse(Course course, String lesson) {
		return courseMapper.selectCourseByCourse(course, lesson);
	}

	@Override
	public List<Course> selectCourseByDepartAndProfession(User user,
			String lesson) {
		return courseMapper.selectCourseByDepartAndProfession(user, lesson);
	}

	@Override
	public void updateContentById(Integer co_id) {
		courseMapper.updateContentById(co_id);
	}

	@Override
	public List<Course> seletCourseByTeId(String co_teacher) {
		return courseMapper.seletCourseByTeId(co_teacher);
	}

	@Override
	public List<Course> selectCourseByDepart(String u_depart) {
		return courseMapper.selectCourseByDepart(u_depart);
	}

	@Override
	public List<Course> selectCourseByCoTypeAndOrders(Course course) {
		return courseMapper.selectCourseByCoTypeAndOrders(course);
	}

	@Override
	public List<Course> selectAllCourse(Integer index, Integer count) {
		return courseMapper.selectAllCourse(index, count);
	}

	@Override
	public List<User> selectCourseByCondition(Integer index, Integer count,
			String con) {
		return courseMapper.selectCourseByCondition(index, count, con);
	}

	@Override
	public void updateCourseByCourse(Course course) {
		courseMapper.updateCourseByCourse(course);
	}

	@Override
	public void deleteCourseById(String co_id) {
		courseMapper.deleteCourseById(co_id);
	}

	@Override
	public void insertCourse(Course course) {
		courseMapper.insertCourse(course);
	}

	@Override
	public Course selectCourseByName(String co_name) {
		return courseMapper.selectCourseByName(co_name);
	}

}
