package com.id0304.ssy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.id0304.ssy.dao.LessonMapper;
import com.id0304.ssy.pojo.Course;
import com.id0304.ssy.pojo.Lesson;
import com.id0304.ssy.service.LessonService;

@Service
public class LessonServiceImpl implements LessonService {
	@Autowired
	private LessonMapper lessonMapper;

	@Override
	public List<Lesson> selectLessonByUid(String u_id) {
		return lessonMapper.selectLessonByUid(u_id);
	}

	@Override
	public Boolean selectLessonIsfull(String u_id, Course course) {
		List<Lesson> lessonList = lessonMapper.selectLessonByUid(u_id);
		for (Lesson lesson : lessonList) {
			if (course.getCo_weekday() == lesson.getCourse().getCo_weekday()
					&& course.getCo_lessonnum() == lesson.getCourse()
							.getCo_lessonnum()) {
				return true;
			}
		}
		return false;
	}

	@Override
	public void insertLessonByUidAndCoid(String l_u_id, String l_co_id) {
		lessonMapper.insertLessonByUidAndCoid(l_u_id, l_co_id);
	}

	/**
	 * 根据用户id查询所有课程id
	 */
	@Override
	public List<Integer> selectLessonCoidByUid(String u_id) {
		return lessonMapper.selectLessonCoidByUid(u_id);
	}

	@Override
	public List<Lesson> selectLessonAndStuByCoid(String coId) {
		return lessonMapper.selectLessonAndStuByCoid(coId);
	}

	@Override
	public void updateScoreByUidAndCoid(String u_id, String co_id, String score) {
		lessonMapper.updateScoreByUidAndCoid(u_id, co_id, score);
	}

	@Override
	public List<Lesson> selectLessonAndStuByCondition(String coId, String uId) {
		return lessonMapper.selectLessonAndStuByCondition(coId, uId);
	}

	@Override
	public List<Lesson> selectLessonAndCoByUid(String uid) {
		return lessonMapper.selectLessonAndCoByUid(uid);
	}

	@Override
	public List<Lesson> selectStuAndLessonAndByCoId(int co_id) {
		return lessonMapper.selectStuAndLessonAndByCoId(co_id);
	}

	@Override
	public void updateEvaluate(String l_u_id, Integer l_co_id, String l_evaluate) {
		lessonMapper.updateEvaluate(l_u_id, l_co_id, l_evaluate);
	}

	@Override
	public List<Lesson> selectAllLessonByPage(Integer index, Integer count) {
		return lessonMapper.selectAllLessonByPage(index, count);
	}

	@Override
	public void insertLessonByLesson(Lesson lesson) {
		lessonMapper.insertLessonByLesson(lesson);
	}

	@Override
	public Lesson selectLessonById(Integer l_id) {
		return lessonMapper.selectLessonById(l_id);
	}

	@Override
	public void updateLesson(Lesson lesson) {
		lessonMapper.updateLesson(lesson);
	}

	@Override
	public void deleteLessonById(Integer l_id) {
		lessonMapper.deleteLessonById(l_id);
	}

	@Override
	public List<Lesson> selectLessonByCondition(String findtext,
			String selectdepart, String selectlevel, Integer index,
			Integer count) {
		return lessonMapper.selectLessonByCondition(findtext, selectdepart,
				selectlevel, index, count);
	}

}
