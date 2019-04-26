<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	closediv = function() {
		$("#modifyindividual").css("display", "none");
	};
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
				<div class="row" style="height:3px"></div>
				<div class="row" align="center">
					<div class="col-md-6">
						<font color="blue" size="6">教职工编号:${user.u_id }</font>
					</div>
					<div class="col-md-6">
						<font color="blue" size="6">姓名:${user.u_name }</font>
					</div>
				</div>

				<div class="col-md-1"></div>
				<div class="col-md-10" style="height:680px;overflow: scroll;">
					<table class="table">
						<tr>
							<td>教职工编号</td>
							<td>${user.u_id }</td>
						</tr>
						<tr>
							<td>姓名</td>
							<td>${user.u_name}</td>
						</tr>
						<tr>
							<td>性别</td>
							<td>${user.u_sex}</td>
						</tr>
						<tr>
							<td>年龄</td>
							<td>${user.u_age}</td>
						</tr>
						<tr>
							<td>出生日期</td>
							<td><fmt:formatDate value="${user.u_birthday}"
									pattern="yyyy-MM-dd" /></td>
						</tr>
						<tr>
							<td>籍贯</td>
							<td>${user.u_native}</td>
						</tr>
						<tr>
							<td>证件类型</td>
							<td>${user.u_credentials}</td>
						</tr>
						<tr>
							<td>证件号</td>
							<td>${user.u_code}</td>
						</tr>
						<tr>
							<td>民族</td>
							<td>${user.u_fork}</td>
						</tr>
						<tr>
							<td>政治面貌</td>
							<td>${user.u_political}</td>
						</tr>
						<tr>
							<td>毕业院校</td>
							<td>${user.u_graduate}</td>
						</tr>
						<tr>
							<td>教龄</td>
							<td>${user.u_teage}</td>
						</tr>
						<tr>
							<td>职务</td>
							<td>${user.u_post}</td>
						</tr>
						<tr>
							<td>教师公寓地址</td>
							<td>${user.u_address}</td>
						</tr>
						<tr>
							<td>联系电话</td>
							<td>${user.u_tel}</td>
						</tr>
						<tr>
							<td>入职日期</td>
							<td>&nbsp;<fmt:formatDate value="${user.u_enrolment}"
									pattern="yyyy-MM-dd" /></td>
						</tr>
						<tr>
							<td>薪资</td>
							<td>${user.u_tuition}/课时</td>
						</tr>
						<tr>
							<td>其他信息</td>
							<td>${user.u_detail}</td>
						</tr>
					</table>
				</div>
				<div class="col-md-1"></div>
				<div align="center">
					<div class="btn-group" role="group" aria-label="...">
						<button type="button" class="btn btn-danger" onclick="clickmodifypassword()">修改密码</button>
						<button type="button" class="btn btn-default"
							onclick="updateindividual()">修改个人信息</button>
					</div>
				</div>
			</div>

			<div id="modifyindividual"
				style="background-color:#EEE8AA ;position:absolute;top:285px;left:320px; width: 800px;height: 310px;display:none; ">
				<div class="row">
					<div class="col-md-2"></div>
					<div class="col-md-8" align="center">
						<h3>修改信息</h3>
					</div>
					<div class="col-md-2" align="center">
						<br>
						<button class="btn btn-danger" onclick="closediv()">关闭</button>
					</div>
				</div>
				<div class="row">
					<div class="col-md-1"></div>
					<div class="col-md-10">
						<div class="row">
							<div class="col-md-1"></div>
							<div class="col-md-5">
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">姓名:</span> <input
										id="nametext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">性别:</span> <input
										id="sextext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">年龄:</span> <input
										id="agetext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">出生日期:</span>
									<input id="birthdaytext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">籍贯:</span> <input
										id="nativetext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">证件类型:</span>
									<input id="credentialstext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
							</div>
							<div class="col-md-5">
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">证件号:</span> <input
										id="codetext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">民族:</span> <input
										id="forktext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">政治面貌:</span>
									<input id="politicaltext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">毕业院校:</span>
									<input id="graduatetext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">教师公寓地址:</span>
									<input id="addresstext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">联系电话:</span>
									<input id="teltext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
							</div>
							<div class="col-md-1"></div>
						</div>
						<div class="row" style="height:10px;"></div>
						<div class="row" align="center">
							<button class="btn btn-info" onclick="modifyindividualsubmit()">修改</button>
						</div>
					</div>
					<div class="col-md-1"></div>
				</div>
			</div>

			<div id="messagediv"
				style="position:absolute;top:227px;left:822px; width: 400px;height: 300px;display: none;">
				<iframe id="messageiframe" class="embed-responsive-item"
					style=" width: 400px;height: 300px; "
					src="${pageContext.request.contextPath }/jsp/message.jsp"></iframe>
			</div>

			<!-- 修改密码 -->
			<div id="modifypassworddiv"
				style="background-color:#EEE8AA ;position:absolute;top:285px;left:520px; width: 500px;height: 225px;display:none; ">
				<div class="row">
					<div class="col-md-2"></div>
					<div class="col-md-8" align="center">
						<h3>设置新密码</h3>
					</div>
					<div class="col-md-2" align="center">
						<br>
						<button class="btn btn-danger" onclick="closemodifypassword()">关闭</button>
					</div>
				</div>
				<div class="row">
					<div class="col-md-1"></div>
					<div class="col-md-10">
						<div class="row">
							<div class="col-md-1"></div>
							<div class="col-md-10">
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">原密码:</span> <input
										id="passwordtext" type="password" class="form-control"
										aria-describedby="basic-addon1">
								</div>
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">新密码:</span> <input
										id="newpasswordtext" type="password" class="form-control"
										aria-describedby="basic-addon1" onblur="confipassword()">
								</div>
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">重复密码:</span>
									<input id="againpasswordtext" type="password"
										class="form-control" aria-describedby="basic-addon1"
										onblur="confipassword()">
								</div>
								<span id="confispan">请确保两次输入密码一致</span>
							</div>
							<div class="col-md-1"></div>
						</div>
						<div class="row" style="height:10px;"></div>
						<div class="row" align="center">
							<button id="confimodifypassword" class="btn btn-info"
								onclick="modifypassword()">确认</button>
						</div>
					</div>
					<div class="col-md-1"></div>
				</div>
			</div>
			<!-- 修改密码 -->

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
						onclick="clickmessage()"><span class="badge" id="unreadcount">0</span>
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