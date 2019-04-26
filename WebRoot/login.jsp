<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
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

<style>
/*  div {
				border: 1px solid red;
			}  */
</style>

<script src="${pageContext.request.contextPath}/js/sams.js"
	type="text/javascript"></script>

</head>

<body>
	<div class="container">
		<div class="row" style="height: 175px;"></div>
		<div class="row" style="height: 60px;" align="center">
			<h1>
				<b>教学综合信息服务平台</b>
			</h1>
		</div>
		<div class="row" align="center">
			<img src="${pageContext.request.contextPath}/img/LOGO6.png" />
		</div>
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<form id="form1" action="user/login.action" method="post">
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1"><b>账号</b>
						</span> <input id="userId" onblur="checkUserId()" type="text"
							class="form-control" name="u_id" placeholder="账号"
							aria-describedby="basic-addon1">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1"><b>密码</b>
						</span> <input id="password" type="password" class="form-control"
							name="u_password" placeholder="密码"
							aria-describedby="basic-addon1">
					</div>
				</form>
			</div>
			<div class="col-md-4">
				<span id="usernamespan"></span>
			</div>
		</div>
		<div class="row" align="center">
			<br />
			<button class="btn btn-default" onclick="checkLogin()"
				style="width:353px">Login</button>
		</div>
	</div>
</body>

</html>