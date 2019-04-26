<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
							教学综合信息服务平台管理权限端</b> </font>
				</h1>
			</div>
			<div class="col-md-2 hidden-sm hidden-xs" align="right">
				<br> <br> <br> <font color="#122B40">By <a
					href="http://www.baidu.com">WuZhengHua</a> </font>
			</div>
		</div>
		<div class="row" style="background: black; height: 24px;"
			align="center">
			<div class="col-md-7"></div>
			<div class="col-md-3" align="right">
				<font color="white" class="glyphicon glyphicon-user">
					欢迎您，ADMIN</font> <input id="userid" type="hidden" value="${user.u_id }"
					name="userid">
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="row" style="height: 790px;">
			<div class="col-md-2" align="left">
				<ul class="nav nav-pills nav-stacked" align="left">
					<li role="presentation" class="active"><a
						href="${pageContext.request.contextPath}/user/index_m.action?u_id=${user.u_id}"
						class="glyphicon glyphicon-home"> 首页</a>
					</li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/manageuser_m.action?u_id=${user.u_id}">管理系统用户信息</a>
					</li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/managelesson_m.action?u_id=${user.u_id}">管理课程信息</a>
					</li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/managedepartpro_m.action?u_id=${user.u_id}">管理院系信息</a>
					</li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/manageclassroom_m.action?u_id=${user.u_id}">管理教室信息</a>
					</li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/managestuscore_m.action?u_id=${user.u_id}">管理学生成绩信息</a>
					</li>
				</ul>
			</div>
			<div class="col-md-9" style="background: white;height: 770px;"
				align="center">
				<div class="row">
					<div class="row" style="height:5px"></div>
					<div class="col-md-3">
						<select id="selectidentify" name="selectidentify"
							class="form-control" runat="server">
							<option>-身份-</option>
							<option>0学生</option>
							<option>1教师</option>
							<option>2教学秘书</option>
							<option>3管理员</option>
						</select>
					</div>
					<div class="col-md-3">
						<select id="selectdepart" name="selectdepart" class="form-control"
							runat="server">
							<option>-学院-</option>
							<c:forEach items="${dicList}" var="dic">
								<option>${dic.d_name }</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-5">
						<div class="input-group">
							<input id="findtext" name="findtext" type="text"
								class="form-control" placeholder="请输入编号或姓名..."> <span
								class="input-group-btn">
								<button class="btn btn-default" type="submit"
									onclick="selectuserbycondition()">搜索</button> </span>
						</div>
					</div>
					<div class="col-md-1">
						<button class="btn btn-success" data-toggle="modal"
							data-target="#addmodal">添加</button>
					</div>
				</div>
				<div class="row" style="height:5px;"></div>
				<div class="row"
					style="height:666px;overflow: scroll;overflow-y: hidden;">
					<table id="usertable" class="table table-bordered"
						style=" white-space:nowrap">
						<tr align="center">
							<td>操作</td>
							<td>ID</td>
							<td>密码</td>
							<td>姓名</td>
							<td>身份</td>
							<td>证件类型</td>
							<td>证件号</td>
							<td>性别</td>
							<td>年龄</td>
							<td>年级</td>
							<td>籍贯</td>
							<td>生日</td>
							<td>民族</td>
							<td>政治面貌</td>
							<td>毕业院校</td>
							<td>教龄</td>
							<td>职务</td>
							<td>学院</td>
							<td>专业</td>
							<td>行政班级</td>
							<td>住址</td>
							<td>联系电话</td>
							<td>入学/入职日期</td>
							<td>学费/薪资</td>
							<td>其他信息</td>
						</tr>
						<c:forEach items="${ userList}" var="user">
							<tr>
								<td>
									<button id="modifybutton" class="btn btn-info"
										onclick="modifyuserdiv('${user.u_id}')" class="btn btn-info"
										type="button" data-toggle="modal" data-target="#modifymodal">修改</button>
									<button id="deletebutton" class="btn btn-danger"
										onclick="deleteuser('${user.u_id}')">删除</button>
								</td>
								<td>${user.u_id }</td>
								<td>${user.u_password }</td>
								<td>${user.u_name }</td>
								<td>${user.u_identify }</td>
								<td>${user.u_credentials }</td>
								<td>${user.u_code }</td>
								<td>${user.u_sex }</td>
								<td>${user.u_age }</td>
								<td>${user.u_level }</td>
								<td>${user.u_native }</td>
								<td><fmt:formatDate value="${user.u_birthday}"
										pattern="yyyy-MM-dd" /></td>
								<td>${user.u_fork }</td>
								<td>${user.u_political }</td>
								<td>${user.u_graduate }</td>
								<td>${user.u_teage }</td>
								<td>${user.u_post }</td>
								<td>${user.u_depart }</td>
								<td>${user.u_profession }</td>
								<td>${user.u_class }</td>
								<td>${user.u_address }</td>
								<td>${user.u_tel }</td>
								<td><fmt:formatDate value="${user.u_enrolment }"
										pattern="yyyy-MM-dd" /></td>
								<td>${user.u_tuition }</td>
								<td>${user.u_detail }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="row">
					<nav>
						<ul id="pagecounts" class="pagination">
							<c:forEach begin="0" end="${pagecount }" varStatus="loop">
								<li><a href="#" onclick="selectpage(${loop.count})">${loop.count
										}<span class="sr-only"></span> </a></li>
							</c:forEach>
						</ul>
					</nav>
				</div>
			</div>

			<!-- 修改用户信息 -->
			<div class="modal fade" id="modifymodal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" style="top:180px;">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="myModalLabel">修改用户信息</h4>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-md-6">
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">密码</span> <input
											id="passwordtext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">姓名</span> <input
											id="nametext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">身份</span> <input
											id="identifytext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">证件类型</span>
										<input id="credentialstext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">证件号</span> <input
											id="codetext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">性别</span> <input
											id="sextext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">年龄</span> <input
											id="agetext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">年级</span> <input
											id="leveltext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">籍贯</span> <input
											id="nativetext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">生日</span> <input
											id="birthdaytext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">民族</span> <input
											id="forktext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
								</div>
								<div class="col-md-6">
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">政治面貌</span>
										<input id="politicaltext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">毕业学院</span>
										<input id="graduatetext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">教龄</span> <input
											id="teagetext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">职务</span> <input
											id="posttext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">学院</span> <input
											id="departtext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">专业</span> <input
											id="professiontext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">行政班级</span>
										<input id="classtext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">住址</span> <input
											id="addresstext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">联系电话</span>
										<input id="teltext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">入学/入职日期</span>
										<input id="enrolmenttext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">学费/薪资</span>
										<input id="tuitiontext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
								</div>
							</div>
							<div style="width:568px;">
								<div class="panel panel-default">
									<div class="panel-heading">其他信息</div>
									<div class="panel-body">
										<textarea id="detailtext" rows="6" cols="81"></textarea>
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
							<button id="confimodifybutton" type="button"
								class="btn btn-primary" onclick="">确认修改</button>
						</div>
					</div>
				</div>
			</div>
			<!-- 修改用户信息 -->

			<!-- 添加用户信息 -->
			<div class="modal fade" id="addmodal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" style="top:180px;">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="myModalLabel">添加用户信息</h4>
						</div>
						<div class="modal-body">
							<div class="row">

								<div class="col-md-6">
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">用户ID</span>
										<input id="addidtext" type="text" class="form-control"
											aria-describedby="basic-addon1" onblur="checkuserid()">
									</div>
								</div>
								<div class="col-md-6">
									<span id="useridifexistspan"></span>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">密码</span> <input
											id="addpasswordtext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">姓名</span> <input
											id="addnametext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">身份</span> <input
											id="addidentifytext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">证件类型</span>
										<input id="addcredentialstext" type="text"
											class="form-control" aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">证件号</span> <input
											id="addcodetext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">性别</span> <input
											id="addsextext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">年龄</span> <input
											id="addagetext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">年级</span> <input
											id="addleveltext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">籍贯</span> <input
											id="addnativetext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">生日</span> <input
											id="addbirthdaytext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">民族</span> <input
											id="addforktext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
								</div>
								<div class="col-md-6">
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">政治面貌</span>
										<input id="addpoliticaltext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">毕业学院</span>
										<input id="addgraduatetext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">教龄</span> <input
											id="addteagetext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">职务</span> <input
											id="addposttext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">学院</span> <input
											id="adddeparttext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">专业</span> <input
											id="addprofessiontext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">行政班级</span>
										<input id="addclasstext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">住址</span> <input
											id="addaddresstext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">联系电话</span>
										<input id="addteltext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">入学/入职日期</span>
										<input id="addenrolmenttext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">学费/薪资</span>
										<input id="addtuitiontext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
								</div>
								<div class="col-md-1"></div>
							</div>
							<div style="width:568px;">
								<div class="panel panel-default">
									<div class="panel-heading">其他信息</div>
									<div class="panel-body">
										<textarea id="adddetailtext" rows="6" cols="81"></textarea>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">关闭</button>
								<button id="confimodifybutton" type="button"
									class="btn btn-primary" onclick="adduser()">确认添加</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 添加用户信息 -->

			<div id="messagediv"
				style="position:absolute;top:225px;left:862px; width: 400px;height: 300px;display: none;">
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