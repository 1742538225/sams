package com.id0304.ssy.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.id0304.ssy.dao.ProfessionMapper;
import com.id0304.ssy.pojo.Profession;
import com.id0304.ssy.service.ProfessionService;

@Service
public class ProfessionServiceImpl implements ProfessionService {
	@Autowired
	private ProfessionMapper professionMapper;

	@Override
	public List<Profession> selectProfessionByPdepart(String u_depart) {
		return professionMapper.selectProfessionByPdepart(u_depart);
	}

	@Override
	public List<Profession> selectAllProfession() {
		return professionMapper.selectAllProfession();
	}

	@Override
	public Profession selectProfessionById(String p_id) {
		return professionMapper.selectProfessionById(p_id);
	}

	@Override
	public void updateProfessionByPro(Profession pro) {
		professionMapper.updateProfessionByPro(pro);
	}

	@Override
	public void deleteProById(String p_id) {
		professionMapper.deleteProById(p_id);
	}

	@Override
	public void insertProfession(String p_name, String p_depart) {
		professionMapper.insertProfession(p_name, p_depart);
	}

	@Override
	public List<Profession> selectProfessionByCondition(String con) {
		return professionMapper.selectProfessionByCondition(con);
	}

}
