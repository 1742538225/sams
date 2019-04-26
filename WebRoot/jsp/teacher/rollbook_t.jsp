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
				&nbsp; <img src="${pageContext.request.contextPath}/img/LOGO6.png" />
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
				<div class="row" style="height: 60px;" align="center">
					<h3>${user.u_name }的点名册</h3>
				</div>


				<!-- 点名册内容页面 -->
				<div class="panel-group" id="accordion" role="tablist"
					aria-multiselectable="true">
					<c:forEach items="${courseList }" var="course">
						<div class="panel panel-default">
							<div class="panel-heading" role="tab"
								id="heading${course.co_id }">
								<h4 class="panel-title">
									<a class="collapsed"
										onclick="clickrollbookitem(${course.co_id },${user.u_id })"
										data-toggle="collapse" data-parent="#accordion"
										href="#collapse${course.co_id }" aria-expanded="false"
										aria-controls="collapse${course.co_id }"> ${course.co_id }
										${course.co_name } ${course.co_place } 周${course.co_weekday }
										第${course.co_lessonnum }节 </a>
								</h4>
							</div>
							<div id="collapse${course.co_id }"
								class="panel-collapse collapse" role="tabpanel"
								aria-labelledby="heading${course.co_id }">
								<div class="panel-body">

									<div class="row" style="height:20px" align="center">
										<div class="row" style="height:10px;"></div>
										<font id="classnum${course.co_id }"
											class="glyphicon glyphicon-user">班级人数:
											${index[loop.count]-index[loop.count-1] } |</font> <font
											class="glyphicon glyphicon-book">课程名称:${course.co_name
											} |</font> <font class="glyphicon glyphicon-map-marker">课程地点:${course.co_place
											} |</font> <font class="glyphicon glyphicon-time">课程时间:${course.co_weeks
											},周${course.co_weekday }，第${course.co_lessonnum }节</font>
									</div>
									<div class="row" style="height:20px;"></div>
									<div class="row">
										<div class="col-md-1"></div>
										<div class="col-md-10"
											style="overflow:scroll;overflow-x:hidden;">
											<table id="rollbooktable${course.co_id }"
												class="table table-hover">

											</table>
										</div>
									</div>

								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<!-- 点名册内容页面 -->


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
						style="text-decoration: none;" onclick="clickmessage()"
						target="_blank"><span class="badge" id="unreadcount">0</span>
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