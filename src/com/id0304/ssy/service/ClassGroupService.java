package com.id0304.ssy.service;

import java.util.List;

import com.id0304.ssy.pojo.ClassGroup;

public interface ClassGroupService {

	List<ClassGroup> selectStuAndCGroupByCoid(String coId);

	void insertCGroupByUidAndCoid(String u_id, String co_id);
	
}
