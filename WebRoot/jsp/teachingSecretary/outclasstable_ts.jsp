<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			closetablelesson = function(){
				$("#tablelessondiv").css("display","none");
			}
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
							教学综合信息服务平台教学秘书端</b>
					</font>
				</h1>
			</div>
			<div class="col-md-2 hidden-sm hidden-xs" align="right">
				<br>
				<br>
				<br> <font color="#122B40">By <a
					href="http://www.baidu.com">WuZhengHua</a> </font>
			</div>
		</div>
		<div class="row" style="background: black; height: 24px;"
			align="center">
			<div class="col-md-6"></div>
			<div class="col-md-4" align="right">
				<font color="white" class="glyphicon glyphicon-user">
					欢迎${user.u_depart}教学秘书 ${user.u_name }</font> <input id="userid"
					type="hidden" value="${user.u_id }" name="userid">
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="row" style="height: 790px;">
			<div class="col-md-2" align="left">
				<ul class="nav nav-pills nav-stacked" align="left">
					<li role="presentation" class="active"><a
						href="${pageContext.request.contextPath}/user/index_ts.action?u_id=${user.u_id}"
						class="glyphicon glyphicon-home"> 首页</a></li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/individual_ts.action?u_id=${user.u_id}">个人信息</a>
					</li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/managelesson_ts.action?u_id=${user.u_id}">管理本系课程</a>
					</li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/outclasstable_ts.action?u_id=${user.u_id}">课表打印</a>
					</li>
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/manageactivity_ts.action?u_id=${user.u_id}">管理教学活动</a>
					</li>
				</ul>
			</div>
			<div class="col-md-9" style="background: white;height: 770px;"
				align="center">

				<!-- 课表内容页面 -->
				<div class="panel-group" id="accordion" role="tablist"
					aria-multiselectable="true">
					<c:forEach items="${professionList }" var="profession">
						<div class="panel panel-default">
							<div class="panel-heading" role="tab"
								id="heading${profession.p_id }">
								<h4 class="panel-title">
									<a class="collapsed"
										onclick="loadstudent('${profession.p_name }')"
										data-toggle="collapse" data-parent="#accordion"
										href="#collapse${profession.p_id }" aria-expanded="false"
										aria-controls="collapse${profession.p_id }">
										${profession.p_name } </a>
								</h4>
							</div>
							<div id="collapse${profession.p_id }"
								class="panel-collapse collapse" role="tabpanel"
								aria-labelledby="heading${profession.p_id }">
								<div class="panel-body">
									<div class="row">
										<div class="col-md-1"></div>
										<div class="col-md-10"
											style="overflow:scroll;overflow-x:hidden;">
											<table class="table" id="studenttable${profession.p_name }">

											</table>
										</div>
									</div>
									<div class="row">
										<button class="btn btn-default  glyphicon glyphicon-print"
											onclick="return alert('请连接打印机确保并确保机器无故障!')">打印</button>
									</div>

								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<!-- 课表内容页面 -->

				<div id="tablelessondiv"
					style="background-color:#EEE8AA ;position:absolute;top:53px;left:10px; width: 858px;height: 640px;display:none; ">
					<div class="col-md-4"></div>
					<div class="col-md-4" align="center">
						<h3>
							<span id="usernamespan"></span>
						</h3>
					</div>
					<div class="col-md-4" align="center">
						<br>
						<button class="btn btn-info glyphicon glyphicon-print"
							onclick="return alert('请连接打印机确保并确保机器无故障!')">打印课表</button>
						<button class="btn btn-danger" onclick="closetablelesson()">关闭</button>
					</div>
					<div class="col-md-1"></div>
					<div class="col-md-10">
						<table id="tablelessontable" class="table">

						</table>
					</div>
					<div class="col-md-1"></div>
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
					<button type="button"
						class="btn btn-default glyphicon glyphicon-envelope"
						style="text-decoration: none;" value="消息" onclick="clickmessage()">
						<span class="badge" id="unreadcount">0</span>
					</button>
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