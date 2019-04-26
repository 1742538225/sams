package com.id0304.ssy.pojo;

import java.io.Serializable;

public class Message implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer m_id;
	private String m_type;
	private String m_body;
	private String m_source;
	private String m_target;
	private Integer m_state;

	private User user;

	public Integer getM_id() {
		return m_id;
	}

	public void setM_id(Integer m_id) {
		this.m_id = m_id;
	}

	public String getM_type() {
		return m_type;
	}

	public void setM_type(String m_type) {
		this.m_type = m_type;
	}

	public String getM_body() {
		return m_body;
	}

	public void setM_body(String m_body) {
		this.m_body = m_body;
	}

	public String getM_source() {
		return m_source;
	}

	public void setM_source(String m_source) {
		this.m_source = m_source;
	}

	public String getM_target() {
		return m_target;
	}

	public void setM_target(String m_target) {
		this.m_target = m_target;
	}

	public Integer getM_state() {
		return m_state;
	}

	public void setM_state(Integer m_state) {
		this.m_state = m_state;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
