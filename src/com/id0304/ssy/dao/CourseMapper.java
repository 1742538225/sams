package com.id0304.ssy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.id0304.ssy.pojo.Course;
import com.id0304.ssy.pojo.User;

public interface CourseMapper {

	List<Course> selectCourseByDepartAndProfession(@Param("user") User user,
			@Param("lesson") String lesson);

	Course selectCourseById(Integer co_id);

	List<Course> selectCourseByCourse(@Param("course") Course course,
			@Param("lesson") String lesson);

	void updateContentById(Integer co_id);

	List<Course> seletCourseByTeId(String co_teacher);

	List<Course> selectCourseByDepart(String u_depart);

	List<Course> selectCourseByCoTypeAndOrders(Course course);

	List<Course> selectAllCourse(@Param("index") Integer index,
			@Param("count") Integer count);

	List<User> selectCourseByCondition(@Param("index") Integer index,
			@Param("count") Integer count, @Param("con") String con);

	void updateCourseByCourse(Course course);

	void deleteCourseById(String co_id);

	void insertCourse(Course course);

	Course selectCourseByName(String co_name);

}
