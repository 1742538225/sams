package com.id0304.ssy.service;

import java.util.List;

import com.id0304.ssy.pojo.ClassRoom;
import com.id0304.ssy.pojo.Course;

public interface ClassRoomService {

	List<ClassRoom> selectAllClassRoom();

	List<ClassRoom> selectClassRoomByCondition(ClassRoom classRoom, Course course);

	void insertClassRoom(ClassRoom classRoom);

	void deleteClassRoomById(String c_id);

	ClassRoom selectClassRoomById(String c_id);

	void updateClassRoom(ClassRoom classRoom);

	List<ClassRoom> selectClassRoomByNameOrId(String findtext, Integer index, Integer count);

	List<ClassRoom> selectClassRoomByPage(Integer index, Integer count);

}
