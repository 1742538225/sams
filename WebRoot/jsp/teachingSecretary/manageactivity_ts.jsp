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
			clickactivitysubmit = function(){
				$("#activitysubmitdiv").css("display","block");
			};
			closeactivitysubmit = function(){
				$("#activitysubmitdiv").css("display","none");
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
				<div class="row" style="height:15px"></div>
				<div class="row">
					<div class="col-md-1"></div>
					<div class="col-md-10">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title ">学生教师相关教学活动</h3>
							</div>
							<div class="panel-body">
								<button class="btn btn-default" id="s_adjustlesson"
									onclick="adjustlessondiv()">发布调课通知</button>
								<button class="btn btn-default" id="s_adjustlesson"
									onclick="adjustlessondiv()">教师信息更改申请提交</button>
							</div>
						</div>

						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">其他教学活动</h3>
							</div>
							<div class="panel-body">
								<button class="btn btn-default" id="o_activity"
									onclick="clickmanageactivity('')">本系课程上报</button>
								<button class="btn btn-default" id="o_activity"
									onclick="clickactivitysubmit()">教学活动申请</button>
							</div>
						</div>
					</div>
					<div class="col-md-1"></div>
				</div>

				<!-- 发布调课通知begin -->
				<div id="optionviewdiv"
					style="background-color:#EEE8AA ;position:absolute;top:45px;left:210px; width: 458px;height: 420px;display:none; ">
					<div class="col-md-2"></div>
					<div class="col-md-8" align="center">
						<h3>发布调课通知(学生)</h3>
					</div>
					<div class="col-md-2" align="right">
						<br>
						<button class="btn btn-danger" onclick="closeadjustlesson()">关闭</button>
					</div>
					<div class="col-md-1"></div>
					<div class="col-md-10">
						<table id="tablelessontable" class="table">
							<tr>
								<td><font face="微软雅黑" size="4"> 通知:<br>
									<input id="teachername" type="text" disabled="true">老师的
										<input id="oldlessonid" type="text" placeholder="原课程号"
										style="width:80px" onblur="loadoldlesson()"> <input
										id="oldlessonname" type="text" disabled="true"> 原上课时间
										<input id="oldlessontime" type="text" style="width:280px;"><br>
										调至<br>第 <input id="newweeks" type="text" placeholder="周数">
										周,<br>周 <input id="newweekday" type="text"
										placeholder="周几">,<br>第 <input id="newlessonnum"
										type="text" placeholder="节数"> 节.<br>请知悉! </font></td>
							</tr>
						</table>
						<button class="btn btn-info"
							onclick="announceadjustlessonmessage()">发布通知</button>
					</div>
					<div class="col-md-1"></div>
				</div>
				<!-- 发布调课通知end -->

				<!-- 申请教学活动begin -->
				<div id="activitysubmitdiv"
					style="background-color:#EEE8AA ;position:absolute;top:45px;left:210px; width: 500px;height: 355px;display:none; ">
					<div class="row">
						<div class="col-md-2"></div>
						<div class="col-md-8" align="center">
							<h3>申请教学活动</h3>
						</div>
						<div class="col-md-2" align="right">
							<br>
							<button class="btn btn-danger" onclick="closeactivitysubmit()">关闭</button>
						</div>
					</div>
					<div class="row">
						<div class="col-md-1"></div>
						<div class="col-md-10">
							<div class="row">
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">活动名称:</span>
									<input id="nametext" type="text" class="form-control"
										aria-describedby="basic-addon1">
								</div>
							</div>
							<div class="row">
								<h4>活动内容</h4>
								<textarea id="bodytext" rows="8" cols="65"></textarea>
							</div>
							<button class="btn btn-info" onclick="activitysubmit()">申请</button>
						</div>
						<div class="col-md-1"></div>
					</div>
				</div>
				<!-- 申请教学活动end -->

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