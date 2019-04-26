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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.id0304.ssy.pojo.ClassRoom;
import com.id0304.ssy.pojo.Course;
import com.id0304.ssy.pojo.User;
import com.id0304.ssy.service.ClassRoomService;

@Controller
public class ClassRoomController {
	@Autowired
	private ClassRoomService classRoomService;

	@RequestMapping("/classroom/selectByCondition.action")
	public String selectClassRoomByCondition(@RequestParam("u_id") String u_id,
			HttpSession session, Model model, HttpServletRequest request) {
		User user = (User) session.getAttribute("user");
		if (null != user && user.getU_id().equals(u_id)) {
			model.addAttribute("user", user);
			List<Course> courseList = new ArrayList<Course>();
			String co_weekday = request.getParameter("selectweekday");
			String co_lessonnum = request.getParameter("selectLessonnum");
			String findText = request.getParameter("findText");
			if (co_weekday.equals("-使用时间-")) {
				co_weekday = "1=1";
			} else {
				switch (co_weekday) {
				case "周一":
					co_weekday = "1";
					break;
				case "周二":
					co_weekday = "2";
					break;
				case "周三":
					co_weekday = "3";
					break;
				case "周四":
					co_weekday = "4";
					break;
				case "周五":
					co_weekday = "5";
					break;
				case "周六":
					co_weekday = "6";
					break;
				case "周日":
					co_weekday = "7";
					break;
				}
				co_weekday = "co.co_weekday = " + co_weekday;
			}

			if (co_lessonnum.equals("-使用节数-")) {
				co_lessonnum = "1=1";
			} else {
				switch (co_lessonnum) {
				case "1-2节":
					co_lessonnum = "12";
					break;
				case "3-4节":
					co_lessonnum = "34";
					break;
				case "5-6节":
					co_lessonnum = "56";
					break;
				case "7-8节":
					co_lessonnum = "78";
					break;
				case "9-10节":
					co_lessonnum = "910";
					break;
				}
				co_lessonnum = "co.co_lessonnum = " + co_lessonnum;
			}

			if (findText.equals("") || null == findText)
				findText = "1=1";
			else
				findText = "c.c_name like '%" + findText + "%'";

			ClassRoom classRoom = new ClassRoom();
			Course course = new Course();
			course.setCo_name(co_weekday); // 草船借箭
			course.setCo_type(co_lessonnum);
			classRoom.setC_name(findText);

			List<ClassRoom> cRoomList = classRoomService
					.selectClassRoomByCondition(classRoom, course);

			for (ClassRoom cRoom : cRoomList) {
				courseList.add(cRoom.getCourse());
			}
			model.addAttribute("cRoomList", cRoomList);
			model.addAttribute("courseList", courseList);
			return "forward:/jsp/teacher/classroom_t.jsp";

		}
		return null;
	}

	// 管理员--删除教室
	@RequestMapping("/classroom/deleteclassroom.action")
	public void deleteClassRoom(String c_id, HttpServletResponse response,
			HttpSession session) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			classRoomService.deleteClassRoomById(c_id);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--修改教室回显
	@RequestMapping("/classroom/reviewclassroom.action")
	public void reviewClassRoom(String c_id, HttpServletResponse response,
			HttpSession session) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			ClassRoom classRoom = classRoomService.selectClassRoomById(c_id);
			response.setContentType("text/html;charset=utf-8");
			JSONObject jsonObject = JSONObject.fromObject(classRoom);
			String json = jsonObject.toString();
			response.getWriter().write(json);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--修改教室信息
	@RequestMapping("/classroom/modifyclassroom.action")
	public void modifyClassRoom(@RequestBody JSONObject jsonObject,
			HttpServletResponse response, HttpSession session)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			ClassRoom classRoom = (ClassRoom) jsonObject.toBean(jsonObject,
					ClassRoom.class);
			if (classRoom.getC_name().equals("")
					|| classRoom.getC_state().equals("")) {
				return;
			} else
				classRoomService.updateClassRoom(classRoom);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--增加教室信息
	@RequestMapping("/classroom/addclassroom.action")
	public void addClassRoom(@RequestBody JSONObject jsonObject,
			HttpServletResponse response, HttpSession session)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			ClassRoom classRoom = (ClassRoom) jsonObject.toBean(jsonObject,
					ClassRoom.class);
			if (classRoom.getC_name().equals("")
					|| classRoom.getC_state().equals("")) {
				return;
			}
			classRoomService.insertClassRoom(classRoom);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--通过条件筛选教室
	@RequestMapping("/classroom/selectclassroombycondition.action")
	public void selectClassRoomByCondition(String findtext,
			HttpServletResponse response, HttpSession session)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			Pattern pattern = Pattern.compile("[0-9]*");
			Matcher isNum = pattern.matcher(findtext);
			if (findtext == "")
				findtext = "";
			else if (isNum.matches() && findtext != "")
				findtext = "and c_id = " + findtext;
			else
				findtext = "and c_name like '%" + findtext + "%'";
			List<ClassRoom> classRoomList = classRoomService
					.selectClassRoomByNameOrId(findtext, 0, 12);
			JSONArray jsonArray = JSONArray.fromObject(classRoomList);
			response.setContentType("text/html;charset=utf-8");
			String json = jsonArray.toString();
			response.getWriter().write(json);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	// 管理员--跳页查询教室
	@RequestMapping("/classroom/classroomchangepage.action")
	public void classRoomChangePage(String findtext, String page,
			HttpServletResponse response, HttpSession session,
			HttpServletRequest request) throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			List<ClassRoom> classRoomList = classRoomService
					.selectClassRoomByNameOrId(findtext,
							Integer.parseInt(page) - 1, 12);
			response.setContentType("text/html;charset=utf-8");
			JSONArray jsonArray = JSONArray.fromObject(classRoomList);
			String json = jsonArray.toString();
			response.getWriter().write(json);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

}
