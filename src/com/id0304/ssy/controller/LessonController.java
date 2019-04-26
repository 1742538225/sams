package com.id0304.ssy.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.id0304.ssy.pojo.ClassRoom;
import com.id0304.ssy.pojo.Course;
import com.id0304.ssy.pojo.Lesson;
import com.id0304.ssy.pojo.User;
import com.id0304.ssy.service.CourseService;
import com.id0304.ssy.service.LessonService;
import com.id0304.ssy.service.UserService;

@Controller
public class LessonController {
	@Autowired
	private LessonService lessonService;

	@Autowired
	private CourseService courseService;

	@Autowired
	private UserService userService;

	@RequestMapping("/score/updatescore.action")
	public void updateScore(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap model)
			throws IOException {
		User user = (User) session.getAttribute("user");
		String userid = request.getParameter("userid");
		if (null != user && user.getU_id().equals(userid)) {
			String u_id = request.getParameter("u_id");
			String co_id = request.getParameter("co_id");
			String score = request.getParameter("score");
			lessonService.updateScoreByUidAndCoid(u_id, co_id, score);
			response.getWriter().print(1);
		} else {
			response.sendRedirect("/login.jsp");
		}
	}

	@RequestMapping("/classroom/selectLessonbycondition.action")
	public String selectLessonByCondition(@RequestParam("u_id") String u_id,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		String selectCoid = request.getParameter("selectCoid");
		String findText = request.getParameter("findText");

		if (null != user && user.getU_id().equals(u_id)) {
			List<Course> courseList = courseService.seletCourseByTeId(u_id);
			String coId = "";
			String uId = "";
			if (selectCoid.equals("-选择课程号-") || null == selectCoid)
				for (Course course : courseList) {
					coId = coId + " l.l_co_id =" + course.getCo_id() + " or";
				}
			else
				coId = " l.l_co_id=" + selectCoid + " or";
			Pattern pattern = Pattern.compile("[0-9]*");
			Matcher isNum = pattern.matcher(findText);
			if (!findText.equals("") && null != findText) {
				if (isNum.matches())
					uId = " l.l_u_id = " + findText;
				else
					uId = " u.u_name like " + " '%" + findText + "%' ";
			} else {
				uId = "1=1";
			}
			List<Lesson> lessonList = lessonService
					.selectLessonAndStuByCondition(coId, uId);
			User[] student = new User[lessonList.size()];
			Course[] course = new Course[lessonList.size()];
			int i = 0;
			for (Lesson lesson : lessonList) {
				student[i] = lesson.getUser();
				course[i++] = lesson.getCourse();
			}

			model.addAttribute("user", user);
			model.addAttribute("student", student);
			model.addAttribute("course", course);
			model.addAttribute("courseList", courseList);
			model.addAttribute("lessonList", lessonList);

			return "forward:/jsp/teacher/recordscore_t.jsp";
		}
		return "redirect:/login.jsp";
	}

	@RequestMapping("/rollbook/selectrollbook.action")
	public void selectRollBook(String co_id, String u_id,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) throws IOException {
		User user = (User) session.getAttribute("user");

		if (null != user && user.getU_id().equals(u_id)) {
			List<Lesson> lessonList = lessonService
					.selectStuAndLessonAndByCoId(Integer.parseInt(co_id));
			List<User> stuList = new ArrayList<User>();
			for (Lesson lesson : lessonList) {
				stuList.add(lesson.getUser());
			}

			JSONArray jsonArray = JSONArray.fromObject(stuList);
			String json = jsonArray.toString();

			response.setContentType("text/html;charset=utf-8");
			response.getWriter().write(json);
		} else {
			response.sendRedirect("/sams/login.jsp");
		}
	}

	@RequestMapping("/lesson/loadstudent.action")
	public void selectLoadStudent(String p_name, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			List<User> studentsList = userService
					.selectStudentByProfession(p_name);
			JSONArray jsonArray = JSONArray.fromObject(studentsList);
			String json = jsonArray.toString();
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().write(json);
		} else {
			response.sendRedirect("/sams/login.jsp");
		}
	}

	@RequestMapping("/lesson/selectlessontablebyuid.action")
	public void selectLessonTableByUid(String u_id, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			List<Lesson> lessonList = lessonService
					.selectLessonAndCoByUid(u_id);
			String[][] lessonArray = new String[5][7];
			for (int i = 0; i < 5; ++i)
				for (int j = 0; j < 7; ++j)
					lessonArray[i][j] = "";
			for (Lesson lesson : lessonList) {
				switch (lesson.getCourse().getCo_lessonnum()) {
				case 12:
					lessonArray[0][lesson.getCourse().getCo_weekday() - 1] = lesson
							.getCourse().getCo_id()
							+ " "
							+ lesson.getCourse().getCo_name()
							+ " 上课地点:"
							+ lesson.getCourse().getCo_place()
							+ " 上课时间:"
							+ lesson.getCourse().getCo_weeks()
							+ ",周"
							+ lesson.getCourse().getCo_weekday()
							+ ",第"
							+ lesson.getCourse().getCo_lessonnum() + "节";
					break;
				case 34:
					lessonArray[1][lesson.getCourse().getCo_weekday() - 1] = lesson
							.getCourse().getCo_id()
							+ " "
							+ lesson.getCourse().getCo_name()
							+ " 上课地点:"
							+ lesson.getCourse().getCo_place()
							+ " 上课时间:"
							+ lesson.getCourse().getCo_weeks()
							+ ",周"
							+ lesson.getCourse().getCo_weekday()
							+ ",第"
							+ lesson.getCourse().getCo_lessonnum() + "节";
					break;
				case 56:
					lessonArray[2][lesson.getCourse().getCo_weekday() - 1] = lesson
							.getCourse().getCo_id()
							+ " "
							+ lesson.getCourse().getCo_name()
							+ " 上课地点:"
							+ lesson.getCourse().getCo_place()
							+ " 上课时间:"
							+ lesson.getCourse().getCo_weeks()
							+ ",周"
							+ lesson.getCourse().getCo_weekday()
							+ ",第"
							+ lesson.getCourse().getCo_lessonnum() + "节";
					break;
				case 78:
					lessonArray[3][lesson.getCourse().getCo_weekday() - 1] = lesson
							.getCourse().getCo_id()
							+ " "
							+ lesson.getCourse().getCo_name()
							+ " 上课地点:"
							+ lesson.getCourse().getCo_place()
							+ " 上课时间:"
							+ lesson.getCourse().getCo_weeks()
							+ ",周"
							+ lesson.getCourse().getCo_weekday()
							+ ",第"
							+ lesson.getCourse().getCo_lessonnum() + "节";
					break;
				case 910:
					lessonArray[4][lesson.getCourse().getCo_weekday() - 1] = lesson
							.getCourse().getCo_id()
							+ " "
							+ lesson.getCourse().getCo_name()
							+ " 上课地点:"
							+ lesson.getCourse().getCo_place()
							+ " 上课时间:"
							+ lesson.getCourse().getCo_weeks()
							+ ",周"
							+ lesson.getCourse().getCo_weekday()
							+ ",第"
							+ lesson.getCourse().getCo_lessonnum() + "节";
					break;
				}
			}
			JSONArray jsonArray = JSONArray.fromObject(lessonArray);
			String json = jsonArray.toString();
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().write(json);
		} else {
			response.sendRedirect("/sams/login.jsp");
		}
	}

	@RequestMapping("/lesson/addlesson.action")
	public void addLesson(@RequestBody JSONObject jsonObject,
			HttpSession session, HttpServletResponse response,
			HttpServletRequest request) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			Lesson lesson = (Lesson) jsonObject
					.toBean(jsonObject, Lesson.class);
			lessonService.insertLessonByLesson(lesson);
			response.getWriter().print(1);
		} else {
			response.sendRedirect("/sams/login.jsp");
		}
	}

	@RequestMapping("/lesson/reviewscore.action")
	public void reviewScore(String l_id, HttpServletResponse response,
			HttpSession session) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			Lesson lesson = lessonService.selectLessonById(Integer
					.parseInt(l_id));
			response.setContentType("text/html;charset=utf-8");
			JSONObject jsonObject = JSONObject.fromObject(lesson);
			String json = jsonObject.toString();
			response.getWriter().write(json);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--修改课程成绩信息
	@RequestMapping("/lesson/modifyscore.action")
	public void modifyScore(@RequestBody JSONObject jsonObject,
			HttpServletResponse response, HttpSession session)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			Lesson lesson = (Lesson) jsonObject
					.toBean(jsonObject, Lesson.class);
			if (null == lesson.getL_co_id() || null == lesson.getL_u_id()
					|| lesson.getL_co_id().equals("")
					|| lesson.getL_u_id().equals("")) {
				return;
			} else
				lessonService.updateLesson(lesson);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--删除课程成绩
	@RequestMapping("/lesson/deletescore.action")
	public void deleteScore(String l_id, HttpServletResponse response,
			HttpSession session) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			lessonService.deleteLessonById(Integer.parseInt(l_id));
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--通过条件查询课程
	@RequestMapping("/lesson/selectlessonbycondition.action")
	public void selectLessonByCondition(String findtext, String selectdepart,
			String selectlevel, HttpServletResponse response,
			HttpSession session) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			if (!findtext.equals(""))
				findtext = "and (l.l_co_id = " + findtext + " or l.l_u_id = '"
						+ findtext + "')";
			else
				findtext = "";
			if (!selectdepart.equals("-选择学院-"))
				selectdepart = "and u.u_depart = '" + selectdepart + "'";
			else
				selectdepart = "";
			if (!selectlevel.equals("-选择年级-"))
				selectlevel = "and u.u_level = '" + selectlevel + "'";
			else
				selectlevel = "";
			List<Lesson> lessonList = lessonService.selectLessonByCondition(
					findtext, selectdepart, selectlevel, 0, 12);
			JSONArray jsonArray = JSONArray.fromObject(lessonList);
			response.setContentType("text/html;charset=utf-8");
			String json = jsonArray.toString();
			response.getWriter().write(json);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--跳页查询课程信息
	@RequestMapping("/lesson/lessonchangepage.action")
	public void lessonChangePage(String findtext, String selectdepart,
			String selectlevel, String page, HttpServletResponse response,
			HttpSession session, HttpServletRequest request) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			if (!findtext.equals(""))
				findtext = "and (l.l_co_id = " + findtext + " or l.l_u_id = '"
						+ findtext + "')";
			else
				findtext = "";
			if (!selectdepart.equals("-选择学院-"))
				selectdepart = "and u.u_depart = '" + selectdepart + "'";
			else
				selectdepart = "";
			if (!selectlevel.equals("-选择年级-"))
				selectlevel = "and u.u_level = '" + selectlevel + "'";
			else
				selectlevel = "";
			List<Lesson> lessonList = lessonService.selectLessonByCondition(
					findtext, selectdepart, selectlevel, Integer.parseInt(page)-1, 12);
			response.setContentType("text/html;charset=utf-8");
			JSONArray jsonArray = JSONArray.fromObject(lessonList);
			String json = jsonArray.toString();
			response.getWriter().write(json);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

}
