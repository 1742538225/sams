package com.id0304.ssy.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.id0304.ssy.pojo.Course;
import com.id0304.ssy.pojo.Lesson;

public interface LessonService {

	List<Lesson> selectLessonByUid(String u_id);

	Boolean selectLessonIsfull(String u_id, Course course);

	void insertLessonByUidAndCoid(String l_u_id, String l_co_id);

	List<Integer> selectLessonCoidByUid(String u_id);

	List<Lesson> selectLessonAndStuByCoid(String coId);

	void updateScoreByUidAndCoid(String u_id, String co_id, String score);
	
	List<Lesson> selectLessonAndStuByCondition(String coId,String uId);

	List<Lesson> selectLessonAndCoByUid(String uid);

	List<Lesson> selectStuAndLessonAndByCoId(int co_id);

	void updateEvaluate(String l_u_id, Integer l_co_id, String l_evaluate);

	List<Lesson> selectAllLessonByPage(Integer index, Integer count);

	void insertLessonByLesson(Lesson lesson);

	Lesson selectLessonById(Integer l_id);

	void updateLesson(Lesson lesson);

	void deleteLessonById(Integer l_id);

	List<Lesson> selectLessonByCondition(String findtext, String selectdepart,
			String selectlevel, Integer index, Integer count);
}
