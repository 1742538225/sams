package com.id0304.ssy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.id0304.ssy.pojo.Profession;

public interface ProfessionMapper {

	List<Profession> selectProfessionByPdepart(String u_depart);

	List<Profession> selectAllProfession();

	Profession selectProfessionById(String p_id);

	void updateProfessionByPro(Profession pro);

	void deleteProById(String p_id);

	void insertProfession(@Param("p_name") String p_name,
			@Param("p_depart") String p_depart);

	List<Profession> selectProfessionByCondition(String con);

}
