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
							教学综合信息服务平台学生端</b>
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
					${user.u_name } 同学</font>
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="row" style="height: 790px;">
			<div class="col-md-2" align="left">
				<ul class="nav nav-pills nav-stacked" align="left">
					<li role="presentation" class="active"><a
						href="${pageContext.request.contextPath}/user/index_s.action?u_id=${user.u_id}"
						class="glyphicon glyphicon-home"> 首页</a></li>
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

				<div class="row" align="center">
					<h2>${user.u_name }的课表</h2>
				</div>
				<table class="table" align="center">
					<tr>
						<td></td>
						<td>周一</td>
						<td>周二</td>
						<td>周三</td>
						<td>周四</td>
						<td>周五</td>
						<td>周六</td>
						<td>周日</td>
					</tr>
					<c:forEach var="row" begin="0" end="5">
						<tr>
							<c:if test="${row==0}">
								<td>1-2节</td>
							</c:if>
							<c:if test="${row==1 }">
								<td>3-4节</td>
							</c:if>
							<c:if test="${row==2 }">
								<td>5-6节</td>
							</c:if>
							<c:if test="${row==3 }">
								<td>7-8节</td>
							</c:if>
							<c:if test="${row==4 }">
								<td>9-10节</td>
							</c:if>
							<c:forEach var="col" begin="0" end="7">
								<td>${lessontable[row][col] }</td>
							</c:forEach>
						</tr>
					</c:forEach>

				</table>
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