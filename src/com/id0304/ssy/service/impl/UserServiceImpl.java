package com.id0304.ssy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.id0304.ssy.dao.UserMapper;
import com.id0304.ssy.pojo.User;
import com.id0304.ssy.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserMapper userMapper;

	@Override
	public User selectLoginUser(User user) {
		return userMapper.selectLoginUser(user);
	}

	@Override
	public User selectUserById(String u_id) {
		return userMapper.selectUserById(u_id);

	}

	@Override
	public List<User> selectStudentByProfession(String p_name) {
		return userMapper.selectStudentByProfession(p_name);
	}

	@Override
	public List<User> selectAllUser(Integer index, Integer count) {
		return userMapper.selectAllUser(index, count);
	}

	@Override
	public List<User> selectUserByConfident(Integer index, Integer count,
			String con) {
		return userMapper.selectUserByConfident(index, count, con);
	}

	@Override
	public void updateUserByUser(User userModify) {
		userMapper.updateUserByUser(userModify);
	}

	@Override
	public void deleteUserByUid(String u_id) {
		userMapper.deleteUserByUid(u_id);
	}

	@Override
	public void insertUser(User userAdd) {
		userMapper.insertUser(userAdd);
	}

	@Override
	public User selectTeacherById(String userId) {
		return userMapper.selectTeacherById( userId);
	}

	@Override
	public void updatePasswordByUser(User user) {
		userMapper.updatePasswordByUser(user);
	}

}
