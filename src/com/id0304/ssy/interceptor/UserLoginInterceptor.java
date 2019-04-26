package com.id0304.ssy.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.id0304.ssy.pojo.User;

public class UserLoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object object) throws Exception {
		String uri = request.getRequestURI();
		if (!uri.contains("/login")) {
			User user = (User) request.getSession().getAttribute("user");
			// String u_id = (String) request.getAttribute("uid");
			if (null == user.getU_id() || "" == user.getU_id()) {
				response.sendRedirect(request.getContextPath() + "/login.jsp");
				return false;
			}
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}
}
