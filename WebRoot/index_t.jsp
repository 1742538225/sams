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
							教学综合信息服务平台教师端</b> </font>
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
				<font color="white" class="glyphicon glyphicon-user"> 欢迎
					${user.u_name } 老师</font> <input id="userid" type="hidden"
					value="${user.u_id }" name="userid">
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
			<div class="col-md-9" style="background: black;height: 770px;"
				align="center">
				<div id="carousel-example-generic" class="carousel slide"
					data-ride="carousel">
					<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#carousel-example-generic" data-slide-to="0"
							class="active"></li>
						<li data-target="#carousel-example-generic" data-slide-to="1"></li>
						<li data-target="#carousel-example-generic" data-slide-to="2"></li>
					</ol>

					<!-- Wrapper for slides -->
					<div class="carousel-inner" role="listbox">
						<div class="item active">
							<img src="${pageContext.request.contextPath}/img/lunbotu1.png"
								alt="...">
							<div class="carousel-caption">...</div>
						</div>
						<div class="item">
							<img src="${pageContext.request.contextPath}/img/lunbotu2.png"
								alt="...">
							<div class="carousel-caption">...</div>
						</div>
						<div class="item">
							<img src="${pageContext.request.contextPath}/img/lunbotu3.png"
								alt="...">
							<div class="carousel-caption">...</div>
						</div>
					</div>

					<!-- Controls -->
					<a class="left carousel-control" href="#carousel-example-generic"
						role="button" data-slide="prev"> <span
						class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						<span class="sr-only">Previous</span> </a> <a
						class="right carousel-control" href="#carousel-example-generic"
						role="button" data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">Next</span> </a>
				</div>

				<div id="messagediv"
					style="position:absolute;top:93px;left:538px; width: 400px;height: 300px;display: none;">
					<iframe id="messageiframe" class="embed-responsive-item"
						style=" width: 400px;height: 300px; "
						src="${pageContext.request.contextPath }/jsp/message.jsp"></iframe>
				</div>

				<table class="table">
					<tr>
						<td>
							<h4>
								<font color="white">公告</font>
							</h4>
						</td>
						<td></td>
					</tr>
					<tr>
						<td><a href="#"> 关于开展第十届立邦杯“化学改变生活”主题 </a>
						</td>
						<td align="right">2019-03-19</td>
					</tr>
					<tr>
						<td><a href="#"> 关于开展第十届立邦杯“化学改变生活”主题 </a>
						</td>
						<td align="right">2019-03-19</td>
					</tr>
					<tr>
						<td><a href="#"> 关于开展第十届立邦杯“化学改变生活”主题 </a>
						</td>
						<td align="right">2019-03-19</td>
					</tr>
					<tr>
						<td><a href="#"> 关于开展第十届立邦杯“化学改变生活”主题 </a>
						</td>
						<td align="right">2019-03-19</td>
					</tr>

					<tr>
						<td><a href="#">...</a>
						</td>
					</tr>
				</table>

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