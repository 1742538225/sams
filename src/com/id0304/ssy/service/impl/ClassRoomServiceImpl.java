package com.id0304.ssy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.id0304.ssy.dao.ClassRoomMapper;
import com.id0304.ssy.pojo.ClassRoom;
import com.id0304.ssy.pojo.Course;
import com.id0304.ssy.service.ClassRoomService;

@Service
public class ClassRoomServiceImpl implements ClassRoomService {
	@Autowired
	private ClassRoomMapper classRoomMapper;

	@Override
	public List<ClassRoom> selectAllClassRoom() {
		return classRoomMapper.selectAllClassRoom();
	}

	@Override
	public List<ClassRoom> selectClassRoomByCondition(ClassRoom classRoom,
			Course course) {
		return classRoomMapper.selectClassRoomByCondition(classRoom, course);
	}

	@Override
	public void insertClassRoom(ClassRoom classRoom) {
		classRoomMapper.insertClassRoom(classRoom);
	}

	@Override
	public void deleteClassRoomById(String c_id) {
		classRoomMapper.deleteClassRoomById(c_id);
	}

	@Override
	public ClassRoom selectClassRoomById(String c_id) {
		return classRoomMapper.selectClassRoomById(c_id);
	}

	@Override
	public void updateClassRoom(ClassRoom classRoom) {
		classRoomMapper.updateClassRoom(classRoom);
	}

	@Override
	public List<ClassRoom> selectClassRoomByNameOrId(String findtext,
			Integer index, Integer count) {
		return classRoomMapper
				.selectClassRoomByNameOrId(findtext, index, count);
	}

	@Override
	public List<ClassRoom> selectClassRoomByPage(Integer index, Integer count) {
		return classRoomMapper.selectClassRoomByPage(index, count);
	}

}
