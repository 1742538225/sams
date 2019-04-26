package com.id0304.ssy.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.id0304.ssy.pojo.Lesson;
import com.id0304.ssy.pojo.Message;
import com.id0304.ssy.pojo.User;
import com.id0304.ssy.service.LessonService;
import com.id0304.ssy.service.MessageService;

@Controller
public class MessageController {
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private LessonService lessonService;

	@RequestMapping("/message/messagecount.action")
	public void selectMessageCount(HttpServletRequest request,
			HttpServletResponse response, HttpSession session)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			List<Message> messageList = messageService
					.selectMessageByUid(user.getU_id());
			Integer UnReadCount = 0;
			for (Message message : messageList)
				if (message.getM_state() == 0)
					UnReadCount++;
			response.getWriter().print(UnReadCount);
		} else
			response.sendRedirect("/sams/login.jsp");
	}

	@RequestMapping("/message/messageload.action")
	public void messageLoad(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, Model model)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			List<Message> messageList = messageService.selectMessageByUid(user
					.getU_id());

			JSONArray jsonArray = JSONArray.fromObject(messageList);
			String json = jsonArray.toString();

			response.setContentType("text/html;charset=utf-8");
			response.getWriter().write(json);
		} else {
			response.sendRedirect("/sams/login.jsp");
		}
	}
	
	@RequestMapping("/message/messagedelete.action")
	public void messageDelete(String m_id,HttpServletRequest request,
			HttpServletResponse response, HttpSession session, Model model) throws IOException{
		User user = (User) session.getAttribute("user");
		if (null != user) {
			messageService.deleteMessageByMid(Integer.parseInt(m_id));
		} else {
			response.sendRedirect("/sams/login.jsp");
		}
	}
	
	@RequestMapping("/message/messageclear.action")
	public void messageClear(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, Model model)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			messageService.deleteMessageByUidAndMState(user.getU_id());
		} else {
			response.sendRedirect("/sams/login.jsp");
		}
	}

	@RequestMapping("/message/messageread.action")
	public void messageRead(String m_id,HttpServletRequest request,
			HttpServletResponse response, HttpSession session, Model model)
			throws IOException {
		User user = (User) session.getAttribute("user");
		if (null != user) {
			messageService.updateMessageByUidAndMid(user.getU_id(),m_id);
		} else {
			response.sendRedirect("/sams/login.jsp");
		}
	}
	
	//教学秘书--发布调课通知给学生
	@RequestMapping("/message/adjustlesson.action")
	public void adjustLesson(String co_id,String m_body,String m_type,String m_source,HttpServletRequest request,
			HttpServletResponse response, HttpSession session, Model model) throws IOException{
		User user = (User) session.getAttribute("user");
		if (null != user) {
			List<Lesson> lessonList = lessonService.selectStuAndLessonAndByCoId(Integer.parseInt(co_id));
			String [] studentid = new String[lessonList.size()];
			int i = 0;
			for (Lesson lesson : lessonList) {
				studentid[i++] = lesson.getUser().getU_id();
			}
			Message message = new Message();
			message.setM_body(m_body);
			message.setM_type(m_type);
			message.setM_source(m_source);
			for (String u_id : studentid) {
				message.setM_target(u_id);
				messageService.insertMessageByUid(message);
			}
		}else {
			response.sendRedirect("/sams/login.jsp");
		}
		
	}
}
