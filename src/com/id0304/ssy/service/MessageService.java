package com.id0304.ssy.service;

import java.util.List;

import com.id0304.ssy.pojo.Message;

public interface MessageService {

	List<Message> selectMessageByUid(String uid);

	void deleteMessageByUidAndMState(String u_id);

	void updateMessageByUidAndMid(String u_id, String m_id);
	
	void insertMessageByUid(Message message);

	void deleteMessageByMid(Integer m_id);
	
}
