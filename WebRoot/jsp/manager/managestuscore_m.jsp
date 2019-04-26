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
					<div class="col-md-1"></div>
					<div class="col-md-2">
						<select id="selectdepart" class="form-control">
							<option>-选择学院-</option>
							<c:forEach items="${departDic }" var="depart">
								<option>${depart.d_name }</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-2">
						<select id="selectlevel" class="form-control">
							<option>-选择年级-</option>
							<c:forEach items="${levelDic }" var="level">
								<option>${level.d_name }</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-4">
						<div class="input-group">
							<input id="findtext" name="findtext" type="text"
								class="form-control" placeholder="输入课程ID或者学生ID ..."> <span
								class="input-group-btn">
								<button class="btn btn-default" type="submit"
									onclick="selectlessonByCondition()">搜索</button> </span>
						</div>
					</div>
					<div class="col-md-3">
						<button class="btn btn-success" data-target="#addscoremodal"
							data-toggle="modal">添加课程/成绩</button>
					</div>
				</div>
				<div class="row" style="height:5px;"></div>
				<div class="row"
					style="height:666px;overflow: scroll;overflow-x: hidden;">
					<table id="scoretable" class="table table-bordered"
						style=" white-space:nowrap;">
						<tr align="center">
							<td style="width:20px;">操作</td>
							<td>ID</td>
							<td>课程ID</td>
							<td>课程名称</td>
							<td>学生ID</td>
							<td>学生姓名</td>
							<td>课程分数</td>
							<td>学生评教</td>
						</tr>
						<c:forEach items="${ lessonList}" var="lesson" varStatus="loop">
							<tr>
								<td>
									<button id="modifybutton" class="btn btn-info"
										onclick="modifyscoreback('${lesson.l_id}')"
										data-target="#modifyscoremodal" data-toggle="modal">修改</button>
									<button id="deletebutton" class="btn btn-danger"
										onclick="deletescore('${lesson.l_id}')">删除</button>
								</td>
								<td>${lesson.l_id }</td>
								<td>${lesson.l_co_id }</td>
								<td>${course[loop.count-1]}</td>
								<td>${lesson.l_u_id }</td>
								<td>${student[loop.count-1]}</td>
								<td>${lesson.l_score }</td>
								<td>${lesson.l_evaluate }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="row">
					<nav>
						<ul id="pagecounts" class="pagination">
							<c:forEach begin="0" end="${pagecount }" varStatus="loop">
								<li><a href="#" onclick="selectscorepage(${loop.count})">${loop.count
										}<span class="sr-only"></span> </a>
								</li>
							</c:forEach>
						</ul>
					</nav>
				</div>

				<!-- 修改学生课程成绩信息 -->
				<div class="modal fade" id="modifyscoremodal" tabindex="-1"
					role="dialog" aria-labelledby="myModalLabel" style="top:180px;">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
								<h4 class="modal-title" id="myModalLabel">修改学生课程成绩信息</h4>
							</div>
							<div class="modal-body">
								<div class="row">
									<div class="col-md-6">
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1"
												disable="true">ID</span> <input id="idtext" type="text"
												class="form-control" aria-describedby="basic-addon1">
										</div>
										<div class="input-group ">
											<span class="input-group-addon" id="basic-addon1">课程ID</span>
											<input id="coidtext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group ">
											<span class="input-group-addon" id="basic-addon1">学生ID</span>
											<input id="stuidtext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程分数</span>
											<input id="scoretext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div style="width:568px;">
											<div class="panel panel-default">
												<div class="panel-heading">学生评教</div>
												<div class="panel-body">
													<textarea id="evaluatetext" rows="6" cols="81"></textarea>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-6"></div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">关闭</button>
								<button id="confimodifybutton" onclick="modifyscore()"
									type="button" class="btn btn-primary">确认修改</button>
							</div>
						</div>
					</div>
				</div>
				<!-- 修改学生课程成绩信息 -->

				<!-- 添加学生课程成绩 -->
				<div class="modal fade" id="addscoremodal" tabindex="-1"
					role="dialog" aria-labelledby="myModalLabel" style="top:180px;">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
								<h4 class="modal-title" id="myModalLabel">添加学生课程与成绩</h4>
							</div>
							<div class="modal-body row">
								<div class="col-md-6">
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">课程ID</span>
										<input id="addcoidtext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">学生ID</span>
										<input id="addstuidtext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div class="input-group">
										<span class="input-group-addon" id="basic-addon1">课程分数</span>
										<input id="addscoretext" type="text" class="form-control"
											aria-describedby="basic-addon1">
									</div>
									<div style="width:568px;">
										<div class="panel panel-default">
											<div class="panel-heading">学生评教信息</div>
											<div class="panel-body">
												<textarea id="addevaluatetext" rows="6" cols="81"></textarea>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6"></div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">关闭</button>
								<button onclick="addscore()" type="button"
									class="btn btn-primary">确认添加</button>
							</div>
						</div>
					</div>
				</div>
				<!-- 添加学生课程成绩 -->

				<div id="messagediv"
					style="position:absolute;top:90px;left:538px; width: 400px;height: 300px;display: none;">
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