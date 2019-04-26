package com.id0304.ssy.pojo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class User implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String u_id;
	private String u_password;
	private String u_name;
	private Integer u_identify;
	private String u_credentials;
	private Long u_code;
	private String u_sex;
	private Integer u_age;
	private String u_level;
	private String u_native;
	private Date u_birthday;
	private String u_fork;
	private String u_political;
	private String u_graduate;
	private String u_teage;
	private String u_post;
	private String u_depart;
	private String u_profession;
	private String u_class;
	private String u_address;
	private Long u_tel;
	private Date u_enrolment;
	private Double u_tuition;
	private String u_detail;

	// 一名教师教授多门课
	private List<Course> course;

	// 一个学生有多门课
	private List<Lesson> lessonList;

	public String getU_id() {
		return u_id;
	}

	public void setU_id(String u_id) {
		this.u_id = u_id;
	}

	public String getU_password() {
		return u_password;
	}

	public void setU_password(String u_password) {
		this.u_password = u_password;
	}

	public String getU_name() {
		return u_name;
	}

	public void setU_name(String u_name) {
		this.u_name = u_name;
	}

	public Integer getU_identify() {
		return u_identify;
	}

	public void setU_identify(Integer u_identify) {
		this.u_identify = u_identify;
	}

	public String getU_credentials() {
		return u_credentials;
	}

	public void setU_credentials(String u_credentials) {
		this.u_credentials = u_credentials;
	}

	public Long getU_code() {
		return u_code;
	}

	public void setU_code(Long u_code) {
		this.u_code = u_code;
	}

	public String getU_sex() {
		return u_sex;
	}

	public void setU_sex(String u_sex) {
		this.u_sex = u_sex;
	}

	public Integer getU_age() {
		return u_age;
	}

	public void setU_age(Integer u_age) {
		this.u_age = u_age;
	}

	public String getU_level() {
		return u_level;
	}

	public void setU_level(String u_level) {
		this.u_level = u_level;
	}

	public String getU_native() {
		return u_native;
	}

	public void setU_native(String u_native) {
		this.u_native = u_native;
	}

	public Date getU_birthday() {
		return u_birthday;
	}

	public void setU_birthday(Date u_birthday) {
		this.u_birthday = u_birthday;
	}

	public String getU_fork() {
		return u_fork;
	}

	public void setU_fork(String u_fork) {
		this.u_fork = u_fork;
	}

	public String getU_political() {
		return u_political;
	}

	public void setU_political(String u_political) {
		this.u_political = u_political;
	}

	public String getU_graduate() {
		return u_graduate;
	}

	public void setU_graduate(String u_graduate) {
		this.u_graduate = u_graduate;
	}

	public String getU_teage() {
		return u_teage;
	}

	public void setU_teage(String u_teage) {
		this.u_teage = u_teage;
	}

	public String getU_post() {
		return u_post;
	}

	public void setU_post(String u_post) {
		this.u_post = u_post;
	}

	public String getU_depart() {
		return u_depart;
	}

	public void setU_depart(String u_depart) {
		this.u_depart = u_depart;
	}

	public String getU_profession() {
		return u_profession;
	}

	public void setU_profession(String u_profession) {
		this.u_profession = u_profession;
	}

	public String getU_class() {
		return u_class;
	}

	public void setU_class(String u_class) {
		this.u_class = u_class;
	}

	public String getU_address() {
		return u_address;
	}

	public void setU_address(String u_address) {
		this.u_address = u_address;
	}

	public Long getU_tel() {
		return u_tel;
	}

	public void setU_tel(Long u_tel) {
		this.u_tel = u_tel;
	}

	public Date getU_enrolment() {
		return u_enrolment;
	}

	public void setU_enrolment(Date u_enrolment) {
		this.u_enrolment = u_enrolment;
	}

	public Double getU_tuition() {
		return u_tuition;
	}

	public void setU_tuition(Double u_tuition) {
		this.u_tuition = u_tuition;
	}

	public String getU_detail() {
		return u_detail;
	}

	public void setU_detail(String u_detail) {
		this.u_detail = u_detail;
	}

	public List<Course> getCourse() {
		return course;
	}

	public void setCourse(List<Course> course) {
		this.course = course;
	}

	public List<Lesson> getLessonList() {
		return lessonList;
	}

	public void setLessonList(List<Lesson> lessonList) {
		this.lessonList = lessonList;
	}

}