package com.id0304.ssy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.id0304.ssy.dao.ClassGroupMapper;
import com.id0304.ssy.pojo.ClassGroup;
import com.id0304.ssy.service.ClassGroupService;

@Service
public class ClassGroupServiceImpl implements ClassGroupService {
	@Autowired
	private ClassGroupMapper classGroupMapper;

	@Override
	public List<ClassGroup> selectStuAndCGroupByCoid(String coId) {
		return classGroupMapper.selectStuAndCGroupByCoid(coId);
	}

	@Override
	public void insertCGroupByUidAndCoid(String u_id, String co_id) {
		classGroupMapper.insertCGroupByUidAndCoid(u_id, co_id);
	}

}
