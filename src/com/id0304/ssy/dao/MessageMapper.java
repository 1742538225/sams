package com.id0304.ssy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.id0304.ssy.pojo.Message;

public interface MessageMapper {

	List<Message> selectMessageByUid(String uid);

	void deleteMessageByUidAndMState(String u_id);

	void updateMessageByUidAndMid(@Param("u_id") String u_id,
			@Param("m_id") String m_id);

	void insertMessageByUid(Message message);

	void deleteMessageByMid(Integer m_id);

}
