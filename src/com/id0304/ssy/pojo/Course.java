package com.id0304.ssy.pojo;

import java.io.Serializable;
import java.util.List;

public class Course implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer co_id;
	private String co_name;
	private String co_type;
	private Integer co_lessonnum;
	private String co_weeks;
	private String co_place;
	private String co_teacher;
	private Integer co_weekday;
	private String co_grade;
	private String co_depart;
	private String co_profession;
	private String co_tedepart;
	private Double co_credit;
	private Integer co_content;
	private Integer co_occupy;
	private String co_margin;
	private Integer co_state;

	private User user;
	private List<Lesson> lessonList;
	private ClassRoom classRoom;

	public Integer getCo_id() {
		return co_id;
	}

	public void setCo_id(Integer co_id) {
		this.co_id = co_id;
	}

	public String getCo_name() {
		return co_name;
	}

	public void setCo_name(String co_name) {
		this.co_name = co_name;
	}

	public String getCo_type() {
		return co_type;
	}

	public void setCo_type(String co_type) {
		this.co_type = co_type;
	}

	public Integer getCo_lessonnum() {
		return co_lessonnum;
	}

	public void setCo_lessonnum(Integer co_lessonnum) {
		this.co_lessonnum = co_lessonnum;
	}

	public String getCo_weeks() {
		return co_weeks;
	}

	public void setCo_weeks(String co_weeks) {
		this.co_weeks = co_weeks;
	}

	public String getCo_place() {
		return co_place;
	}

	public void setCo_place(String co_place) {
		this.co_place = co_place;
	}

	public String getCo_teacher() {
		return co_teacher;
	}

	public void setCo_teacher(String co_teacher) {
		this.co_teacher = co_teacher;
	}

	public Integer getCo_weekday() {
		return co_weekday;
	}

	public void setCo_weekday(Integer co_weekday) {
		this.co_weekday = co_weekday;
	}

	public String getCo_grade() {
		return co_grade;
	}

	public void setCo_grade(String co_grade) {
		this.co_grade = co_grade;
	}

	public String getCo_depart() {
		return co_depart;
	}

	public void setCo_depart(String co_depart) {
		this.co_depart = co_depart;
	}

	public String getCo_profession() {
		return co_profession;
	}

	public void setCo_profession(String co_profession) {
		this.co_profession = co_profession;
	}

	public String getCo_tedepart() {
		return co_tedepart;
	}

	public void setCo_tedepart(String co_tedepart) {
		this.co_tedepart = co_tedepart;
	}

	public Double getCo_credit() {
		return co_credit;
	}

	public void setCo_credit(Double co_credit) {
		this.co_credit = co_credit;
	}

	public Integer getCo_content() {
		return co_content;
	}

	public void setCo_content(Integer co_content) {
		this.co_content = co_content;
	}

	public Integer getCo_occupy() {
		return co_occupy;
	}

	public void setCo_occupy(Integer co_occupy) {
		this.co_occupy = co_occupy;
	}

	public String getCo_margin() {
		return co_margin;
	}

	public void setCo_margin(String co_margin) {
		this.co_margin = co_margin;
	}

	public Integer getCo_state() {
		return co_state;
	}

	public void setCo_state(Integer co_state) {
		this.co_state = co_state;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Lesson> getLessonList() {
		return lessonList;
	}

	public void setLessonList(List<Lesson> lessonList) {
		this.lessonList = lessonList;
	}

	public ClassRoom getClassRoom() {
		return classRoom;
	}

	public void setClassRoom(ClassRoom classRoom) {
		this.classRoom = classRoom;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Course other = (Course) obj;
		if (co_content == null) {
			if (other.co_content != null)
				return false;
		} else if (!co_content.equals(other.co_content))
			return false;
		if (co_depart == null) {
			if (other.co_depart != null)
				return false;
		} else if (!co_depart.equals(other.co_depart))
			return false;
		if (co_grade == null) {
			if (other.co_grade != null)
				return false;
		} else if (!co_grade.equals(other.co_grade))
			return false;
		if (co_id == null) {
			if (other.co_id != null)
				return false;
		} else if (!co_id.equals(other.co_id))
			return false;
		if (co_lessonnum == null) {
			if (other.co_lessonnum != null)
				return false;
		} else if (!co_lessonnum.equals(other.co_lessonnum))
			return false;
		if (co_margin == null) {
			if (other.co_margin != null)
				return false;
		} else if (!co_margin.equals(other.co_margin))
			return false;
		if (co_name == null) {
			if (other.co_name != null)
				return false;
		} else if (!co_name.equals(other.co_name))
			return false;
		if (co_occupy == null) {
			if (other.co_occupy != null)
				return false;
		} else if (!co_occupy.equals(other.co_occupy))
			return false;
		if (co_place == null) {
			if (other.co_place != null)
				return false;
		} else if (!co_place.equals(other.co_place))
			return false;
		if (co_profession == null) {
			if (other.co_profession != null)
				return false;
		} else if (!co_profession.equals(other.co_profession))
			return false;
		if (co_state == null) {
			if (other.co_state != null)
				return false;
		} else if (!co_state.equals(other.co_state))
			return false;
		if (co_teacher == null) {
			if (other.co_teacher != null)
				return false;
		} else if (!co_teacher.equals(other.co_teacher))
			return false;
		if (co_tedepart == null) {
			if (other.co_tedepart != null)
				return false;
		} else if (!co_tedepart.equals(other.co_tedepart))
			return false;
		if (co_type == null) {
			if (other.co_type != null)
				return false;
		} else if (!co_type.equals(other.co_type))
			return false;
		if (co_weekday == null) {
			if (other.co_weekday != null)
				return false;
		} else if (!co_weekday.equals(other.co_weekday))
			return false;
		if (co_weeks == null) {
			if (other.co_weeks != null)
				return false;
		} else if (!co_weeks.equals(other.co_weeks))
			return false;
		return true;
	}

}
