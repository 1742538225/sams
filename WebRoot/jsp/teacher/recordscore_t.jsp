<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.css" />

<!--需要引入JQuery -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">

<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/sams.js"></script>
<script type="text/javascript">
			window.onload = messageremind;
		</script>
</head>

<body style="background: url('/sams/img/background.png');">
	<div class="container" style="background: black;">

		<div class="row" style="background: white;">
			<div class="col-md-2 hidden-xs" align="center">
				<img src="${pageContext.request.contextPath}/img/LOGO6.png" />
			</div>
			<div class="col-md-8" align="center">
				<br>
				<h1>
					<font class="glyphicon glyphicon-education"><b>
							教学综合信息服务平台教师端</b>
					</font>
				</h1>
			</div>
			<div class="col-md-2 hidden-sm hidden-xs" align="right">
				<br>
				<br>
				<br> <font color="#122B40">By <a
					href="http://www.baidu.com">WuZhengHua</a> </font> <input id="userid"
					type="hidden" value="${user.u_id }" name="userid">
			</div>
		</div>
		<div class="row" style="background: black; height: 24px;"
			align="center">
			<div class="col-md-7"></div>
			<div class="col-md-3" align="right">
				<font color="white" class="glyphicon glyphicon-user"> 欢迎
					${user.u_name } 老师</font>
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="row" style="height: 790px;">
			<div class="col-md-2" align="left">
				<ul class="nav nav-pills nav-stacked" align="left">
					<li role="presentation" class="active"><a
						href="${pageContext.request.contextPath}/user/index_t.action?u_id=${user.u_id}"
						class="glyphicon glyphicon-home"> 首页</a></li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/individual_t.action?u_id=${user.u_id}">个人信息</a>
					</li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/classtable_t.action?u_id=${user.u_id}">课程查询</a>
					</li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/rollbook_t.action?u_id=${user.u_id}">点名册系统</a>
					</li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/classroom_t.action?u_id=${user.u_id}">教室使用情况查询</a>
					</li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/recordscore_t.action?u_id=${user.u_id}">录入学生成绩</a>
					</li>
				</ul>
			</div>
			<div class="col-md-9" style="background: white;height: 770px;">
				<div class="row " style="height:10px"></div>
				<div class="row " style="height:50px">
					<div class="col-md-1"></div>
					<form
						action="${pageContext.request.contextPath}/classroom/selectLessonbycondition.action?u_id=${user.u_id}"
						method="post">
						<div class="col-md-3">
							<div class="form-group">
								<select class="form-control" name="selectCoid" runat="server">
									<option>-选择课程号-</option>
									<c:forEach items="${courseList }" var="course">
										<option>${course.co_id }</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="col-md-6">
							<div class="input-group">
								<input type="text" class="form-control"
									placeholder="请输入学生学号或姓名搜索学生..." name="findText"> <span
									class="input-group-btn">
									<button class="btn btn-default" type="submit">搜索</button> </span>
							</div>
						</div>
					</form>
				</div>
				<div class="col-md-1"></div>
				<div class="col-md-11" style="height: 690px;overflow: scroll;">
					<table class="table table-hover">
						<tr>
							<td>学号</td>
							<td>姓名</td>
							<td>课程号</td>
							<td>课程</td>
							<td>分数</td>
							<td></td>
						</tr>
						<c:forEach items="${lessonList}" var="lesson" varStatus="loop">
							<tr>
								<td>${student[loop.count-1].u_id }</td>
								<td>${student[loop.count-1].u_name }</td>
								<td>${lesson.l_co_id }</td>
								<td>${course[loop.count-1].co_name }</td>
								<td><input
									id="${ student[loop.count-1].u_id }${lesson.l_co_id }"
									type="text" value="${lesson.l_score }">
								</td>
								<td><input
									id="updatescore${ student[loop.count-1].u_id }${lesson.l_co_id }"
									type="button" class="btn-default" value="录入"
									onclick="recordscore('${student[loop.count-1].u_id }',${lesson.l_co_id })">
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>

			<div id="messagediv"
				style="position:absolute;top:227px;left:822px; width: 400px;height: 300px;display: none;">
				<iframe id="messageiframe" class="embed-responsive-item"
					style=" width: 400px;height: 300px; "
					src="${pageContext.request.contextPath }/jsp/message.jsp"></iframe>
			</div>

			<div class="col-md-1">
				<div class="row">
					<a class="btn btn-info"
						href="${pageContext.request.contextPath}/user/loginUI.action"
						style="text-decoration: none;"
						onclick="return confirm('确定注销当前账户?');">账户注销</a>
				</div>
				<br>
				<div class="row ">
					<a type="button"
						class="btn btn-default glyphicon glyphicon-envelope"
						style="text-decoration: none;" target="_blank"
						onclick="clickmessage()"><span class="badge" id="unreadcount">
							0</span>
					</a>
				</div>
			</div>
		</div>

		<div class="row" align="center"
			style="background: black;height: 40px;">
			<font color="white">Copyright ©2019 WuZhenghua</font>
		</div>
	</div>
</body>

</html>