package com.id0304.ssy.service;

import java.util.List;

import com.id0304.ssy.pojo.Profession;

public interface ProfessionService {

	List<Profession> selectProfessionByPdepart(String u_depart);

	List<Profession> selectAllProfession();

	Profession selectProfessionById(String p_id);

	void updateProfessionByPro(Profession pro);

	void deleteProById(String p_id);

	void insertProfession(String p_name, String p_depart);

	List<Profession> selectProfessionByCondition(String con);

}
