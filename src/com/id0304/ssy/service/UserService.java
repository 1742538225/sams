package com.id0304.ssy.service;

import java.util.List;

import com.id0304.ssy.pojo.User;

public interface UserService {

	User selectLoginUser(User user);

	User selectUserById(String u_id);

	List<User> selectStudentByProfession(String p_name);

	List<User> selectAllUser(Integer index, Integer count);

	List<User> selectUserByConfident(Integer index, Integer count, String con);

	void updateUserByUser(User userModify);

	void deleteUserByUid(String u_id);

	void insertUser(User userAdd);

	User selectTeacherById(String userId);

	void updatePasswordByUser(User user);

}
