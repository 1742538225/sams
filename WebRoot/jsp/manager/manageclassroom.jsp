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
					<div class="col-md-5">
						<div class="input-group">
							<input id="findtext" name="findtext" type="text"
								class="form-control" placeholder="请输入教室编号或教室名称..."> <span
								class="input-group-btn">
								<button class="btn btn-default"
									onclick="selectclassroombycondition()">搜索</button> </span>
						</div>
					</div>
					<div class="col-md-1">
						<button class="btn btn-success" data-target="#addmodal"
							data-toggle="modal">添加</button>
					</div>
				</div>
				<div class="row" style="height:5px;"></div>
				<div class="row"
					style="height:666px;overflow: scroll;overflow-y: hidden;">
					<table id="classroomtable" class="table table-bordered"
						style=" white-space:nowrap">
						<tr align="center">
							<td>操作</td>
							<td>ID</td>
							<td>课程ID</td>
							<td>教室名称</td>
							<td>教室状态</td>
						</tr>
						<c:forEach items="${classRoomList}" var="classRoom">
							<tr>
								<td style="width:30px">
									<button id="modifybutton" class="btn btn-info" type="button"
										data-toggle="modal" data-target="#modifymodal"
										onclick="modifyclassroommodal('${classRoom.c_id }')">修改</button>
									<button id="deletebutton" class="btn btn-danger"
										onclick="deleteclassroom('${classRoom.c_id }')">删除</button>
								</td>
								<td>${classRoom.c_id }</td>
								<td>${classRoom.c_co_id }</td>
								<td>${classRoom.c_name }</td>
								<td>${classRoom.c_state }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="row">
					<nav>
						<ul id="pagecounts" class="pagination">
							<c:forEach begin="0" end="${pagecount }" varStatus="loop">
								<li><a href="#" onclick="classroompage(${loop.count})">${loop.count
										}<span class="sr-only"></span> </a></li>
							</c:forEach>
						</ul>
					</nav>
				</div>

				<!-- 修改教室信息 -->
				<div class="modal fade" id="modifymodal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" style="top:180px;">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
								<h4 class="modal-title" id="myModalLabel">修改信息</h4>
							</div>
							<div class="modal-body">
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">课程ID</span> <input
										id="coidtext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">教室名称</span> <input
										id="nametext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">教室状态</span> <input
										id="statetext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">关闭</button>
								<button onclick="modifyclassroom()" type="button"
									class="btn btn-primary">确认修改</button>
							</div>
						</div>
					</div>
				</div>
				<!-- 修改教室信息 -->

				<!-- 添加教室信息 -->
				<div class="modal fade" id="addmodal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" style="top:180px;">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
								<h4 class="modal-title" id="myModalLabel">添加教室</h4>
							</div>
							<div class="modal-body">
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">课程ID</span> <input
										id="addcoidtext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">教室名称</span> <input
										id="addnametext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">教室状态</span> <input
										id="addstatetext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">关闭</button>
								<button onclick="addclassroom()" type="button"
									class="btn btn-primary">确认添加</button>
							</div>
						</div>
					</div>
				</div>
				<!-- 添加教室信息 -->

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