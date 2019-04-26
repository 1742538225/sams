package com.id0304.ssy.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.JSONUtils;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.id0304.ssy.pojo.ClassRoom;
import com.id0304.ssy.pojo.Course;
import com.id0304.ssy.pojo.Dictionary;
import com.id0304.ssy.pojo.Lesson;
import com.id0304.ssy.pojo.Message;
import com.id0304.ssy.pojo.Profession;
import com.id0304.ssy.pojo.User;
import com.id0304.ssy.service.ClassRoomService;
import com.id0304.ssy.service.CourseService;
import com.id0304.ssy.service.DictionaryService;
import com.id0304.ssy.service.LessonService;
import com.id0304.ssy.service.MessageService;
import com.id0304.ssy.service.ProfessionService;
import com.id0304.ssy.service.UserService;
import com.id0304.ssy.util.JsonDateValueProcessor;

@Controller
public class UserController {
	@Autowired
	private UserService userService;

	@Autowired
	private CourseService courseService;

	@Autowired
	private LessonService lessonService;

	@Autowired
	private DictionaryService dictionaryService;

	@Autowired
	private ClassRoomService classRoomService;

	@Autowired
	private ProfessionService professionService;

	@Autowired
	private MessageService messageService;

	// 用户名存在异步查询
	@RequestMapping(value = "/user/selectId.action")
	public void selectUserById(String userId, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		User user = userService.selectUserById(userId);
		if (null != user) {
			response.getWriter().print(1);
		} else {
			response.getWriter().print(0);
		}
	}

	// 登录页异步查询
	@RequestMapping(value = "/user/checklogin.action")
	public void selectUserByIdAndPw(String userId, String password,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws IOException {
		User user = new User();
		user.setU_id(userId);
		user.setU_password(password);
		User userLogin = userService.selectLoginUser(user);
		if (null != userLogin) {
			response.getWriter().print(1);
		} else {
			response.getWriter().print(0);
		}
	}

	// 登陆页跳转
	@RequestMapping(value = "/user/login.action")
	public String selectByUser(User user, Model model, HttpSession session,
			HttpServletRequest request) throws IOException {
		User userLogin = userService.selectLoginUser(user);
		session.setAttribute("user", userLogin);
		model.addAttribute("user", userLogin);
		request.setAttribute("uid", userLogin.getU_id());

		if (userLogin.getU_identify() == 0) {
			return "forward:/index_s.jsp?u_id=" + userLogin.getU_id();
		} else if (userLogin.getU_identify() == 1) {
			return "forward:/index_t.jsp?u_id=" + userLogin.getU_id();
		} else if (userLogin.getU_identify() == 2) {
			return "forward:/index_ts.jsp?u_id=" + userLogin.getU_id();
		} else {
			return "forward:/index_m.jsp?u_id=" + userLogin.getU_id();
		}
	}

	// 注销
	@RequestMapping("/user/loginUI.action")
	public String loginUI(HttpSession session) {
		session.invalidate();
		return "redirect:/login.jsp";
	}

	// 学生端 首页跳转
	@RequestMapping(value = "/user/index_s.action")
	public String selectIndex_sById(@RequestParam("u_id") String u_id,
			Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user.getU_id().equals(u_id)) {
			return "forward:/index_s.jsp";
		}
		return "redirect:/login.jsp";
	}

	// 学生端 个人信息页面跳转
	@RequestMapping(value = "/user/individual_s.action")
	public String selectIndividualById(@RequestParam("u_id") String u_id,
			Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			model.addAttribute("user", user);
			return "forward:/jsp/student/individual_s.jsp";
		}
		return "redirect:/login.jsp";
	}

	// 学生端 成绩查询页面跳转
	@RequestMapping("/user/score_s.action")
	public String selectScore(@RequestParam("u_id") String u_id,
			HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			List<Lesson> lessonList = lessonService
					.selectLessonAndCoByUid(u_id);
			Course[] courses = new Course[lessonList.size()];
			int i = 0;
			for (Lesson lesson : lessonList) {
				courses[i++] = lesson.getCourse();
			}
			model.addAttribute("user", user);
			model.addAttribute("lessonList", lessonList);
			model.addAttribute("courses", courses);
			return "forward:/jsp/student/score_s.jsp";
		}
		return "redirect:/login.jsp";
	}

	// 学生端 课表查询页面跳转
	@RequestMapping(value = "/user/classtable_s.action")
	public String selectClassTable_sById(@RequestParam("u_id") String u_id,
			Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			model.addAttribute("user", user);
			List<Lesson> lessonList = lessonService.selectLessonByUid(u_id);
			List<Course> courseList = new ArrayList<Course>();
			String teacher = "";
			for (Lesson lesson : lessonList) {
				courseList.add(courseService.selectCourseById(lesson
						.getL_co_id()));
			}
			String[][] lessontable = new String[5][7];
			for (Course course : courseList) {
				teacher = userService.selectUserById(course.getCo_teacher())
						.getU_name();
				switch (course.getCo_lessonnum()) {
				case 12:
					lessontable[0][course.getCo_weekday() - 1] = course
							.getCo_id()
							+ " "
							+ course.getCo_name()
							+ " 上课地点:"
							+ course.getCo_place() + " 任课教师:" + teacher;
					break;
				case 34:
					lessontable[1][course.getCo_weekday() - 1] = course
							.getCo_id()
							+ " "
							+ course.getCo_name()
							+ " 上课地点:"
							+ course.getCo_place() + " 任课教师:" + teacher;
					break;
				case 56:
					lessontable[2][course.getCo_weekday() - 1] = course
							.getCo_id()
							+ " "
							+ course.getCo_name()
							+ " 上课地点:"
							+ course.getCo_place() + " 任课教师:" + teacher;
					break;
				case 78:
					lessontable[3][course.getCo_weekday() - 1] = course
							.getCo_id()
							+ " "
							+ course.getCo_name()
							+ " 上课地点:"
							+ course.getCo_place() + " 任课教师:" + teacher;
					break;
				case 910:
					lessontable[4][course.getCo_weekday() - 1] = course
							.getCo_id()
							+ " "
							+ course.getCo_name()
							+ " 上课地点:"
							+ course.getCo_place() + " 任课教师:" + teacher;
					break;
				}
			}
			model.addAttribute("lessontable", lessontable);
			return "forward:/jsp/student/classtable_s.jsp";
		}
		return "redirect:/login.jsp";
	}

	// 学生端 选课页面跳转
	@RequestMapping(value = "/user/selectclass_s.action")
	public String selectSelectClass_sById(@RequestParam("u_id") String u_id,
			Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			List<Dictionary> dicDepartList = dictionaryService
					.selectDicByType(0);
			List<Dictionary> dicLessonList = dictionaryService
					.selectDicByType(1);
			List<Integer> lessonCoidList = lessonService
					.selectLessonCoidByUid(u_id);
			String lesson = "";
			for (Integer integer : lessonCoidList) {
				lesson = lesson + " and co_id!=" + integer;
			}

			List<Course> courseList = courseService
					.selectCourseByDepartAndProfession(user, lesson);
			String[] teacherArray = new String[courseList.size()];
			int count = 0;
			for (Course course : courseList) {
				teacherArray[count++] = course.getUser().getU_name();
			}
			count = 0;

			model.addAttribute("user", user);
			model.addAttribute("courseList", courseList);
			model.addAttribute("teacherArray", teacherArray);
			model.addAttribute("dicDepartList", dicDepartList);
			model.addAttribute("dicLessonList", dicLessonList);
			return "forward:/jsp/student/selectclass_s.jsp";
		}
		return "redirect:/login.jsp";
	}

	// 学生端 评教系统页面跳转
	@RequestMapping(value = "/user/evaluate_s.action")
	public String selectEvaluate_sById(@RequestParam("u_id") String u_id,
			Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			List<Lesson> lessonList = lessonService
					.selectLessonAndCoByUid(u_id);
			List<User> teacherList = new ArrayList<User>();
			String[] courseName = new String[lessonList.size()];
			Integer[] courseId = new Integer[lessonList.size()];
			int i = 0;
			for (Lesson lesson : lessonList) {
				courseName[i] = lesson.getCourse().getCo_name();
				courseId[i++] = lesson.getCourse().getCo_id();
				teacherList.add(userService.selectTeacherById(lesson
						.getCourse().getCo_teacher()));
			}
			model.addAttribute("courseName", courseName);
			model.addAttribute("courseId", courseId);
			model.addAttribute("teacherList", teacherList);
			model.addAttribute("user", user);
			return "forward:/jsp/student/evaluate_s.jsp";
		}
		return "redirect:/login.jsp";
	}

	// 学生--评教结果提交
	@RequestMapping("/user/evaluatesubmit.action")
	public void evaluateSubmit(String co_id, String evaluatebody, Model model,
			HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			lessonService.updateEvaluate(user.getU_id(),
					Integer.parseInt(co_id), evaluatebody);
		} else {
			response.sendRedirect("/sams/login.jsp");
		}
	}

	// 教师端 主页
	@RequestMapping(value = "/user/index_t.action")
	public String selectIndex_t(@RequestParam("u_id") String u_id, Model model,
			HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			model.addAttribute("user", user);
			return "forward:/index_t.jsp";
		}
		return "redirect:/login.jsp";
	}

	// 教师端 个人信息页面跳转
	@RequestMapping(value = "/user/individual_t.action")
	public String selectIndividual_t(@RequestParam("u_id") String u_id,
			Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			model.addAttribute("user", user);
			return "forward:/jsp/teacher/individual_t.jsp";
		}
		return "redirect:/login.jsp";
	}

	// 教师端 教室使用情况页面跳转
	@RequestMapping(value = "/user/classroom_t.action")
	public String selectClassRoom_t(@RequestParam("u_id") String u_id,
			Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			model.addAttribute("user", user);
			List<ClassRoom> cRoomList = classRoomService.selectAllClassRoom();
			List<Course> courseList = new ArrayList<Course>();
			for (ClassRoom classRoom : cRoomList) {
				courseList.add(classRoom.getCourse());
			}
			model.addAttribute("cRoomList", cRoomList);
			model.addAttribute("courseList", courseList);
			return "forward:/jsp/teacher/classroom_t.jsp";
		}
		return "redirect:/login.jsp";
	}

	// 教师课表页面跳转
	@RequestMapping("/user/classtable_t.action")
	public String selectClassTable(@RequestParam("u_id") String u_id,
			Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			model.addAttribute("user", user);

			List<Course> courseList = courseService.seletCourseByTeId(u_id);
			String[][] lessontable = new String[5][7];
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
			model.addAttribute("lessontable", lessontable);
			return "forward:/jsp/teacher/classtable_t.jsp";
		}
		return "redirect:/login.jsp";
	}

	// 教师点名册页面跳转
	@RequestMapping(value = "/user/rollbook_t.action")
	public String selectRollBook_t(@RequestParam("u_id") String u_id,
			Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			List<Course> courseList = courseService.seletCourseByTeId(u_id);
			model.addAttribute("courseList", courseList);
			return "forward:/jsp/teacher/rollbook_t.jsp";

		}
		return "redirect:/login.jsp";
	}

	// 教师--修改个人信息弹窗
	@RequestMapping("/user/modifyindividual.action")
	public void modifyIndividual(String p_id, Model model, HttpSession session,
			HttpServletResponse response) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			response.setContentType("text/html;charset=utf-8");
			JsonConfig jsonConfig = new JsonConfig();
			jsonConfig.registerJsonValueProcessor(Date.class,
					new JsonDateValueProcessor());
			JSONObject jsonObject = JSONObject.fromObject(user, jsonConfig);
			String json = jsonObject.toString();
			response.getWriter().write(json);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 教师--修改个人信息
	@RequestMapping("/user/modifyindividualsubmit.action")
	public void modifyIndividualSubmit(@RequestBody JSONObject jsonObject,
			Model model, HttpSession session, HttpServletResponse response)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			User userNew = (User) jsonObject.toBean(jsonObject, User.class);
			userNew.setU_id(user.getU_id());
			userNew.setU_password(user.getU_password());
			userNew.setU_identify(user.getU_identify());
			userNew.setU_level(user.getU_level());
			userNew.setU_teage(user.getU_teage());
			userNew.setU_depart(user.getU_depart());
			userNew.setU_profession(user.getU_profession());
			userNew.setU_class(user.getU_class());
			userNew.setU_enrolment(user.getU_enrolment());
			userNew.setU_tuition(user.getU_tuition());
			userNew.setU_detail(user.getU_detail());
			userNew.setU_post(user.getU_post());
			userService.updateUserByUser(userNew);
			response.getWriter().write("修改成功");
			session.setAttribute("user", userNew);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	@RequestMapping("/user/recordscore_t.action")
	public String insertScore(@RequestParam("u_id") String u_id, Model model,
			HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			List<Course> courseList = courseService.seletCourseByTeId(u_id);
			String coId = "";
			for (Course course : courseList) {
				coId = coId + " l_co_id =" + course.getCo_id() + " or";
			}
			List<Lesson> lessonList = lessonService
					.selectLessonAndStuByCoid(coId);
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

	// 教学秘书主页跳转
	@RequestMapping("/user/index_ts.action")
	public String selectIndex_tsById(@RequestParam("u_id") String u_id,
			Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			model.addAttribute("user", user);
			return "forward:/index_ts.jsp";
		}
		return "redirect:/login.jsp";
	}

	// 教学秘书个人信息页面跳转
	@RequestMapping("/user/individual_ts.action")
	public String selectIndividual_tsById(@RequestParam("u_id") String u_id,
			Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			model.addAttribute("user", user);
			return "forward:/jsp/teachingSecretary/individual_ts.jsp";
		}
		return "redirect:/login.jsp";
	}

	// 教学秘书管理本系课程
	@RequestMapping("/user/managelesson_ts.action")
	public String selectManageLesson_tsById(@RequestParam("u_id") String u_id,
			Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			List<Course> courseList = courseService.selectCourseByDepart(user
					.getU_depart());
			String[] teacher = new String[courseList.size()];
			int i = 0;
			for (Course course : courseList) {
				teacher[i++] = course.getUser().getU_name();
			}
			List<Dictionary> dicDepartList = dictionaryService
					.selectDicByType(1);
			model.addAttribute("dicDepartList", dicDepartList);
			model.addAttribute("courseList", courseList);
			model.addAttribute("teacher", teacher);
			return "forward:/jsp/teachingSecretary/managelesson_ts.jsp";

		}
		return "redirect:/login.jsp";
	}

	@RequestMapping("/user/outclasstable_ts.action")
	public String selectOutClassTable_tsById(@RequestParam("u_id") String u_id,
			Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			List<Profession> professionList = professionService
					.selectProfessionByPdepart(user.getU_depart());
			model.addAttribute("professionList", professionList);

			return "forward:/jsp/teachingSecretary/outclasstable_ts.jsp";
		}
		return "redirect:/login.jsp";
	}

	@RequestMapping("/user/manageactivity_ts.action")
	public String selectManageActivity_tsById(
			@RequestParam("u_id") String u_id, Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {

			return "forward:/jsp/teachingSecretary/manageactivity_ts.jsp";
		}
		return "redirect:/login.jsp";
	}

	// 教学秘书--教学活动申请
	@RequestMapping("/user/activitysubmit.action")
	public void activitySubmit(String nametext, String bodytext,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			Message message = new Message();
			message.setM_type("用户信息");
			message.setM_body("活动名称:" + nametext + "  活动内容:" + bodytext);
			message.setM_source(user.getU_id());
			message.setM_target("wuzhenghua");
			messageService.insertMessageByUid(message);
			response.getWriter().write(1);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--首页跳转
	@RequestMapping("/user/index_m.action")
	public String selectIndex_m(@RequestParam("u_id") String u_id, Model model,
			HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			return "forward:/index_m.jsp";
		}
		return "redirect:/login.jsp";
	}

	// 管理员--管理用户页面跳转
	@RequestMapping("/user/manageuser_m.action")
	public String selectManageUser_m(@RequestParam("u_id") String u_id,
			Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			List<User> userList = userService.selectAllUser(0, 12);
			List<Dictionary> dicList = dictionaryService.selectDicByType(0);
			Integer pagecount = (userList.size() - 1) / 12;
			model.addAttribute("dicList", dicList);
			model.addAttribute("userList", userList);
			model.addAttribute("pagecount", pagecount);
			return "forward:/jsp/manager/manageuser_m.jsp";
		}
		return "redirect:/login.jsp";
	}

	// 管理员--选择页数显示用户
	@RequestMapping("/user/selectuserbypagecount.action")
	public void selectUserByPageCount(String selectidentify,
			String selectdepart, String findtext, String pagecount,
			Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			String con = "";
			if (!selectidentify.equals("-身份-")) {
				switch (selectidentify) {
				case "0学生":
					con = "and u_identify = 0 ";
					break;
				case "1教师":
					con = "and u_identify = 1 ";
					break;
				case "2教学秘书":
					con = "and u_identify = 2 ";
					break;
				case "3管理员":
					con = "and u_identify = 3 ";
					break;
				}
			}
			if (!selectdepart.equals("-学院-")) {
				con = con + "and u_depart = '" + selectdepart + "' ";
			}
			if (null != findtext && findtext != "") {
				con = con + "and (u_id = " + findtext + " or u_name like '%"
						+ findtext + "%'";
			}
			List<User> userList = userService.selectUserByConfident(
					12 * (Integer.parseInt(pagecount) - 1), 12, con);
			response.setContentType("text/html;charset=utf-8");
			JSONArray jsonArray = JSONArray.fromObject(userList);
			String json = jsonArray.toString();
			response.getWriter().write(json);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--通过条件筛选用户
	@RequestMapping("/user/selectuserbycondition.action")
	public void selectUserByCondition(String selectidentify,
			String selectdepart, String findtext, Model model,
			HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			String con = "";
			if (!selectidentify.equals("-身份-")) {
				switch (selectidentify) {
				case "0学生":
					con = "and u_identify = 0 ";
					break;
				case "1教师":
					con = "and u_identify = 1 ";
					break;
				case "2教学秘书":
					con = "and u_identify = 2 ";
					break;
				case "3管理员":
					con = "and u_identify = 3 ";
					break;
				}
			}
			if (!selectdepart.equals("-学院-")) {
				con = con + "and u_depart = '" + selectdepart + "' ";
			}
			if (null != findtext && findtext != "") {
				Pattern pattern = Pattern.compile("[0-9]*");
				Matcher isNum = pattern.matcher(findtext);
				if (!isNum.matches())
					con = con + "and u_name like '%" + findtext + "%' ";
				else
					con = con + "and u_id = " + findtext + " ";
			}
			List<User> userList = userService.selectUserByConfident(0, 12, con);
			response.setContentType("text/html;charset=utf-8");
			JSONArray jsonArray = JSONArray.fromObject(userList);
			String json = jsonArray.toString();
			response.getWriter().write(json);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--修改用户信息弹窗回显
	@RequestMapping("/user/modifyuserdiv.action")
	public void modifyUserDiv(String u_id, Model model, HttpSession session,
			HttpServletResponse response) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			User userMessage = userService.selectUserById(u_id);
			response.setContentType("text/html;charset=utf-8");

			JsonConfig jsonConfig = new JsonConfig();
			jsonConfig.registerJsonValueProcessor(Date.class,
					new JsonDateValueProcessor());
			JSONObject jsonObject = JSONObject.fromObject(userMessage,
					jsonConfig);
			String json = jsonObject.toString();
			response.getWriter().write(json);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--修改用户信息
	@RequestMapping("/user/modifyuser.action")
	public void modifyUser(@RequestBody JSONObject jsonObject, Model model,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			String[] dateFormats = new String[] { "yyyy-MM-dd" };
			JSONUtils.getMorpherRegistry().registerMorpher(
					new DateMorpher(dateFormats));
			User userModify = (User) jsonObject.toBean(jsonObject, User.class);
			userService.updateUserByUser(userModify);
			response.getWriter().write("修改成功");
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--删除用户
	@RequestMapping("/user/deleteuser.action")
	public void deleteUser(String u_id, Model model, HttpSession session,
			HttpServletResponse response) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			userService.deleteUserByUid(u_id);
			response.getWriter().write(1);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--添加用户
	@RequestMapping("/user/adduser.action")
	public void addUser(@RequestBody JSONObject jsonObject, Model model,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			String[] dateFormats = new String[] { "yyyy-MM-dd" };
			JSONUtils.getMorpherRegistry().registerMorpher(
					new DateMorpher(dateFormats));
			User userAdd = (User) jsonObject.toBean(jsonObject, User.class);
			userService.insertUser(userAdd);

		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--跳转管理课程页面
	@RequestMapping("/user/managelesson_m.action")
	public String selectManageLesson_m(@RequestParam("u_id") String u_id,
			Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			List<Course> courseList = courseService.selectAllCourse(0, 12);
			List<Dictionary> lessontypeList = dictionaryService
					.selectDicByType(1);
			List<Dictionary> departList = dictionaryService.selectDicByType(0);
			List<Dictionary> levelList = dictionaryService.selectDicByType(3);
			Integer pagecount = (courseList.size() - 1) / 12;
			model.addAttribute("lessontypeList", lessontypeList);
			model.addAttribute("departList", departList);
			model.addAttribute("levelList", levelList);
			model.addAttribute("courseList", courseList);
			model.addAttribute("pagecount", pagecount);
			return "forward:/jsp/manager/managelesson_m.jsp";
		}
		return "redirect:/login.jsp";
	}

	// 管理员--根据条件筛选课程
	@RequestMapping("/user/selectcoursebycondition.action")
	public void selectCourseByCondition(String selectlessontype,
			String selecttedepart, String selectlevel, String findtext,
			Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			String con = "";
			if (!selectlessontype.equals("-课程类型-")) {
				con = con + "and co_type = '" + selectlessontype + "'";
			}
			if (!selecttedepart.equals("-开设学院-")) {
				con = con + "and co_tedepart = '" + selecttedepart + "' ";
			}
			if (!selectlevel.equals("-开放年级-")) {
				con = con + "and co_grade = '" + selectlevel + "' ";
			}
			if (null != findtext && findtext != "") {
				Pattern pattern = Pattern.compile("[0-9]*");
				Matcher isNum = pattern.matcher(findtext);
				if (!isNum.matches())
					con = con + "and co_name like '%" + findtext + "%' ";
				else
					con = con + "and co_id = " + findtext + " ";
			}
			List<User> userList = courseService.selectCourseByCondition(0, 12,
					con);
			response.setContentType("text/html;charset=utf-8");
			JSONArray jsonArray = JSONArray.fromObject(userList);
			String json = jsonArray.toString();
			response.getWriter().write(json);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--根据页数管理课程
	@RequestMapping("/user/selectcoursebypagecount.action")
	public void selectCourseByPageCount(String selectlessontype,
			String selecttedepart, String selectlevel, String findtext,
			String pagecount, Model model, HttpSession session,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			String con = "";
			if (!selectlessontype.equals("-课程类型-")) {
				con = con + "and co_type = '" + selectlessontype + "'";
			}
			if (!selecttedepart.equals("-开设学院-")) {
				con = con + "and co_tedepart = '" + selecttedepart + "' ";
			}
			if (!selectlevel.equals("-开放年级-")) {
				con = con + "and co_grade = '" + selectlevel + "' ";
			}
			if (null != findtext && findtext != "") {
				Pattern pattern = Pattern.compile("[0-9]*");
				Matcher isNum = pattern.matcher(findtext);
				if (!isNum.matches())
					con = con + "and co_name like '%" + findtext + "%' ";
				else
					con = con + "and co_id = " + findtext + " ";
			}
			List<User> userList = courseService.selectCourseByCondition(
					Integer.parseInt(pagecount), 12, con);
			response.setContentType("text/html;charset=utf-8");
			JSONArray jsonArray = JSONArray.fromObject(userList);
			String json = jsonArray.toString();
			response.getWriter().write(json);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--修改课程弹窗div
	@RequestMapping("/user/modifycoursediv.action")
	public void modifyCourseDiv(String co_id, Model model, HttpSession session,
			HttpServletResponse response) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			Course courseList = courseService.selectCourseById(Integer
					.parseInt(co_id));
			response.setContentType("text/html;charset=utf-8");

			JsonConfig jsonConfig = new JsonConfig();
			jsonConfig.registerJsonValueProcessor(Date.class,
					new JsonDateValueProcessor());
			JSONObject jsonObject = JSONObject.fromObject(courseList);
			String json = jsonObject.toString();
			response.getWriter().write(json);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--修改课程信息
	@RequestMapping("/user/modifycourse.action")
	public void modifyCourse(@RequestBody JSONObject jsonObject, Model model,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			Course course = (Course) jsonObject
					.toBean(jsonObject, Course.class);
			courseService.updateCourseByCourse(course);
			response.getWriter().write("修改成功");
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--删除课程
	@RequestMapping("/user/deletecourse.action")
	public void deleteCourse(String co_id, Model model, HttpSession session,
			HttpServletResponse response) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			courseService.deleteCourseById(co_id);
			response.getWriter().write(1);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--判断根据id教师是否存在
	@RequestMapping("/user/selectteacherById.action")
	public void selectTeacherById(String userId, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		User user = userService.selectTeacherById(userId);
		if (null != user) {
			response.getWriter().print(1);
		} else {
			response.getWriter().print(0);
		}
	}

	// 管理员--添加课程
	@RequestMapping("/user/addcourse.action")
	public void addCourse(@RequestBody JSONObject jsonObject, Model model,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			Course course = (Course) jsonObject
					.toBean(jsonObject, Course.class);
			courseService.insertCourse(course);
			Course courseinsert = courseService.selectCourseByName(course
					.getCo_name());
			ClassRoom classRoom = new ClassRoom();
			classRoom.setC_co_id(courseinsert.getCo_id());
			classRoom.setC_name(course.getCo_place());
			classRoom.setC_state("教学任务");
			classRoomService.insertClassRoom(classRoom);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--跳转管理院系界面
	@RequestMapping("/user/managedepartpro_m.action")
	public String selectDepartAndProfession(@RequestParam String u_id,
			Model model, HttpSession session, HttpServletResponse response)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			List<Dictionary> departDic = dictionaryService.selectDicByType(0);
			List<Profession> proList = professionService.selectAllProfession();

			model.addAttribute("departDic", departDic);
			model.addAttribute("proList", proList);
			return "forward:/jsp/manager/managedepartpro_m.jsp";
		}
		return "redirect:/login.jsp";
	}

	// 管理员--修改院系信息弹窗
	@RequestMapping("/user/modifydepartprodiv.action")
	public void modifyDepartProdiv(String p_id, Model model,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			Profession pro = professionService.selectProfessionById(p_id);

			response.setContentType("text/html;charset=utf-8");
			JSONObject jsonObject = JSONObject.fromObject(pro);
			String json = jsonObject.toString();
			response.getWriter().write(json);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--修改院系信息
	@RequestMapping("/user/modifyprofession.action")
	public void modifyProfession(@RequestBody JSONObject jsonObject,
			Model model, HttpSession session, HttpServletResponse response)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			Profession pro = (Profession) jsonObject.toBean(jsonObject,
					Profession.class);
			professionService.updateProfessionByPro(pro);
			response.getWriter().write("修改成功");
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理院--删除专业
	@RequestMapping("/user/deleteprofession.action")
	public void deleteProfession(String p_id, Model model, HttpSession session,
			HttpServletResponse response) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			Profession pro = professionService.selectProfessionById(p_id);
			professionService.deleteProById(p_id);
			if (professionService.selectProfessionByPdepart(pro.getP_depart())
					.size() <= 0) {
				dictionaryService.deleteDepartByName(pro.getP_depart());
			}
			response.getWriter().write(1);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--添加学院
	@RequestMapping("/user/adddepart.action")
	public void addDepart(String p_name, Model model, HttpSession session,
			HttpServletResponse response) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			List<Dictionary> dicList = dictionaryService.selectAllDepart();
			Boolean flag = true;
			for (Dictionary dic : dicList)
				if (dic.getD_name().equals(p_name))
					flag = false;
			if (flag) {
				dictionaryService.insertDepart(p_name);
				response.getWriter().print(1);
			} else
				response.getWriter().print(0);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--添加专业
	@RequestMapping("/user/addprofession.action")
	public void addProfession(String p_name, String p_depart, Model model,
			HttpSession session, HttpServletResponse response)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			professionService.insertProfession(p_name, p_depart);
			response.getWriter().print(1);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--根据条件查询专业
	@RequestMapping("/user/selectprobycondition.action")
	public void selectProByCondition(String selectdepart, String findtext,
			Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			String con = "";
			if (!selectdepart.equals("-选择学院-")) {
				con = con + "and p_depart = '" + selectdepart + "'";
			}
			if (null != findtext && findtext != "") {
				Pattern pattern = Pattern.compile("[0-9]*");
				Matcher isNum = pattern.matcher(findtext);
				if (!isNum.matches())
					con = con + "and (p_name like '%" + findtext
							+ "%' or p_depart like '%" + findtext + "%')";
				else
					con = con + "and p_id = " + findtext + " ";
			}
			List<Profession> proList = professionService
					.selectProfessionByCondition(con);
			response.setContentType("text/html;charset=utf-8");
			JSONArray jsonArray = JSONArray.fromObject(proList);
			String json = jsonArray.toString();
			response.getWriter().write(json);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 用户--修改密码
	@RequestMapping("/user/modifypassword.action")
	public void modifyPassword(String passwordtext, String newpasswordtext,
			Model model, HttpSession session, HttpServletResponse response)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			if (passwordtext.equals(user.getU_password())) {
				user.setU_password(newpasswordtext);
				userService.updatePasswordByUser(user);
				response.getWriter().print(1);
			} else
				response.getWriter().print(0);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--跳转管理教室信息页面
	@RequestMapping("/user/manageclassroom_m.action")
	public String manageClassRoom(@Param("u_id") String u_id,
			HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		User user = (User) session.getAttribute("user");
		if (null != user && u_id.equals(user.getU_id())) {
			List<ClassRoom> classRoomList = classRoomService
					.selectClassRoomByPage(0, 12);
			request.setAttribute("pagecount", (classRoomList.size() - 1) / 12);
			request.setAttribute("classRoomList", classRoomList);
			return "forward:/jsp/manager/manageclassroom.jsp";
		} else
			return "redirect:/login.jsp";
	}

	// 管理员--跳转管理学生成绩界面
	@RequestMapping("/user/managestuscore_m.action")
	public String manageStuScore(@Param("u_id") String u_id,
			HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			List<Lesson> lessonList = lessonService
					.selectAllLessonByPage(0, 12);
			String[] course = new String[lessonList.size()];
			String[] student = new String[lessonList.size()];
			List<Dictionary> departDic = dictionaryService.selectDicByType(0);
			List<Dictionary> levelDic = dictionaryService.selectDicByType(3);
			int i = 0;
			for (Lesson lesson : lessonList) {
				course[i] = lesson.getCourse().getCo_name();
				student[i++] = lesson.getUser().getU_name();
			}
			model.addAttribute("lessonList", lessonList);
			model.addAttribute("departDic", departDic);
			model.addAttribute("levelDic", levelDic);
			model.addAttribute("course", course);
			model.addAttribute("student", student);
			model.addAttribute("pagecount", (lessonList.size() - 1) / 12);
			return "forward:/jsp/manager/managestuscore_m.jsp";
		}
		return "redirect:/sams/login.jsp";
	}
}
