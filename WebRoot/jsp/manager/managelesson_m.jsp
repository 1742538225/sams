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
						class="glyphicon glyphicon-home"> 首页</a></li>
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
					<div class="col-md-2">
						<select id="selectlessontype" name="selectlessontype"
							class="form-control" runat="server">
							<option>-课程类型-</option>
							<c:forEach items="${lessontypeList}" var="lessontype">
								<option>${lessontype.d_name }</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-2">
						<select id="selecttedepart" name="selecttedepart"
							class="form-control" runat="server">
							<option>-开设学院-</option>
							<c:forEach items="${departList }" var="tedepart">
								<option>${tedepart.d_name }</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-2">
						<select id="selectlevel" name="selectlevel" class="form-control"
							runat="server">
							<option>-开放年级-</option>
							<c:forEach items="${levelList}" var="level">
								<option>${level.d_name }</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-5">
						<div class="input-group">
							<input id="findtext" name="findtext" type="text"
								class="form-control" placeholder="请输入课程编号或课程名..."> <span
								class="input-group-btn">
								<button class="btn btn-default" type="submit"
									onclick="selectcoursebycondition()">搜索</button> </span>
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
					<table id="coursetable" class="table table-bordered"
						style=" white-space:nowrap">
						<tr align="center">
							<td>操作</td>
							<td>ID</td>
							<td>课程名</td>
							<td>课程类型</td>
							<td>上课节数</td>
							<td>上课周数</td>
							<td>上课地点</td>
							<td>任课教师</td>
							<td>上课时间(周几)</td>
							<td>开放年级</td>
							<td>开放学院</td>
							<td>开放专业</td>
							<td>开设学院</td>
							<td>学分</td>
							<td>已占人数</td>
							<td>总容量</td>
							<td>课程状态</td>
						</tr>
						<c:forEach items="${ courseList}" var="course">
							<tr>
								<td>
									<button id="modifybutton" class="btn btn-info"
										onclick="modifycoursediv('${course.co_id}')"
										data-toggle="modal" data-target="#modifymodal">修改</button>
									<button id="deletebutton" class="btn btn-danger"
										onclick="deletecourse('${course.co_id}')">删除</button></td>
								<td>${course.co_id }</td>
								<td>${course.co_name }</td>
								<td>${course.co_type }</td>
								<td>${course.co_lessonnum }</td>
								<td>${course.co_weeks }</td>
								<td>${course.co_place }</td>
								<td>${course.co_teacher }</td>
								<td>${course.co_weekday }</td>
								<td>${course.co_grade }</td>
								<td>${course.co_depart }</td>
								<td>${course.co_profession }</td>
								<td>${course.co_tedepart }</td>
								<td>${course.co_credit }</td>
								<td>${course.co_occupy }</td>
								<td>${course.co_content }</td>
								<td>${course.co_state }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="row">
					<nav>
						<ul id="pagecounts" class="pagination">
							<c:forEach begin="0" end="${pagecount }" varStatus="loop">
								<li><a href="#" onclick="courseselectpage(${loop.count})">${loop.count
										}<span class="sr-only"></span> </a>
								</li>
							</c:forEach>
						</ul>
					</nav>
				</div>

				<!-- 修改课程信息 -->
				<div class="modal fade" id="modifymodal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" style="top:180px;">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
								<h4 class="modal-title" id="myModalLabel">修改课程信息</h4>
							</div>
							<div class="modal-body">
								<div class="row">
									<div class="col-md-6">
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程ID</span>
											<input id="idtext" type="text" class="form-control"
												disabled="true" aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程名</span>
											<input id="nametext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程类型</span>
											<input id="typetext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程节数</span>
											<input id="lessonnumtext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程周数</span>
											<input id="weekstext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程地点</span>
											<input id="placetext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">任课教师</span>
											<input id="teachertext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程时间(周几)</span>
											<input id="weekdaytext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
									</div>
									<div class="col-md-6">
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">开放年级</span>
											<input id="leveltext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">开放学院</span>
											<input id="departtext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">开放专业</span>
											<input id="professiontext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">开设学院</span>
											<input id="tedeparttext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程学分</span>
											<input id="credittext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">已占人数</span>
											<input id="occupytext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程容量</span>
											<input id="contenttext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程状态(1可选,0禁选)</span>
											<input id="statetext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">关闭</button>
								<button id="confimodifybutton" onclick="modifycourse()" type="button"
									class="btn btn-primary">确认修改</button>
							</div>
						</div>
					</div>
				</div>
				<!-- 修改课程信息 -->

				<!-- 添加课程信息 -->
				<div class="modal fade" id="addmodal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" style="top:180px;">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
								<h4 class="modal-title" id="myModalLabel">添加课程</h4>
							</div>
							<div class="modal-body">
								<div class="row">
									<div class="col-md-6">
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程名称</span>
											<input id="addnametext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程类型</span>
											<input id="addtypetext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程节数</span>
											<input id="addlessonnumtext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程周数</span>
											<input id="addweekstext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程地点</span>
											<input id="addplacetext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">任课教师</span>
											<input id="addteachertext" type="text" class="form-control"
												aria-describedby="basic-addon1" onblur="checkteacher()">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程时间(周几)</span>
											<input id="addweekdaytext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">开放年级</span>
											<input id="addleveltext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
									</div>
									<div class="col-md-6">
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">开放学院</span>
											<input id="adddeparttext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">开放专业</span>
											<input id="addprofessiontext" type="text"
												class="form-control" aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">开设学院</span>
											<input id="addtedeparttext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程学分</span>
											<input id="addcredittext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">已占人数</span>
											<input id="addoccupytext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="row" style="height:34px;">
											<span id="teacherspan"></span>
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程容量</span>
											<input id="addcontenttext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">课程状态(1:可选,0:不可选)</span>
											<input id="addstatetext" type="text" class="form-control"
												aria-describedby="basic-addon1">
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">关闭</button>
								<button onclick="addcourse()" type="button"
									class="btn btn-primary">确认添加</button>
							</div>
						</div>
					</div>
				</div>
				<!-- 添加课程信息 -->

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