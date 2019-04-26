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
							教学综合信息服务平台学生端</b> </font>
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
					${user.u_name } 同学</font>
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="row" style="height: 790px;">
			<div class="col-md-2" align="left">
				<ul class="nav nav-pills nav-stacked" align="left">
					<li role="presentation" class="active"><a
						href="${pageContext.request.contextPath}/user/index_s.action?u_id=${user.u_id}"
						class="glyphicon glyphicon-home"> 首页</a>
					</li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/individual_s.action?u_id=${user.u_id}">个人信息</a>
					</li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/score_s.action?u_id=${user.u_id}">学分成绩</a>
					</li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/classtable_s.action?u_id=${user.u_id}">课表查询</a>
					</li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/selectclass_s.action?u_id=${user.u_id}">自主选课</a>
					</li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/evaluate_s.action?u_id=${user.u_id}">评教系统</a>
					</li>
				</ul>
			</div>

			<div class="col-md-9" style="background: white;height: 770px;">
				<div class="row" style="height:60px">
					<div class="row" style="height:10px"></div>
					<form
						action="${pageContext.request.contextPath}/course/selectCourseByType.action?u_id=${user.u_id}"
						method="post">
						<div class="col-md-2">
							<div class="form-group">
								<select class="form-control" name="selectType" runat="server">
									<option>-类型-</option>
									<c:forEach items="${dicLessonList }" var="dic">
										<option>${dic.d_name}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="col-md-2">
							<div class="form-group">
								<select class="form-control" name="selectTeDepart"
									runat="server">
									<option>-开课学院-</option>
									<c:forEach items="${dicDepartList }" var="dic">
										<option>${dic.d_name}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="col-md-2">
							<div class="form-group">
								<select class="form-control" name="ifContent" runat="server">
									<option>-有无余量-</option>
									<option>有</option>
									<option>无</option>
								</select>
							</div>
						</div>

						<div class="col-md-6">
							<div class="input-group">
								<input type="text" class="form-control"
									placeholder="请输入课程编号或者课程名称搜索..." name="findText"> <span
									class="input-group-btn">
									<button class="btn btn-default" type="submit">搜索</button> </span>
							</div>
						</div>
					</form>

				</div>

				<div class="row" style="height: 690px; overflow:scroll">
					<table class="table table-hover" align="center"
						style="width:840px;">
						<tr>
							<td>编号</td>
							<td>课程名称</td>
							<td>类型</td>
							<td>时间</td>
							<td>上课地点</td>
							<td>教师</td>
							<td>学分</td>
							<td>开课学院</td>
							<td>容量</td>
							<td></td>
						</tr>

						<c:forEach var="course" items="${courseList }" varStatus="loop">
							<tr>
								<td>${course.co_id }</td>
								<td>${course.co_name }</td>
								<td>${course.co_type }</td>
								<td>${course.co_lessonnum
									}节,周${course.co_weekday},第${course.co_weeks }</td>
								<td>${course.co_place }</td>
								<td>${teacherArray[loop.count-1]}</td>
								<td>${course.co_credit }</td>
								<td>${course.co_tedepart }</td>
								<td>${course.co_occupy}/${course.co_content }</td>
								<td><input id="${course.co_id }" type="button"
									class="btn btn-default" onclick="selectclass(${course.co_id })"
									value="选课"></td>
							</tr>
						</c:forEach>
					</table>
				</div>

				<div id="messagediv"
					style="position:absolute;top:93px;left:538px; width: 400px;height: 300px;display: none;">
					<iframe id="messageiframe" class="embed-responsive-item"
						style=" width: 400px;height: 300px; "
						src="${pageContext.request.contextPath }/jsp/message.jsp"></iframe>
				</div>


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