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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.id0304.ssy.pojo.Course;
import com.id0304.ssy.pojo.Dictionary;
import com.id0304.ssy.pojo.User;
import com.id0304.ssy.service.ClassGroupService;
import com.id0304.ssy.service.CourseService;
import com.id0304.ssy.service.DictionaryService;
import com.id0304.ssy.service.LessonService;

@Controller
public class CourseController {
	@Autowired
	private CourseService courseService;
	@Autowired
	private LessonService lessonService;
	@Autowired
	private DictionaryService dictionaryService;
	@Autowired
	private ClassGroupService classGroupService;

	@RequestMapping("/course/selectCourseByType.action")
	public String selectCourseByType(@RequestParam("u_id") String u_id,
			HttpServletRequest request, Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			List<Dictionary> dicDepartList = dictionaryService
					.selectDicByType(0);
			List<Dictionary> dicLessonList = dictionaryService
					.selectDicByType(1);
			String co_type = request.getParameter("selectType");
			String co_tedepart = request.getParameter("selectTeDepart");
			String co_margin = request.getParameter("ifContent");
			String findText = request.getParameter("findText");

			if (co_type.equals("-类型-"))
				co_type = "1=1";
			else
				co_type = "co_type = '" + co_type + "'";

			if (co_tedepart.equals("-开课学院-"))
				co_tedepart = "1=1";
			else
				co_tedepart = "co_tedepart ='" + co_tedepart + "'";

			if (co_margin.equals("-有无余量-"))
				co_margin = "1=1";
			else if (co_margin.equals("有"))
				co_margin = "co_occupy < co_content";
			else if (co_margin.equals("无"))
				co_margin = "co_occupy >= co_content";

			Pattern pattern = Pattern.compile("[0-9]*");
			Matcher isNum = pattern.matcher(findText);
			if (findText.equals("") || null == findText)
				findText = "1=1";
			else if (!isNum.matches())
				findText = "co_name like '%" + findText + "%'";
			else
				findText = "co_id = " + findText;

			List<Integer> lessonCoidList = lessonService
					.selectLessonCoidByUid(u_id);
			String lesson = "";
			for (Integer integer : lessonCoidList) {
				lesson = lesson + " and co_id!=" + integer;
			}
			Course course = new Course();
			course.setCo_grade(user.getU_level());
			course.setCo_depart(user.getU_depart());
			course.setCo_profession(user.getU_profession());
			course.setCo_type(co_type);
			course.setCo_tedepart(co_tedepart);
			course.setCo_margin(co_margin);
			course.setCo_name(findText);
			List<Course> courseList = courseService.selectCourseByCourse(
					course, lesson);

			String[] teacherArray = new String[courseList.size()];
			int count = 0;
			for (Course courses : courseList) {
				teacherArray[count++] = courses.getUser().getU_name();
			}
			count = 0;

			model.addAttribute("user", user);
			model.addAttribute("courseList", courseList);
			model.addAttribute("teacherArray", teacherArray);
			model.addAttribute("dicLessonList", dicLessonList);
			model.addAttribute("dicDepartList", dicDepartList);
			return "forward:/jsp/student/selectclass_s.jsp";
		}
		return null;
	}
	
	//学生--选课
	@RequestMapping("/course/selectCourse.action")
	public void selectCourse(String co_id, String userid,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session, ModelMap model) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(userid)) {
			Course course = courseService.selectCourseById(Integer
					.parseInt(co_id));
			Boolean isfull = lessonService.selectLessonIsfull(userid, course);
			if (course.getCo_content() <= course.getCo_occupy()) {
				// 容量不足
//				model.put("data", 1);
				response.getWriter().write(1);
			}
			if (isfull) {
				// 课表占用
//				model.put("data", 0);
				response.getWriter().write(0);
			}
			if (!isfull && course.getCo_content() > course.getCo_occupy()) {
				lessonService.insertLessonByUidAndCoid(userid, co_id);
				classGroupService.insertCGroupByUidAndCoid(userid, co_id);
				courseService.updateContentById(course.getCo_id());
//				model.put("data", 2);
				response.getWriter().write(2);
			}
		} else {
			response.sendRedirect("/sams/login.jsp");
		}
	}

	@RequestMapping("/classtable/selectOthersClassTable.action")
	public String selectOthersClassTable(String userid, String findtext,
			HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(userid)) {
			Pattern pattern = Pattern.compile("[0-9]*");
			Matcher isNum = pattern.matcher(findtext);
			if (findtext.equals("") || null == findtext || !isNum.matches()) {
				response.getWriter().print(0);
				return null;
			} else {
				List<Course> courseList = new ArrayList<Course>();
				courseList = courseService.seletCourseByTeId(findtext);
				if (courseList.size() <= 0) {
					response.getWriter().print(1);
					return null;
				}
				String[][] lessontable = new String[5][7];
				for (Course course : courseList) {
					switch (course.getCo_lessonnum()) {
					case 12:
						lessontable[0][course.getCo_weekday() - 1] = course
								.getCo_id()
								+ " "
								+ course.getCo_name()
								+ " 上课地点:" + course.getCo_place();
						break;
					case 34:
						lessontable[1][course.getCo_weekday() - 1] = course
								.getCo_id()
								+ " "
								+ course.getCo_name()
								+ " 上课地点:" + course.getCo_place();
						break;
					case 56:
						lessontable[2][course.getCo_weekday() - 1] = course
								.getCo_id()
								+ " "
								+ course.getCo_name()
								+ " 上课地点:" + course.getCo_place();
						break;
					case 78:
						lessontable[3][course.getCo_weekday() - 1] = course
								.getCo_id()
								+ " "
								+ course.getCo_name()
								+ " 上课地点:" + course.getCo_place();
						break;
					case 910:
						lessontable[4][course.getCo_weekday() - 1] = course
								.getCo_id()
								+ " "
								+ course.getCo_name()
								+ " 上课地点:" + course.getCo_place();
						break;
					}
				}
				model.addAttribute("lessontable", lessontable);

				return "forward:/jsp/teacher/classtable_t.jsp";
			}
		}
		return "redirect:/login.jsp";
	}

	@RequestMapping("/course/managelessonfind.action")
	public void manageLessonFind(String selecttype, String findtext,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session, ModelMap model) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			if (selecttype.equals("-课程类型-"))
				selecttype = "";
			else
				selecttype = "and co.co_type = '" + selecttype + "'";
			Pattern pattern = Pattern.compile("[0-9]*");
			Matcher isNum = pattern.matcher(findtext);
			if (null == findtext || findtext.equals("")) {
				findtext = "";
			} else if (isNum.matches()) {
				findtext = "and (co.co_id = " + findtext + " or u.u_id = '"
						+ findtext + "')";
			} else {
				findtext = "and (co.co_name like '%" + findtext
						+ "%' or u.u_name like '%" + findtext + "%')";
			}
			Course course = new Course();
			course.setCo_type(selecttype);
			course.setCo_margin(findtext);
			course.setCo_depart(user.getU_depart());
			List<Course> courseList = courseService
					.selectCourseByCoTypeAndOrders(course);
			JSONArray jsonArray = JSONArray.fromObject(courseList);
			String json = jsonArray.toString();
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().write(json);
		} else {
			response.sendRedirect("/sams/login.jsp");
		}
	}

	// 教学秘书--根据co_id查询课程详情
	@RequestMapping("/course/showcourse.action")
	public void showCourse(String co_id, HttpSession session,
			HttpServletRequest request, HttpServletResponse response,
			Model model) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			Course course = courseService.selectCourseById(Integer
					.parseInt(co_id));
			if (null != course
					&& !course.getCo_tedepart().equals(user.getU_depart())) {
				course = null;
			}
			if (null == course) {
				response.getWriter().print(0);
			} else {
				response.setContentType("text/html;charset=utf-8");
				JSONObject jsonObject = JSONObject.fromObject(course);
				String json = jsonObject.toString();
				response.getWriter().write(json);
			}
		} else {
			response.sendRedirect("/sams/login.jsp");
		}
	}

	// 教师--查看其它教师课表
	@RequestMapping("/course/findclasstable.action")
	public void findClassTable(String findtext, HttpSession session,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			Pattern pattern = Pattern.compile("[0-9]*");
			Matcher isNum = pattern.matcher(findtext);
			if (!isNum.matches())
				response.getWriter().print(0);
			else {
				// List<Lesson> lessonList = lessonService
				// .sele
				List<Course> courseList = courseService
						.seletCourseByTeId(findtext);
				String[][] lessontable = new String[5][7];
				for (int i = 0; i < 5; ++i)
					for (int j = 0; j < 7; ++j)
						lessontable[i][j] = "";
				for (Course course : courseList) {
					switch (course.getCo_lessonnum()) {
					case 12:
						lessontable[0][course.getCo_weekday() - 1] = course
								.getCo_id()
								+ " "
								+ course.getCo_name()
								+ " 上课地点:"
								+ course.getCo_place()
								+ " 上课时间:"
								+ course.getCo_weeks()
								+ ",周"
								+ course.getCo_weekday()
								+ ",第"
								+ course.getCo_lessonnum() + "节";
						break;
					case 34:
						lessontable[1][course.getCo_weekday() - 1] = course
								.getCo_id()
								+ " "
								+ course.getCo_name()
								+ " 上课地点:"
								+ course.getCo_place()
								+ " 上课时间:"
								+ course.getCo_weeks()
								+ ",周"
								+ course.getCo_weekday()
								+ ",第"
								+ course.getCo_lessonnum() + "节";
						break;
					case 56:
						lessontable[2][course.getCo_weekday() - 1] = course
								.getCo_id()
								+ " "
								+ course.getCo_name()
								+ " 上课地点:"
								+ course.getCo_place()
								+ " 上课时间:"
								+ course.getCo_weeks()
								+ ",周"
								+ course.getCo_weekday()
								+ ",第"
								+ course.getCo_lessonnum() + "节";
						break;
					case 78:
						lessontable[3][course.getCo_weekday() - 1] = course
								.getCo_id()
								+ " "
								+ course.getCo_name()
								+ " 上课地点:"
								+ course.getCo_place()
								+ " 上课时间:"
								+ course.getCo_weeks()
								+ ",周"
								+ course.getCo_weekday()
								+ ",第"
								+ course.getCo_lessonnum() + "节";
						break;
					case 910:
						lessontable[4][course.getCo_weekday() - 1] = course
								.getCo_id()
								+ " "
								+ course.getCo_name()
								+ " 上课地点:"
								+ course.getCo_place()
								+ " 上课时间:"
								+ course.getCo_weeks()
								+ ",周"
								+ course.getCo_weekday()
								+ ",第"
								+ course.getCo_lessonnum() + "节";
						break;
					}
				}
				response.setContentType("text/html;charset=utf-8");
				JSONArray jsonArray = JSONArray.fromObject(lessontable);
				String json = jsonArray.toString();
				response.getWriter().write(json);
			}
		} else
			response.sendRedirect("/sams/login.jsp");
	}
}
