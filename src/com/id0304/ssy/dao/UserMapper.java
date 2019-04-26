package com.id0304.ssy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.id0304.ssy.pojo.User;

public interface UserMapper {

	User selectLoginUser(User user);

	User selectUserById(String u_id);

	List<User> selectStudentByProfession(String p_name);

	List<User> selectAllUser(@Param("index") Integer index,
			@Param("count") Integer count);

	List<User> selectUserByConfident(@Param("index") Integer index,
			@Param("count") Integer count, @Param("con") String con);

	void updateUserByUser(User userModify);

	void deleteUserByUid(String u_id);

	void insertUser(User userAdd);

	void deleteCourseById(String co_id);

	User selectTeacherById(String userId);

	void updatePasswordByUser(User user);

}
