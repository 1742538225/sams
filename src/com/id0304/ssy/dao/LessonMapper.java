package com.id0304.ssy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.id0304.ssy.pojo.Lesson;

public interface LessonMapper {

	List<Lesson> selectLessonByUid(String u_id);

	void insertLessonByUidAndCoid(@Param("l_u_id") String l_u_id,
			@Param("l_co_id") String l_co_id);

	/**
	 * 根据用户id查询所有课程id
	 */
	List<Integer> selectLessonCoidByUid(String u_id);

	List<Lesson> selectLessonAndStuByCoid(String coId);

	void updateScoreByUidAndCoid(@Param("u_id") String u_id,
			@Param("co_id") String co_id, @Param("score") String score);

	List<Lesson> selectLessonAndStuByCondition(@Param("coId") String coId,
			@Param("uId") String uId);

	List<Lesson> selectLessonAndCoByUid(String uid);

	List<Lesson> selectStuAndLessonAndByCoId(int co_id);

	void updateEvaluate(@Param("l_u_id") String l_u_id,
			@Param("l_co_id") Integer l_co_id,
			@Param("l_evaluate") String l_evaluate);

	List<Lesson> selectAllLessonByPage(@Param("index") Integer index,
			@Param("count") Integer count);

	void insertLessonByLesson(Lesson lesson);

	Lesson selectLessonById(Integer l_id);

	void updateLesson(Lesson lesson);

	void deleteLessonById(Integer l_id);

	List<Lesson> selectLessonByCondition(@Param("findtext") String findtext,
			@Param("selectdepart") String selectdepart,
			@Param("selectlevel") String selectlevel,
			@Param("index") Integer index, @Param("count") Integer count);

}
