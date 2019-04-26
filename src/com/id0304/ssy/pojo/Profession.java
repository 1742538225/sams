package com.id0304.ssy.pojo;

import java.io.Serializable;
import java.util.List;

public class Profession implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer p_id;
	private String p_depart;
	private String p_name;
	private List<User> userList;

	public Integer getP_id() {
		return p_id;
	}

	public void setP_id(Integer p_id) {
		this.p_id = p_id;
	}

	public String getP_depart() {
		return p_depart;
	}

	public void setP_depart(String p_depart) {
		this.p_depart = p_depart;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public List<User> getUserList() {
		return userList;
	}

	public void setUserList(List<User> userList) {
		this.userList = userList;
	}

}
