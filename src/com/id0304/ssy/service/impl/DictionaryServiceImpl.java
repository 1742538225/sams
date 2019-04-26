package com.id0304.ssy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.id0304.ssy.dao.DictionaryMapper;
import com.id0304.ssy.pojo.Dictionary;
import com.id0304.ssy.service.DictionaryService;

@Service
public class DictionaryServiceImpl implements DictionaryService {
	@Autowired
	private DictionaryMapper dictionaryMapper;
	@Override
	public List<Dictionary> selectDicByType(int d_type) {
		return dictionaryMapper.selectDicByType(d_type);
	}
	@Override
	public void deleteDepartByName(String p_depart) {
		dictionaryMapper.deleteDepartByName(p_depart);
	}
	@Override
	public void insertDepart(String p_name) {
		dictionaryMapper.insertDepart(p_name);
	}
	@Override
	public List<Dictionary> selectAllDepart() {
		return dictionaryMapper.selectAllDepart();
	}
	@Override
	public List<Dictionary> selectAllClassRoom() {
		return dictionaryMapper.selectAllClassRoom();
	}

}
