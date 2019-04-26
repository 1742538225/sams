package com.id0304.ssy.pojo;

import java.io.Serializable;

public class Dictionary implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer d_id;
	private Integer d_type;
	private String d_name;

	public Integer getD_id() {
		return d_id;
	}

	public void setD_id(Integer d_id) {
		this.d_id = d_id;
	}

	public Integer getD_type() {
		return d_type;
	}

	public void setD_type(Integer d_type) {
		this.d_type = d_type;
	}

	public String getD_name() {
		return d_name;
	}

	public void setD_name(String d_name) {
		this.d_name = d_name;
	}

}
