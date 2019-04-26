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
							教学综合信息服务平台教师端</b> </font>
				</h1>
			</div>
			<div class="col-md-2 hidden-sm hidden-xs" align="right">
				<br> <br> <br> <font color="#122B40">By <a
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
						class="glyphicon glyphicon-home"> 首页</a>
					</li>
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
				<div class="row" style="height:60px">
					<div class="row" style="height:10px"></div>
					<form
						action="${pageContext.request.contextPath}/classroom/selectByCondition.action?u_id=${user.u_id}"
						method="post">
						<div class="col-md-2">
							<div class="form-group">
								<select class="form-control" name="selectweekday" runat="server">
									<option>-使用时间-</option>
									<option>周日</option>
									<option>周一</option>
									<option>周二</option>
									<option>周三</option>
									<option>周四</option>
									<option>周五</option>
									<option>周六</option>
								</select>
							</div>
						</div>

						<div class="col-md-2">
							<div class="form-group">
								<select class="form-control" name="selectLessonnum"
									runat="server">
									<option>-使用节数-</option>
									<option>1-2节</option>
									<option>3-4节</option>
									<option>5-6节</option>
									<option>7-8节</option>
									<option>9-10节</option>
								</select>
							</div>
						</div>

						<div class="col-md-6">
							<div class="input-group">
								<input type="text" class="form-control"
									placeholder="请输入教室名称搜索..." name="findText"> <span
									class="input-group-btn">
									<button class="btn btn-default" type="submit">搜索</button> </span>
							</div>
						</div>
					</form>
				</div>
				<div class="row" style="height: 690px; overflow:scroll;">
					<table class="table table-hover" align="center"
						style="width:840px;">
						<tr>
							<td>教室地点</td>
							<td>使用时间</td>
							<td>使用情况</td>
						</tr>

						<c:forEach var="classRoom" items="${cRoomList }" varStatus="loop">
							<tr>
								<td>${classRoom.c_name }</td>
								<td>第${courseList[loop.count-1].co_weeks }
									周${courseList[loop.count-1].co_weekday }
									${courseList[loop.count-1].co_lessonnum }节</td>
								<td>${classRoom.c_state }</td>
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