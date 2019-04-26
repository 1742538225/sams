package com.id0304.ssy.pojo;

import java.io.Serializable;
import java.util.List;

public class ClassGroup implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer c_id;
	private Integer c_co_id;
	private String c_u_id;

	// 对应课程班级
	private Course course;
	// 对应的该班级的学生
	private User user;

	public Integer getC_id() {
		return c_id;
	}

	public void setC_id(Integer c_id) {
		this.c_id = c_id;
	}

	public Integer getC_co_id() {
		return c_co_id;
	}

	public void setC_co_id(Integer c_co_id) {
		this.c_co_id = c_co_id;
	}

	public String getC_u_id() {
		return c_u_id;
	}

	public void setC_u_id(String c_u_id) {
		this.c_u_id = c_u_id;
	}

	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
