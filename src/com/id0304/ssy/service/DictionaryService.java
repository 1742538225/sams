package com.id0304.ssy.service;

import java.util.List;

import com.id0304.ssy.pojo.Dictionary;

public interface DictionaryService {

	List<Dictionary> selectDicByType(int d_type);

	void deleteDepartByName(String p_depart);

	void insertDepart(String p_name);

	List<Dictionary> selectAllDepart();

	List<Dictionary> selectAllClassRoom();

}
