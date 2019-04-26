package com.id0304.ssy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.id0304.ssy.pojo.ClassGroup;

public interface ClassGroupMapper {

	List<ClassGroup> selectStuAndCGroupByCoid(String coId);

	void insertCGroupByUidAndCoid(@Param("u_id") String u_id, @Param("co_id") String co_id);
	
}
