package com.id0304.ssy.pojo;

import java.io.Serializable;

public class Lesson implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer l_id;
	private String l_u_id;
	private Integer l_co_id;
	private double l_score;
	private String l_evaluate;

	private Course course;

	// 一对一 一行课对应一个学生
	private User user;

	public Integer getL_id() {
		return l_id;
	}

	public void setL_id(Integer l_id) {
		this.l_id = l_id;
	}

	public String getL_u_id() {
		return l_u_id;
	}

	public void setL_u_id(String l_u_id) {
		this.l_u_id = l_u_id;
	}

	public Integer getL_co_id() {
		return l_co_id;
	}

	public void setL_co_id(Integer l_co_id) {
		this.l_co_id = l_co_id;
	}

	public double getL_score() {
		return l_score;
	}

	public void setL_score(double l_score) {
		this.l_score = l_score;
	}

	public String getL_evaluate() {
		return l_evaluate;
	}

	public void setL_evaluate(String l_evaluate) {
		this.l_evaluate = l_evaluate;
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
