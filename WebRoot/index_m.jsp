<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>

		<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.css" />

		<!--需要引入JQuery -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.js"></script>

		<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.js"></script>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/sams.js"></script>
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
					<br><h1><font class="glyphicon glyphicon-education" ><b> 教学综合信息服务平台管理权限端</b></font></h1>
				</div>
				<div class="col-md-2 hidden-sm hidden-xs" align="right">
					<br><br><br>
					<font color="#122B40">By
						<a href="http://www.baidu.com">WuZhengHua</a>
					</font>
				</div>
			</div>
			<div class="row" style="background: black; height: 24px;" align="center">
				<div class="col-md-7"></div>
				<div class="col-md-3" align="right">
					<font color="white" class="glyphicon glyphicon-user"> 欢迎您，ADMIN</font>
					<input id="userid" type="hidden" value="${user.u_id }" name = "userid">
				</div>
				<div class="col-md-2"></div>
			</div>
			<div class="row" style="height: 790px;">
				<div class="col-md-2" align="left">
					<ul class="nav nav-pills nav-stacked" align="left">
						<li role="presentation" class="active">
							<a href="${pageContext.request.contextPath}/user/index_m.action?u_id=${user.u_id}" class="glyphicon glyphicon-home"> 首页</a>
						</li>
						<li role="presentation">
							<a href="${pageContext.request.contextPath}/user/manageuser_m.action?u_id=${user.u_id}" >管理系统用户信息</a>
						</li>
						<li role="presentation">
							<a href="${pageContext.request.contextPath}/user/managelesson_m.action?u_id=${user.u_id}">管理课程信息</a>
						</li>
						<li role="presentation">
							<a href="${pageContext.request.contextPath}/user/managedepartpro_m.action?u_id=${user.u_id}">管理院系信息</a>
						</li>
						<li role="presentation">
							<a href="${pageContext.request.contextPath}/user/manageclassroom_m.action?u_id=${user.u_id}">管理教室信息</a>
						</li>
						<li role="presentation"><a
							href="${pageContext.request.contextPath}/user/managestuscore_m.action?u_id=${user.u_id}">管理学生成绩信息</a>
						</li>
					</ul>
				</div>
				<div class="col-md-9" style="background: black;height: 770px;" align="center">
				
					<div class="jumbotron">
					  <div class="container">
					    <h1>教务系统管理员首页</h1>
					  </div>
					</div>
					
				</div>
				<div class="col-md-1">
					<div class="row"><a class="btn btn-info" href="${pageContext.request.contextPath}/user/loginUI.action" style="text-decoration: none;"  onclick="return confirm('确定注销当前账户?');">账户注销</a></div>
					<br>
					<div class="row "><a type="button" class="btn btn-default glyphicon glyphicon-envelope" style="text-decoration: none;" target="_blank" onclick="clickmessage()"><span class="badge" id="unreadcount"> 0</span></a></div>
				</div>
				
				<div  id = "messagediv" style="position:absolute;top:225px;left:898px; width: 400px;height: 300px;display: none;">
						<iframe id="messageiframe" class="embed-responsive-item" style=" width: 400px;height: 300px; " src="${pageContext.request.contextPath }/jsp/message.jsp"></iframe>
				</div>
				
			</div>

			<div class="row" align="center" style="background: black;height: 40px;">
				<font color="white">Copyright ©2019 WuZhenghua</font>
			</div>
		</div>
	</body>

</html>