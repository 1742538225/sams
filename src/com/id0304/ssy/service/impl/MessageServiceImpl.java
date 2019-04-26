package com.id0304.ssy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.id0304.ssy.dao.MessageMapper;
import com.id0304.ssy.pojo.Message;
import com.id0304.ssy.service.MessageService;

@Service
public class MessageServiceImpl implements MessageService {
	@Autowired
	private MessageMapper messageMapper;

	@Override
	public List<Message> selectMessageByUid(String uid) {
		return messageMapper.selectMessageByUid(uid);
	}

	@Override
	public void deleteMessageByUidAndMState(String u_id) {
		messageMapper.deleteMessageByUidAndMState(u_id);
	}

	@Override
	public void updateMessageByUidAndMid(String u_id, String m_id) {
		messageMapper.updateMessageByUidAndMid(u_id,m_id);
	}

	@Override
	public void insertMessageByUid(Message message) {
		messageMapper.insertMessageByUid(message);
	}

	@Override
	public void deleteMessageByMid(Integer m_id) {
		messageMapper.deleteMessageByMid(m_id);
	}


}
