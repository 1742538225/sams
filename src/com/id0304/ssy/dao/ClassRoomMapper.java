package com.id0304.ssy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.id0304.ssy.pojo.ClassRoom;
import com.id0304.ssy.pojo.Course;

public interface ClassRoomMapper {

	List<ClassRoom> selectAllClassRoom();

	List<ClassRoom> selectClassRoomByCondition(
			@Param("classRoom") ClassRoom classRoom,
			@Param("course") Course course);

	void insertClassRoom(ClassRoom classRoom);

	void deleteClassRoomById(String c_id);

	ClassRoom selectClassRoomById(String c_id);

	void updateClassRoom(ClassRoom classRoom);

	List<ClassRoom> selectClassRoomByNameOrId(
			@Param("findtext") String findtext, @Param("index") Integer index,
			@Param("count") Integer count);

	List<ClassRoom> selectClassRoomByPage(@Param("index") Integer index,
			@Param("count") Integer count);

}
