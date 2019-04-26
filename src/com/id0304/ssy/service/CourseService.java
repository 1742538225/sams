package com.id0304.ssy.service;

import java.util.List;

import com.id0304.ssy.pojo.Course;
import com.id0304.ssy.pojo.User;

public interface CourseService {

	List<Course> selectCourseByDepartAndProfession(User user, String lesson);

	Course selectCourseById(Integer co_id);

	List<Course> selectCourseByCourse(Course course, String lesson);

	void updateContentById(Integer co_id);

	List<Course> seletCourseByTeId(String co_teacher);

	List<Course> selectCourseByDepart(String u_depart);

	List<Course> selectCourseByCoTypeAndOrders(Course course);

	List<Course> selectAllCourse(Integer index, Integer count);

	List<User> selectCourseByCondition(Integer index, Integer count, String con);

	void updateCourseByCourse(Course course);

	void deleteCourseById(String co_id);

	void insertCourse(Course course);

	Course selectCourseByName(String co_name);

}
