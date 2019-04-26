package com.id0304.ssy.pojo;

import java.io.Serializable;
import java.util.List;

public class ClassRoom implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer c_id;
	private Integer c_co_id;
	private String c_name;
	private String c_state;
	private Course course;

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

	public String getC_name() {
		return c_name;
	}

	public void setC_name(String c_name) {
		this.c_name = c_name;
	}

	public String getC_state() {
		return c_state;
	}

	public void setC_state(String c_state) {
		this.c_state = c_state;
	}

	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}

}
