/*传统JS，Ajax异步加载
function ajaxFunction(){
			   var xmlHttp;
			   try{ // Firefox, Opera 8.0+, Safari
			        xmlHttp=new XMLHttpRequest();
			    }
			    catch (e){
				   try{// Internet Explorer
				         xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
				      }
				    catch (e){
				      try{
				         xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
				      }
				      catch (e){}
				      }
			    }
				return xmlHttp;
			 }
			 
			function checkUserId(){
			 	//获取input的值
			 	var userId = document.getElementById("userId").value;
			 	
			 	//1.创建对象
			 	var request = ajaxFunction();
			 	
			 	//2.发送请求
			 	request.open("POST","/sams/user/selectId.action",true);
			 	request.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			 	request.send("userId="+userId);
			 	
			 	//注册状态改变监听,获取服务器传过来的数据
			 	request.onreadystatechange = function(){
			 		if(request.readyState == 4&&request.status == 200){
			 			var data = request.responseText;
			 			if(data==0){
			 				document.getElementById("usernamespan").innerHTML="<font class='glyphicon glyphicon-remove' color='red'>用户名不存在</font>";
			 			}else if(data==1){
			 				document.getElementById("usernamespan").innerHTML="<font class='glyphicon glyphicon-ok' color='green'>用户名存在</font>";
			 			}
			 		}	
			 	}
			 }
			 
	function checkLogin(){
				//获取input的值
			 	var userId = document.getElementById("userId").value;
			 	var password = document.getElementById("password").value;
			 	
			 	//1.创建对象
			 	var checkLogin = ajaxFunction();
			 	
			 	//2.发送请求
			 	checkLogin.open("POST","/sams/user/checklogin.action",true);
			 	checkLogin.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			 	checkLogin.send("userId="+userId+"&password="+password);
			 	
			 	//注册状态改变监听,获取服务器传过来的数据
			 	checkLogin.onreadystatechange = function(){
			 		if(checkLogin.readyState == 4&&checkLogin.status == 200){
			 			var data = checkLogin.responseText;
			 			if(data==1){
			 				document.getElementById("form1").submit();
			 			}else{
			 				alert("登陆失败，密码错误！");
			 			}
			 		}	
			 	}
			}*/

checkUserId = function() {
	// $("#userId") 相当于 document.getElementById("userId") .val()相当于.value
	var userId = $("#userId").val();
	$
			.post(
					"/sams/user/selectId.action",
					{
						// json语法 传过去servlet的变量名：传过去的值
						userId : userId
					},
					function(data, status) {
						// .html .val .text三种改变jsp页面相关值的方法
						if (data == 1)
							$("#usernamespan")
									.html(
											"<font class='glyphicon glyphicon-ok' color='green'>用户名存在</font>");
						else
							$("#usernamespan")
									.html(
											"<font class='glyphicon glyphicon-remove' color='red'>用户名不存在</font>");
					});
};

// 登录页-登陆验证
checkLogin = function() {
	var userId = $("#userId").val();
	var password = $("#password").val();
	$.post("/sams/user/checklogin.action", {
		// json语法 传过去servlet的变量名：传过去的值
		userId : userId,
		password : password
	}, function(data, status) {
		if (data == 1)
			$("#form1").submit();
		else
			alert("登录失败，密码错误！");
	});
};

// 教师-保存成绩
recordscore = function(u_id, co_id) {
	var score = $("#" + u_id + co_id).val();
	var userid = $("#userid").val();
	$.post("/sams/score/updatescore.action", {
		userid : userid,
		u_id : u_id,
		co_id : co_id,
		score : score
	}, function(data, status) {
		if ($("#updatescore" + u_id + co_id).val() == "修改") {
			alert("已成功修改！");
		}
		if (data == 1) {
			$("#updatescore" + u_id + co_id).val("修改");
			$("#updatescore" + u_id + co_id).removeClass("btn-default");
			$("#updatescore" + u_id + co_id).addClass("btn-success");
		}
	});
};

// 学生-选课
selectclass = function(co_id) {
	var userid = $("#userid").val();
	var confi = confirm("确认选择该课程?");
	if (confi == true)
		$.post("/sams/course/selectCourse.action", {
			userid : userid,
			co_id : co_id
		}, function(data, status) {
			if (data == 0) {
				// 课表占满
				alert("由于当前选课与课表冲突，选课失败！");
			} else if (data == 1) {
				// 课程无容量
				alert("该课程暂无容量，选课失败！");
			} else {
				$("#" + co_id).removeClass("btn-default");
				$("#" + co_id).addClass("btn-success");
				$("#" + co_id).addClass(" glyphicon glyphicon-ok");
				$("#" + co_id).val("已选");
				$("#" + co_id).attr("disabled", true);
			}
		});
};

// 学生--评教提交
evaluatesubmit = function(co_id) {
	var confi = confirm("确认提交吗?");
	var evaluatebody = $("#evaluatebody").val();
	if (confi == true)
		$.ajax({
			type : "POST",
			url : "/sams/user/evaluatesubmit.action",
			dataType : "html",
			data : {
				'evaluatebody' : evaluatebody,
				'co_id' : co_id
			},
			success : function(data) {
				alert("成功提交!");
			}
		});
};

// 消息提示
messageremind = function() {
	$.post("/sams/message/messagecount.action", {

	}, function(data, status) {
		$("#unreadcount").html(data);
	}, "html");
};

// 消息查看
clickmessage = function() {
	var userid = $("#userid").val();
	if ($("#messagediv").css("display") == "none") {
		$("#messagediv").css("display", "block");
	} else {
		$("#messagediv").css("display", "none");
	}
	$("#messageiframe").attr("src", "/sams/jsp/message.jsp");
};

// 消息加载
messageload = function() {
	$.post("/sams/message/messageload.action", {

	}, function(data, status) {
		con = "<tr><td></td><td>类型</td><td>内容</td><td>来源</td><td></td></tr>";
		$(data).each(
				function(index, item) {
					con += "<tr>";
					con += "<td></td>";
					con += "<td><font color='red'>" + item.m_type
							+ "</font></td>";
					con += "<td>" + item.m_body + "</td>";
					con += "<td>" + item.m_source + "</td>";
					con += "<td><a href='#' onclick='readmessage(" + item.m_id
							+ ")'>已读</a></td>";
					con += "<td><a href='#'  onclick='deletemessage("
							+ item.m_id + ")'>删除</a></td>";
					if (item.m_state == 0)
						con += "<td><span class='badge'>1</span></td>";
					con += "<td></td>";
					con += "</tr>";
				});
		$("#messagetable").html(con);
	}, "json");
};

// 读取消息
readmessage = function(m_id) {
	$.post("/sams/message/messageread.action", {
		m_id : m_id
	}, function(data, status) {
		messageload();
		messageremind();
	});
};

// 删除信息
deletemessage = function(m_id) {
	var confi = confirm("是否删除此条消息？");
	if (confi == true)
		$.post("/sams/message/messagedelete.action", {
			m_id : m_id
		}, function(data, status) {
			messageload();
			messageremind();
		});
};

// 一键清除已读消息
clean = function() {
	var confi = confirm("确认清除所有已读消息?");
	if (confi == true)
		$.post("/sams/message/messageclear.action", {}, function() {
			messageremind();
			messageload();
			alert("成功清除已读消息！");
		});
};

// 用户--修改密码弹窗
clickmodifypassword = function() {
	$("#modifypassworddiv").css("display", "block");
};

// 用户--关闭修改密码弹窗
closemodifypassword = function() {
	$("#modifypassworddiv").css("display", "none");
};

// 用户--确认重复密码是否一致
confipassword = function() {
	var newpasswordtext = $("#newpasswordtext").val();
	var againpasswordtext = $("#againpasswordtext").val();
	if (newpasswordtext != againpasswordtext) {
		$("#confimodifypassword").attr("disabled", "disabled");
		$("#confispan")
				.html(
						"<font class='glyphicon glyphicon-remove' color='red'>两次输入的密码不一致</font>");
	} else {
		$("#confimodifypassword").removeAttr("disabled");
		$("#confispan")
				.html(
						"<font class='glyphicon glyphicon-ok' color='green'>可以使用该密码</font>");
	}

};

// 用户--修改密码
modifypassword = function() {
	var passwordtext = $("#passwordtext").val();
	var newpasswordtext = $("#newpasswordtext").val();
	var confi = confirm("确认修改密码?");
	if (confi == true)
		$.ajax({
			type : "POST",
			url : "/sams/user/modifypassword.action",
			data : {
				passwordtext : passwordtext,
				newpasswordtext : newpasswordtext
			},
			dataType : "html",
			success : function(data) {
				if (data == 1) {
					alert("修改成功!");
					$("#modifypassworddiv").css("display", "none");
					$("#passwordtext").val("");
					$("#newpasswordtext").val("");
					$("#againpasswordtext").val("");
				} else
					alert("请输入正确的原密码!");
			}
		});
};

// 教师点名册加载
clickrollbookitem = function(co_id, u_id) {
	$
			.post(
					"/sams/rollbook/selectrollbook.action",
					{
						co_id : co_id,
						u_id : u_id
					},
					function(data, status) {
						con = "";
						con = "<tr><td>学号</td><td>姓名</td><td>学院</td><td>专业</td><td>行政班级</td></tr>";
						var length = 0;
						$(data).each(function(index, item) {
							con = con + "<tr></tr>";
							con = con + "<td>" + item.u_id + "</td>";
							con = con + "<td>" + item.u_name + "</td>";
							con = con + "<td>" + item.u_depart + "</td>";
							con = con + "<td>" + item.u_profession + "</td>";
							con = con + "<td>" + item.u_class + "</td>";
							con = con + "<tr></tr>";
							length++;
						});
						$("#rollbooktable" + co_id).html(con);
						$("#classnum" + co_id).text("班级人数: " + length + " |");
					}, "json");
};

// 教师--查看其它教师课表
findclasstable = function() {
	var findtext = $("#findtext").val();
	$
			.ajax({
				type : "POST",
				url : "/sams/course/findclasstable.action",
				dataType : "json",
				data : {
					findtext : findtext
				},
				success : function(data) {
					var con = "<tr><td></td><td>周一</td><td>周二</td><td>周三</td><td>周四</td><td>周五</td><td>周六</td><td>周日</td></tr>";
					$(data).each(function(i, n) {
						if (i == 0)
							con = con + "<tr><td>1-2节</td>";
						else if (i == 1)
							con = con + "<tr><td>3-4节</td>";
						else if (i == 2)
							con = con + "<tr><td>5-6节</td>";
						else if (i == 3)
							con = con + "<tr><td>7-8节</td>";
						else if (i == 4)
							con = con + "<tr><td>9-10节</td>";
						$(n).each(function(j, m) {
							con = con + "<td>" + m + "</td>";
						});
						con = con + "</tr>";
					});
					$("#lessontableid").html(con);
					$("#tablediv").html("<h2>教师" + findtext + "的教学课表</h2>");
				}
			});
};

// 教学秘书根据条件搜索课程
managelessonfind = function() {
	var selecttype = $("#selecttype").val();
	var findtext = $("#findtext").val();
	$
			.post(
					"/sams/course/managelessonfind.action",
					{
						selecttype : selecttype,
						findtext : findtext
					},
					function(data, status) {
						con = "<tr><td>编号</td><td>课程名称</td><td>类型</td><td>时间</td><td>上课地点</td><td>学分</td><td>教师编号</td><td>教师姓名</td><td>容量</td></tr>";
						$(data)
								.each(
										function(index, item) {
											con = con + "<tr>";
											con = con + "<td>" + item.co_id
													+ "</td>";
											con = con + "<td>" + item.co_name
													+ "</td>";
											con = con + "<td>" + item.co_type
													+ "</td>";
											con = con + "<td>" + item.co_weeks
													+ ",周" + item.co_weekday
													+ ",第" + item.co_lessonnum
													+ "节</td>";
											con = con + "<td>" + item.co_place
													+ "</td>";
											con = con + "<td>" + item.co_credit
													+ "</td>";
											con = con + "<td>"
													+ item.co_teacher + "</td>";
											con = con + "<td>"
													+ item.user.u_name
													+ "</td>";
											con = con + "<td>" + item.co_occupy
													+ "/" + item.co_content
													+ "</td>";
											con = con + "</tr>";
										});
						$("#managelessontable").html(con);
					}, "json");
};

// 教学秘书查看院所有学生
loadstudent = function(p_name) {
	$
			.post(
					"/sams/lesson/loadstudent.action",
					{
						p_name : p_name
					},
					function(data, status) {
						var con = " <tr><td></td><td>学号</td><td>姓名</td><td>行政班级</td><td align='center'>操作</td></tr>";
						$(data)
								.each(
										function(index, item) {
											con = con + "<tr>";
											con = con
													+ "<td><input type='checkbox'></td>";
											con = con + "<td>" + item.u_id
													+ "</td>";
											con = con + "<td>" + item.u_name
													+ "</td>";
											con = con + "<td>" + item.u_class
													+ "</td>";
											con = con
													+ "<td align='center'><button class='btn btn-info' onclick='loadclasstable(\""
													+ item.u_id + "\",\""
													+ item.u_name
													+ "\")'>查看课表</button></td>";
											con = con + "</tr>";
										});
						$("#studenttable" + p_name).html(con);
					}, "json");
};

// 教学秘书查看学生课表
loadclasstable = function(student_id, student_name) {
	$
			.post(
					"/sams/lesson/selectlessontablebyuid.action",
					{
						u_id : student_id
					},
					function(data, status) {
						var con = "<tr><td></td><td>周一</td><td>周二</td><td>周三</td><td>周四</td><td>周五</td><td>周六</td><td>周日</td></tr>";
						var lessonnum = 1;
						$(data).each(
								function(i, n) {
									con = con + "<tr>";
									con = con + "<td>" + lessonnum + ""
											+ (lessonnum + 1) + "节</td>";
									$(n).each(function(j, m) {
										con = con + "<td>" + m + "</td>";
									});
									con = con + "</tr>";
									lessonnum += 2;
								});
						$("#tablelessondiv").css("display", "block");
						$("#usernamespan").text(
								student_id + student_name + "的课表");
						$("#tablelessontable").html(con);
					}, "json");
};

// 教学秘书管理教学活动--显示调课通知区块div
adjustlessondiv = function() {
	$("#optionviewdiv").css("display", "block");
};

// 教学秘书管理教学活动--关闭调课通知区块div
closeadjustlesson = function() {
	$("#optionviewdiv").css("display", "none");
};

// 教学秘书管理教学活动--根据用户输入的课程编号加载课程
loadoldlesson = function() {
	var co_id = $("#oldlessonid").val();
	$.post("/sams/course/showcourse.action", {
		co_id : co_id
	}, function(data, status) {
		if (data == 0) {
			$("#teachername").val("");
			$("#oldlessonname").val("");
			$("#oldlessontime").val("");
			alert("找不到该课程!请确保输入的课程编号无误且为当前管理学院开设的课程!");
			$("#teachername").val(data.user.u_name);
		} else {
			$("#teachername").val(data.user.u_name);
			$("#oldlessonname").val(data.co_name);
			$("#oldlessontime").val(
					data.co_weeks + "周" + data.co_weekday + "," + "第"
							+ data.co_lessonnum + "节");
		}
	}, "json");
};

// 教学秘书管理教学活动--调课通知
announceadjustlessonmessage = function(u_name) {
	var confi = confirm("确定发送该通知?");
	var co_teacher = $("#teachername").val();
	var co_id = $("#oldlessonid").val();
	var co_name = $("#oldlessonname").val();
	var co_time = $("#oldlessontime").val();
	var co_weeks = $("#newweeks").val();
	var co_weekday = $("#newweekday").val();
	var co_lessonnum = $("#newlessonnum").val();
	var m_body = co_teacher + "老师的 " + co_id + " " + co_name + " 课程原上课时间为"
			+ co_time + ",调至 第" + co_weeks + "周,周" + co_weekday + " 第"
			+ co_lessonnum + "节,请知悉!";

	if (confi == true)
		$.post("/sams/message/adjustlesson.action", {
			co_id : co_id,
			m_body : m_body,
			m_type : "用户消息",
			m_source : u_name
		}, function(data, status) {
			$("#optionviewdiv").css("display", "none");
			alert("成功发送通知!");
		});

};

// 管理员--选择页数管理用户信息
selectpage = function(pagecount) {
	var selectidentify = $("#selectidentify").val();
	var selectdepart = $("#selectdepart").val();
	var findtext = $("#findtext").val();
	$
			.post(
					"/sams/user/selectuserbypagecount.action",
					{
						selectidentify : selectidentify,
						selectdepart : selectdepart,
						findtext : findtext,
						pagecount : pagecount
					},
					function(data, status) {
						var con = "<tr align='center'><td>操作</td><td>ID</td><td>密码</td><td>姓名</td><td>身份</td><td>证件类型</td><td>证件号</td><td>性别</td><td>年龄</td><td>年级</td><td>籍贯</td><td>生日</td><td>民族</td><td>政治面貌</td><td>毕业院校</td><td>教龄</td><td>职务</td><td>学院</td><td>专业</td><td>行政班级</td><td>住址</td><td>联系电话</td><td>入学/入职日期</td><td>学费/薪资</td><td>其他信息</td></tr>";
						$(data)
								.each(
										function(index, item) {
											con = con + "<tr>";
											con = con
													+ "<td><button id='modifybutton' class='btn btn-info' onclick=\"modifyuserdiv('"
													+ item.u_id
													+ "')\" class='btn btn-info' type='button' data-toggle='modal' data-target='#modifymodal'>修改</button><button id='deletebutton' class='btn btn-danger' onclick=\"deleteuser('"
													+ item.u_id
													+ "')\">删除</button></td>";
											con = con + "<td>" + item.u_id
													+ "</td>";
											con = con + "<td>"
													+ item.u_password + "</td>";
											con = con + "<td>" + item.u_name
													+ "</td>";
											con = con + "<td>"
													+ item.u_identify + "</td>";
											con = con + "<td>"
													+ item.u_credentials
													+ "</td>";
											con = con + "<td>" + item.u_code
													+ "</td>";
											con = con + "<td>" + item.u_sex
													+ "</td>";
											con = con + "<td>" + item.u_age
													+ "</td>";
											con = con + "<td>" + item.u_level
													+ "</td>";
											con = con + "<td>" + item.u_native
													+ "</td>";
											con = con
													+ "<td><fmt:formatDate value='"
													+ item.u_birthday
													+ "' pattern='yyyy-MM-dd' /></td>";
											con = con + "<td>" + item.u_fork
													+ "</td>";
											con = con + "<td>"
													+ item.u_political
													+ "</td>";
											con = con + "<td>"
													+ item.u_graduate + "</td>";
											con = con + "<td>" + item.u_teage
													+ "</td>";
											con = con + "<td>" + item.u_post
													+ "</td>";
											con = con + "<td>" + item.u_depart
													+ "</td>";
											con = con + "<td>"
													+ item.u_profession
													+ "</td>";
											con = con + "<td>" + item.u_class
													+ "</td>";
											con = con + "<td>" + item.u_address
													+ "</td>";
											con = con + "<td>" + item.u_tel
													+ "</td>";
											con = con
													+ "<td><fmt:formatDate value='"
													+ item.u_enrolment
													+ "' pattern='yyyy-MM-dd' /></td>";
											con = con + "<td>" + item.u_tuition
													+ "</td>";
											con = con + "<td>" + item.u_detail
													+ "</td>";
											con = con + "</tr>";
										});
						$("#usertable").html(con);
					}, "json");
};

// 教学秘书--申请教学活动
activitysubmit = function() {
	var nametext = $("#nametext").val();
	var bodytext = $("#bodytext").val();
	var confi = confirm("确认申请吗?");
	if (confi == true)
		$.ajax({
			type : "POST",
			url : "/sams/user/activitysubmit.action",
			dataType : "html",
			data : {
				nametext : nametext,
				bodytext : bodytext
			},
			success : function(data) {
				alert("申请成功!");
			}
		});
};

// 管理员--通过条件查询用户
selectuserbycondition = function() {
	var selectidentify = $("#selectidentify").val();
	var selectdepart = $("#selectdepart").val();
	var findtext = $("#findtext").val();
	$
			.post(
					"/sams/user/selectuserbycondition.action",
					{
						selectidentify : selectidentify,
						selectdepart : selectdepart,
						findtext : findtext
					},
					function(data, status) {
						var pagecounts = 1;
						var n = 0;
						var pagecon = "<li ><a href='#' onclick='selectpage(1)'>1<span class='sr-only'></span></a></li>";
						var con = "<tr align='center'><td>操作</td><td>ID</td><td>密码</td><td>姓名</td><td>身份</td><td>证件类型</td><td>证件号</td><td>性别</td><td>年龄</td><td>年级</td><td>籍贯</td><td>生日</td><td>民族</td><td>政治面貌</td><td>毕业院校</td><td>教龄</td><td>职务</td><td>学院</td><td>专业</td><td>行政班级</td><td>住址</td><td>联系电话</td><td>入学/入职日期</td><td>学费/薪资</td><td>其他信息</td></tr>";
						$(data)
								.each(
										function(index, item) {
											con = con + "<tr>";
											con = con
													+ "<td><button id='modifybutton' class='btn btn-info' onclick=\"modifyuserdiv('"
													+ item.u_id
													+ "')\" class='btn btn-info' type='button' data-toggle='modal' data-target='#modifymodal'>修改</button><button id='deletebutton' class='btn btn-danger' onclick=\"deleteuser('"
													+ item.u_id
													+ "')\">删除</button></td>";
											con = con + "<td>" + item.u_id
													+ "</td>";
											con = con + "<td>"
													+ item.u_password + "</td>";
											con = con + "<td>" + item.u_name
													+ "</td>";
											con = con + "<td>"
													+ item.u_identify + "</td>";
											con = con + "<td>"
													+ item.u_credentials
													+ "</td>";
											con = con + "<td>" + item.u_code
													+ "</td>";
											con = con + "<td>" + item.u_sex
													+ "</td>";
											con = con + "<td>" + item.u_age
													+ "</td>";
											con = con + "<td>" + item.u_level
													+ "</td>";
											con = con + "<td>" + item.u_native
													+ "</td>";
											con = con
													+ "<td><fmt:formatDate value='"
													+ item.u_birthday
													+ "' pattern='yyyy-MM-dd' /></td>";
											con = con + "<td>" + item.u_fork
													+ "</td>";
											con = con + "<td>"
													+ item.u_political
													+ "</td>";
											con = con + "<td>"
													+ item.u_graduate + "</td>";
											con = con + "<td>" + item.u_teage
													+ "</td>";
											con = con + "<td>" + item.u_post
													+ "</td>";
											con = con + "<td>" + item.u_depart
													+ "</td>";
											con = con + "<td>"
													+ item.u_profession
													+ "</td>";
											con = con + "<td>" + item.u_class
													+ "</td>";
											con = con + "<td>" + item.u_address
													+ "</td>";
											con = con + "<td>" + item.u_tel
													+ "</td>";
											con = con
													+ "<td><fmt:formatDate value='"
													+ item.u_enrolment
													+ "' pattern='yyyy-MM-dd' /></td>";
											con = con + "<td>" + item.u_tuition
													+ "</td>";
											con = con + "<td>" + item.u_detail
													+ "</td>";
											con = con + "</tr>";
											n++;
											if (n % 12 == 0 && n != 0) {
												pagecounts++;
												pagecon = pagecon
														+ "<li ><a href='#' onclick='selectpage("
														+ pagecounts
														+ ")'>"
														+ pagecounts
														+ "<span class='sr-only'></span></a></li>";
											}
										});
						$("#usertable").html(con);
						$("#pagecounts").html(pagecon);
					}, "json");
};

// 修改用户信息
modifyuser = function(u_id) {
	var u_password = $("#passwordtext").val();
	var u_name = $("#nametext").val();
	var u_identify = $("#identifytext").val();
	var u_credentials = $("#credentialstext").val();
	var u_code = $("#codetext").val();
	var u_sex = $("#sextext").val();
	var u_age = $("#agetext").val();
	var u_level = $("#leveltext").val();
	var u_native = $("#nativetext").val();
	var u_birthday = $("#birthdaytext").val();
	var u_fork = $("#forktext").val();
	var u_political = $("#politicaltext").val();
	var u_graduate = $("#graduatetext").val();
	var u_teage = $("#teage").val();
	var u_post = $("#posttext").val();
	var u_depart = $("#departtext").val();
	var u_profession = $("#professiontext").val();
	var u_class = $("#classtext").val();
	var u_address = $("#addresstext").val();
	var u_tel = $("#teltext").val();
	var u_enrolment = $("#enrolmenttext").val();
	var u_tuition = $("#tuitiontext").val();
	var u_detail = $("#detailtext").val();
	$.ajax({
		type : "POST",
		url : "/sams/user/modifyuser.action",
		contentType : "application/json", // 传递值类型
		dataType : "html", // 表示返回值类型
		data : JSON.stringify({
			'u_id' : u_id,
			'u_password' : u_password,
			'u_name' : u_name,
			'u_identify' : u_identify,
			'u_credentials' : u_credentials,
			'u_code' : u_code,
			'u_sex' : u_sex,
			'u_age' : u_age,
			'u_level' : u_level,
			'u_native' : u_native,
			'u_birthday' : u_birthday,
			'u_fork' : u_fork,
			'u_political' : u_political,
			'u_graduate' : u_graduate,
			'u_teage' : u_teage,
			'u_post' : u_post,
			'u_depart' : u_depart,
			'u_profession' : u_profession,
			'u_class' : u_class,
			'u_address' : u_address,
			'u_tel' : u_tel,
			'u_enrolment' : u_enrolment,
			'u_tuition' : u_tuition,
			'u_detail' : u_detail
		}), // 相当于 //data: "{'str1':'foovalue', 'str2':'barvalue'}",
		success : function(data) {
			alert("修改成功!");
			$("#modifydiv").css("display", "none");
		}
	});
};

// 管理员--删除用户
deleteuser = function(u_id) {
	var confi = confirm("是否删除该用户?");
	if (confi == true)
		$.ajax({
			type : "POST",
			url : "/sams/user/deleteuser.action",
			dataType : "html",
			data : {
				"u_id" : u_id
			},
			success : function(data) {
				alert("删除成功!");
			}
		});
};

// 管理员--添加用户检测id是否存在
checkuserid = function() {
	var u_id = $("#addidtext").val();
	if (u_id == "" || null == u_id)
		$("#useridifexistspan")
				.html(
						"<font class='glyphicon glyphicon-remove' color='red'>用户ID不能为空</font>");
	else
		$
				.ajax({
					type : "POST",
					url : "/sams/user/selectId.action",
					dataType : "html",
					data : {
						"userId" : u_id
					},
					success : function(data) {
						if (data == 0)
							$("#useridifexistspan")
									.html(
											"<font class='glyphicon glyphicon-ok' color='green'>用户ID可以使用</font>");
						else if (data == 1)
							$("#useridifexistspan")
									.html(
											"<font class='glyphicon glyphicon-remove' color='red'>用户ID已经存在</font>");
					}
				});
};

// 管理员--添加用户
adduser = function() {
	var u_id = $("#addidtext").val();
	var u_password = $("#addpasswordtext").val();
	var u_name = $("#addnametext").val();
	var u_identify = $("#addidentifytext").val();
	var u_credentials = $("#addcredentialstext").val();
	var u_code = $("#addcodetext").val();
	var u_sex = $("#addsextext").val();
	var u_age = $("#addagetext").val();
	var u_level = $("#addleveltext").val();
	var u_native = $("#addnativetext").val();
	var u_birthday = $("#addbirthdaytext").val();
	var u_fork = $("#addforktext").val();
	var u_political = $("#addpoliticaltext").val();
	var u_graduate = $("#addgraduatetext").val();
	var u_teage = $("#addteage").val();
	var u_post = $("#addposttext").val();
	var u_depart = $("#adddeparttext").val();
	var u_profession = $("#addprofessiontext").val();
	var u_class = $("#addclasstext").val();
	var u_address = $("#addaddresstext").val();
	var u_tel = $("#addteltext").val();
	var u_enrolment = $("#addenrolmenttext").val();
	var u_tuition = $("#addtuitiontext").val();
	var u_detail = $("#adddetailtext").val();
	$.ajax({
		type : "POST",
		url : "/sams/user/adduser.action",
		contentType : "application/json",
		dataType : "html",
		data : JSON.stringify({
			'u_id' : u_id,
			'u_password' : u_password,
			'u_name' : u_name,
			'u_identify' : u_identify,
			'u_credentials' : u_credentials,
			'u_code' : u_code,
			'u_sex' : u_sex,
			'u_age' : u_age,
			'u_level' : u_level,
			'u_native' : u_native,
			'u_birthday' : u_birthday,
			'u_fork' : u_fork,
			'u_political' : u_political,
			'u_graduate' : u_graduate,
			'u_teage' : u_teage,
			'u_post' : u_post,
			'u_depart' : u_depart,
			'u_profession' : u_profession,
			'u_class' : u_class,
			'u_address' : u_address,
			'u_tel' : u_tel,
			'u_enrolment' : u_enrolment,
			'u_tuition' : u_tuition,
			'u_detail' : u_detail
		}),
		success : function(data) {
			$("#adduserdiv").css("display", "none");
			alert("添加成功!");
		}
	});
};

// 管理员--选择页数管理课程信息
courseselectpage = function(pagecount) {
	var selectlessontype = $("#selectlessontype").val();
	var selecttedepart = $("#selecttedepart").val();
	var selectlevel = $("#selectlevel").val();
	var findtext = $("#findtext").val();
	$
			.post(
					"/sams/user/selectcoursebypagecount.action",
					{
						selectlessontype : selectlessontype,
						selecttedepart : selecttedepart,
						selectlevel : selectlevel,
						findtext : findtext,
						pagecount : pagecount
					},
					function(data, status) {
						var con = "<tr align='center'><td>操作</td><td>ID</td><td>课程名</td><td>课程类型</td><td>上课节数</td><td>上课周数</td><td>上课地点</td><td>任课教师</td><td>已占人数</td><td>总容量</td><td>课程状态</td></tr>";
						$(data)
								.each(
										function(index, item) {
											con = con + "<tr>";
											con = con
													+ "<td> <button id='modifybutton' class='btn btn-info' onclick=\"modifycoursediv('"
													+ item.co_id
													+ "')\" data-toggle='modal' data-target='#modifymodal'>修改</button><button id='deletebutton' class='btn btn-danger' onclick=\"deletecourse('"
													+ item.co_id
													+ "')\">删除</button></td>";
											con = con + "<td>" + item.co_id
													+ "</td>";
											con = con + "<td>" + item.co_name
													+ "</td>";
											con = con + "<td>" + item.co_type
													+ "</td>";
											con = con + "<td>"
													+ item.co_lessonnum
													+ "</td>";
											con = con + "<td>" + item.co_weeks
													+ "</td>";
											con = con + "<td>" + item.co_place
													+ "</td>";
											con = con + "<td>" + item.co_place
													+ "</td>";
											con = con + "<td>"
													+ item.co_teacher + "</td>";
											con = con + "<td>"
													+ item.co_weekday + "</td>";
											con = con + "<td>" + item.co_grade
													+ "</td>";
											con = con + "<td>" + item.co_depart
													+ "</td>";
											con = con + "<td>"
													+ item.co_profession
													+ "</td>";
											con = con + "<td>"
													+ item.co_tedepart
													+ "</td>";
											con = con + "<td>" + item.co_credit
													+ "</td>";
											con = con + "<td>" + item.co_occupy
													+ "</td>";
											con = con + "<td>"
													+ item.co_content + "</td>";
											con = con + "<td>" + item.co_state
													+ "</td>";
											con = con + "</tr>";
										});
						$("#coursetable").html(con);
					}, "json");
};

// 管理员--通过条件查询课程
selectcoursebycondition = function() {
	var selectlessontype = $("#selectlessontype").val();
	var selecttedepart = $("#selecttedepart").val();
	var selectlevel = $("#selectlevel").val();
	var findtext = $("#findtext").val();
	$
			.ajax({
				type : "POST",
				url : "/sams/user/selectcoursebycondition.action",
				dataType : "json",
				data : {
					selectlessontype : selectlessontype,
					selecttedepart : selecttedepart,
					selectlevel : selectlevel,
					findtext : findtext
				},
				success : function(data) {
					var pagecounts = 1;
					var n = 0;
					var pagecon = "<li ><a href='#' onclick='selectpage(1)'>1<span class='sr-only'></span></a></li>";
					var con = "<tr align='center'><td>操作</td><td>ID</td><td>课程名</td><td>课程类型</td><td>上课节数</td><td>上课周数</td><td>上课地点</td><td>任课教师</td><td>上课时间(周几)</td><td>开放年级</td><td>开放学院</td><td>开放专业</td><td>开设学院</td><td>学分</td><td>已占人数</td><td>总容量</td><td>课程状态</td></tr>";
					$(data)
							.each(
									function(index, item) {
										con = con + "<tr>";
										con = con
												+ "<td> <button id='modifybutton' class='btn btn-info' onclick=\"modifycoursediv('"
												+ item.co_id
												+ "')\" data-toggle='modal' data-target='#modifymodal'>修改</button><button id='deletebutton' class='btn btn-danger' onclick=\"deletecourse('"
												+ item.co_id
												+ "')\">删除</button></td>";
										con = con + "<td>" + item.co_id
												+ "</td>";
										con = con + "<td>" + item.co_name
												+ "</td>";
										con = con + "<td>" + item.co_type
												+ "</td>";
										con = con + "<td>" + item.co_lessonnum
												+ "</td>";
										con = con + "<td>" + item.co_weeks
												+ "</td>";
										con = con + "<td>" + item.co_place
												+ "</td>";
										con = con + "<td>" + item.co_teacher
												+ "</td>";
										con = con + "<td>" + item.co_weekday
												+ "</td>";
										con = con + "<td>" + item.co_grade
												+ "</td>";
										con = con + "<td>" + item.co_depart
												+ "</td>";
										con = con + "<td>" + item.co_profession
												+ "</td>";
										con = con + "<td>" + item.co_tedepart
												+ "</td>";
										con = con + "<td>" + item.co_credit
												+ "</td>";
										con = con + "<td>" + item.co_occupy
												+ "</td>";
										con = con + "<td>" + item.co_content
												+ "</td>";
										con = con + "<td>" + item.co_state
												+ "</td>";
										con = con + "</tr>";
										n++;
										if (n % 12 == 0 && n != 0) {
											pagecounts++;
											pagecon = pagecon
													+ "<li ><a href='#' onclick='selectcoursepage("
													+ pagecounts
													+ ")'>"
													+ pagecounts
													+ "<span class='sr-only'></span></a></li>";
										}
									});
					$("#coursetable").html(con);
					$("#pagecounts").html(pagecon);
				}
			});
};

// 修改课程div弹窗回显
modifycoursediv = function(co_id) {
	$.post("/sams/user/modifycoursediv.action", {
		co_id : co_id
	}, function(data, status) {
		$("#idtext").val(data.co_id);
		$("#nametext").val(data.co_name);
		$("#typetext").val(data.co_type);
		$("#lessonnumtext").val(data.co_lessonnum);
		$("#weekstext").val(data.co_weeks);
		$("#placetext").val(data.co_place);
		$("#teachertext").val(data.co_teacher);
		$("#weekdaytext").val(data.co_weekday);
		$("#leveltext").val(data.co_grade);
		$("#departtext").val(data.co_depart);
		$("#professiontext").val(data.co_profession);
		$("#tedeparttext").val(data.co_tedepart);
		$("#credittext").val(data.co_credit);
		$("#occupytext").val(data.co_occupy);
		$("#contenttext").val(data.co_content);
		$("#statetext").val(data.co_state);

		$("#confimodifybutton").attr("onclick",
				"modifycourse('" + data.co_id + "')");
		$("#modifydiv").css("display", "block");
	}, "json");
};

// 修改课程信息
modifycourse = function(co_id) {
	var co_name = $("#nametext").val();
	var co_type = $("#typetext").val();
	var co_lessonnum = $("#lessonnumtext").val();
	var co_weeks = $("#weekstext").val();
	var co_place = $("#placetext").val();
	var co_teacher = $("#teachertext").val();
	var co_weekday = $("#weekdaytext").val();
	var co_level = $("#leveltext").val();
	var co_depart = $("#departtext").val();
	var co_profession = $("#professiontext").val();
	var co_tedepart = $("#tedeparttext").val();
	var co_credit = $("#credittext").val();
	var co_occupy = $("#occupytext").val();
	var co_content = $("#contenttext").val();
	var co_state = $("#statetext").val();
	$.ajax({
		type : "POST",
		url : "/sams/user/modifycourse.action",
		contentType : "application/json", // 传递值类型
		dataType : "html", // 表示返回值类型
		data : JSON.stringify({
			'co_id' : co_id,
			'co_name' : co_name,
			'co_type' : co_type,
			'co_lessonnum' : co_lessonnum,
			'co_weeks' : co_weeks,
			'co_place' : co_place,
			'co_teacher' : co_teacher,
			'co_weekday' : co_weekday,
			'co_grade' : co_level,
			'co_depart' : co_depart,
			'co_profession' : co_profession,
			'co_tedepart' : co_tedepart,
			'co_credit' : co_credit,
			'co_occupy' : co_occupy,
			'co_content' : co_content,
			'co_state' : co_state,
		}),
		success : function(data) {
			alert("修改成功!");
		}
	});
};

// 管理员--删除课程
deletecourse = function(co_id) {
	var confi = confirm("是否删除该门课程?");
	if (confi == true)
		$.ajax({
			type : "POST",
			url : "/sams/user/deletecourse.action",
			dataType : "html",
			data : {
				"co_id" : co_id
			},
			success : function(data) {
				alert("删除成功!");
			}
		});
};

// 管理员--添加课程判断教师是否存在
checkteacher = function() {
	var u_id = $("#addteachertext").val();
	if (u_id == "" || null == u_id)
		$("#teacherspan")
				.html(
						"<font class='glyphicon glyphicon-remove' color='red'>用户ID不能为空</font>");
	else
		$
				.ajax({
					type : "POST",
					url : "/sams/user/selectteacherById.action",
					dataType : "html",
					data : {
						"userId" : u_id
					},
					success : function(data) {
						if (data == 1)
							$("#teacherspan")
									.html(
											"<font class='glyphicon glyphicon-ok' color='green'>该教师存在</font>");
						else if (data == 0)
							$("#teacherspan")
									.html(
											"<font class='glyphicon glyphicon-remove' color='red'>该教师不存在</font>");
					}
				});
};

// 管理员--添加课程
addcourse = function() {
	var co_name = $("#addnametext").val();
	var co_type = $("#addtypetext").val();
	var co_lessonnum = $("#addlessonnumtext").val();
	var co_weeks = $("#addweekstext").val();
	var co_place = $("#addplacetext").val();
	var co_teacher = $("#addteachertext").val();
	var co_weekday = $("#addweekdaytext").val();
	var co_level = $("#addleveltext").val();
	var co_depart = $("#adddeparttext").val();
	var co_profession = $("#addprofessiontext").val();
	var co_tedepart = $("#addtedeparttext").val();
	var co_credit = $("#addcredittext").val();
	var co_occupy = $("#addoccupytext").val();
	var co_content = $("#addcontenttext").val();
	var co_state = $("#addstatetext").val();
	$.ajax({
		type : "POST",
		url : "/sams/user/addcourse.action",
		contentType : "application/json",
		dataType : "html",
		data : JSON.stringify({
			'co_name' : co_name,
			'co_type' : co_type,
			'co_lessonnum' : co_lessonnum,
			'co_weeks' : co_weeks,
			'co_place' : co_place,
			'co_teacher' : co_teacher,
			'co_weekday' : co_weekday,
			'co_grade' : co_level,
			'co_depart' : co_depart,
			'co_profession' : co_profession,
			'co_tedepart' : co_tedepart,
			'co_credit' : co_credit,
			'co_occupy' : co_occupy,
			'co_content' : co_content,
			'co_state' : co_state,
		}),
		success : function(data) {
			$("#addcoursediv").css("display", "none");
			alert("添加成功!");
		}
	});
};

// 教师--修改个人信息弹窗
updateindividual = function() {
	$.ajax({
		type : "POST",
		url : "/sams/user/modifyindividual.action",
		dataType : "json",
		success : function(data) {
			$("#nametext").val(data.u_name);
			$("#sextext").val(data.u_sex);
			$("#agetext").val(data.u_age);
			$("#birthdaytext").val(data.u_birthday);
			$("#nativetext").val(data.u_native);
			$("#credentialstext").val(data.u_credentials);
			$("#codetext").val(data.u_code);
			$("#forktext").val(data.u_fork);
			$("#politicaltext").val(data.u_political);
			$("#graduatetext").val(data.u_graduate);
			$("#addresstext").val(data.u_address);
			$("#teltext").val(data.u_tel);
			$("#modifyindividual").css("display", "block");
		}
	});
};

// 教师--修改个人信息
modifyindividualsubmit = function() {
	var u_name = $("#nametext").val();
	var u_sex = $("#sextext").val();
	var u_age = $("#agetext").val();
	var u_birthday = $("#birthdaytext").val();
	var u_native = $("#nativetext").val();
	var u_credentials = $("#credentialstext").val();
	var u_code = $("#codetext").val();
	var u_fork = $("#forktext").val();
	var u_political = $("#politicaltext").val();
	var u_graduate = $("#graduatetext").val();
	var u_address = $("#addresstext").val();
	var u_tel = $("#teltext").val();
	var confi = confirm("确认修改?");
	if (confi == true)
		$.ajax({
			type : "POST",
			url : "/sams/user/modifyindividualsubmit.action",
			contentType : "application/json", // 传递值类型
			dataType : "html", // 表示返回值类型
			data : JSON.stringify({
				'u_name' : u_name,
				'u_sex' : u_sex,
				'u_age' : u_age,
				'u_birthday' : u_birthday,
				'u_native' : u_native,
				'u_credentials' : u_credentials,
				'u_code' : u_code,
				'u_fork' : u_fork,
				'u_political' : u_political,
				'u_graduate' : u_graduate,
				'u_address' : u_address,
				'u_tel' : u_tel,
			}),
			success : function(data) {
				alert("修改成功!");
				$("#modifyindividual").css("display", "none");
			}
		});
};

// 管理员--通过条件筛选专业
selectprobycondition = function() {
	var selectdepart = $("#selectdepart").val();
	var findtext = $("#findtext").val();
	$
			.ajax({
				type : "POST",
				url : "/sams/user/selectprobycondition.action",
				dataType : "json",
				data : {
					selectdepart : selectdepart,
					findtext : findtext
				},
				success : function(data) {
					var con = "<tr align='center'><td style='width:20px;'>操作</td><td>ID</td><td>所属学院</td><td>专业名称</td></tr>";
					$(data)
							.each(
									function(index, item) {
										con = con + "<tr>";
										con = con
												+ "<td><button id='modifybutton' class='btn btn-info' onclick=\"modifydepartprodiv('"
												+ item.p_id
												+ "')\" data-target='#modifypromodal' data-toggle='modal'>修改</button><button id='deletebutton' class='btn btn-danger' onclick=\"deletedepartpro('"
												+ item.p_id
												+ "')\">删除</button></td>";
										con = con + "<td>" + item.p_id
												+ "</td>";
										con = con + "<td>" + item.p_depart
												+ "</td>";
										con = con + "<td>" + item.p_name
												+ "</td>";
									});
					$("#professiontable").html(con);
				}
			});
};

// 管理员--修改院系信息div
modifydepartprodiv = function(p_id) {
	$.ajax({
		type : "POST",
		url : "/sams/user/modifydepartprodiv.action",
		dataType : "json",
		data : {
			p_id : p_id
		},
		success : function(data) {
			$("#idtext").val(data.p_id);
			$("#departtext").val(data.p_depart);
			$("#nametext").val(data.p_name);
			$("#modifydiv").css("display", "block");
			$("#confimodifybutton").attr("onclick",
					"modifyprofession(" + data.p_id + ")");
		}
	});
};

// 修改院系信息
modifyprofession = function(p_id) {
	var p_depart = $("#departtext").val();
	var p_name = $("#nametext").val();
	$.ajax({
		type : "POST",
		url : "/sams/user/modifyprofession.action",
		contentType : "application/json", // 传递值类型
		dataType : "html", // 表示返回值类型
		data : JSON.stringify({
			'p_id' : p_id,
			'p_depart' : p_depart,
			'p_name' : p_name
		}),
		success : function(data) {
			alert("修改成功!");
			$("#modifydiv").css("display", "none");
		}
	});
};

// 管理员--删除专业
deletedepartpro = function(p_id) {
	var confi = confirm("是否删除该专业?");
	if (confi == true)
		$.ajax({
			type : "POST",
			url : "/sams/user/deleteprofession.action",
			dataType : "html",
			data : {
				"p_id" : p_id
			},
			success : function(data) {
				alert("删除成功!");
			}
		});
};

// 管理院--添加学院
adddepart = function() {
	var p_name = $("#adddepartnametext").val();
	$.ajax({
		type : "POST",
		url : "/sams/user/adddepart.action",
		dataType : "html",
		data : {
			'p_name' : p_name
		},
		success : function(data) {
			if (data == 1)
				alert("添加成功!");
			else
				alert("请勿重复添加相同的学院!");
		}
	});
};

// 管理员--添加专业div
addprofessiondiv = function() {
	$("#addprofessiondiv").css("display", "block");
};

// 管理院--添加专业
addprofession = function() {
	var p_name = $("#addpronametext").val();
	var p_depart = $("#adddeparttext").val();
	$.ajax({
		type : "POST",
		url : "/sams/user/addprofession.action",
		dataType : "html",
		data : {
			'p_name' : p_name,
			'p_depart' : p_depart
		},
		success : function(data) {
			$("#addprofessiondiv").css("display", "none");
			alert("添加成功!");
		}
	});
};

// 管理员--删除教室
deleteclassroom = function(c_id) {
	var confi = confirm("确定删除该教室?");
	if (confi == true)
		$.ajax({
			type : "POST",
			url : "/sams/classroom/deleteclassroom.action",
			data : {
				'c_id' : c_id
			},
			success : function(data) {
				alert("删除成功!");
			}
		});
};

// 管理员--修改教室信息回显
modifyclassroommodal = function(c_id) {
	$.ajax({
		type : "POST",
		url : "/sams/classroom/reviewclassroom.action",
		data : {
			c_id : c_id
		},
		dataType : "json",
		success : function(data) {
			$("#coidtext").val(data.c_co_id);
			$("#nametext").val(data.c_name);
			$("#statetext").val(data.c_state);
		}
	});
};

// 管理员--修改教室信息
modifyclassroom = function() {
	var c_co_id = $("#coidtext").val();
	var c_name = $("#nametext").val();
	var c_state = $("#statetext").val();
	var confi = confirm("确认修改信息吗?");
	if (confi == true)
		$.ajax({
			type : "POST",
			url : "/sams/classroom/modifyclassroom.action",
			contentType : "application/json",
			data : JSON.stringify({
				'c_co_id' : c_co_id,
				'c_name' : c_name,
				'c_state' : c_state
			}),
			success : function(data) {
				if (c_name == "" || c_state == "")
					alert("教室名称和状态是必填项!");
				else
					alert("修改成功!");
			}
		});
};

// 管理员--添加教室
addclassroom = function() {
	var c_co_id = $("#addcoidtext").val();
	var c_name = $("#addnametext").val();
	var c_state = $("#addstatetext").val();
	$.ajax({
		type : "POST",
		url : "/sams/classroom/addclassroom.action",
		contentType : "application/json",
		data : JSON.stringify({
			'c_co_id' : c_co_id,
			'c_name' : c_name,
			'c_state' : c_state
		}),
		success : function(data) {
			if (c_name == "" || c_state == "")
				alert("教室名称和状态是必填项!");
			else
				alert("添加成功!");
		}
	});
};

// 管理员--根据条件查询教室
selectclassroombycondition = function() {
	var findtext = $("#findtext").val();
	$
			.ajax({
				type : "POST",
				url : "/sams/classroom/selectclassroombycondition.action",
				data : {
					findtext : findtext
				},
				dataType : "json",
				success : function(data) {
					con = "<tr align='center'><td>操作</td><td>ID</td><td>课程ID</td><td>教室名称</td><td>教室状态</td></tr>";
					var pagecounts = 1;
					var n = 0;
					var pagecon = "<li ><a href='#' onclick='selectpage(1)'>1<span class='sr-only'></span></a></li>";
					$(data)
							.each(
									function(index, item) {
										con = con + "<tr>";
										con = con
												+ "<td style='width:30px'><button id='modifybutton' class='btn btn-info' type='button' data-toggle='modal' data-target='#modifymodal' onclick=\"modifyclassroommodal('"
												+ item.c_id
												+ "')\">修改</button><button id='deletebutton' class='btn btn-danger' onclick=\"deleteclassroom('"
												+ item.c_id
												+ "')\">删除</button></td>";
										con = con + "<td>" + item.c_id
												+ "</td>";
										con = con + "<td>" + item.c_co_id
												+ "</td>";
										con = con + "<td>" + item.c_name
												+ "</td>";
										con = con + "<td>" + item.c_state
												+ "</td>";
										con = con + "</tr>";
									});
					$("#pagecounts").html(pagecon);
					$("#classroomtable").html(con);
				}
			});
};

// 管理员--跳转页查询教室信息
classroompage = function(page) {
	var findtext = $("#findtext").val();
	$
			.ajax({
				type : "POST",
				url : "/sams/classroom/classroomchangepage.action",
				data : {
					page : page,
					findtext : findtext
				},
				success : function(data) {
					con = "<tr align='center'><td>操作</td><td>ID</td><td>课程ID</td><td>教室名称</td><td>教室状态</td></tr>";
					var pagecounts = 1;
					var n = 0;
					var pagecon = "<li ><a href='#' onclick='selectpage(1)'>1<span class='sr-only'></span></a></li>";
					$(data)
							.each(
									function(index, item) {
										con = con + "<tr>";
										con = con
												+ "<td style='width:30px'><button id='modifybutton' class='btn btn-info' type='button' data-toggle='modal' data-target='#modifymodal' onclick=\"modifyclassroommodal('"
												+ item.c_id
												+ "')\">修改</button><button id='deletebutton' class='btn btn-danger' onclick=\"deleteclassroom('"
												+ item.c_id
												+ "')\">删除</button></td>";
										con = con + "<td>" + item.c_id
												+ "</td>";
										con = con + "<td>" + item.c_co_id
												+ "</td>";
										con = con + "<td>" + item.c_name
												+ "</td>";
										con = con + "<td>" + item.c_state
												+ "</td>";
										con = con + "</tr>";
									});
					$("#classroomtable").html(con);
					$("#pagecounts").html(pagecon);
				}
			});
};

// 管理员--添加课程与成绩
addscore = function() {
	var confi = confirm("是否添加该课程及成绩?");
	var addcoidtext = $("#addcoidtext").val();
	var addstuidtext = $("#addstuidtext").val();
	var addscoretext = $("#addscoretext").val();
	var addevaluatetext = $("#addevaluatetext").val();
	if (confi == true)
		$.ajax({
			type : "POST",
			url : "/sams/lesson/addlesson.action",
			contentType : "application/json",
			data : JSON.stringify({
				'l_co_id' : addcoidtext,
				'l_u_id' : addstuidtext,
				'l_score' : addscoretext,
				'l_evaluate' : addevaluatetext
			}),
			success : function(data) {
				if (data == 1)
					alert("添加成功!");
			}
		});
};

// 管理员--修改课程成绩信息回显
modifyscoreback = function(l_id) {
	$.ajax({
		type : "POST",
		url : "/sams/lesson/reviewscore.action",
		data : {
			'l_id' : l_id
		},
		dataType : "json",
		success : function(data) {
			$("#idtext").val(data.l_id);
			$("#coidtext").val(data.l_co_id);
			$("#stuidtext").val(data.l_u_id);
			$("#scoretext").val(data.l_score);
			$("#evaluatetext").val(data.l_evaluate);
		}
	});
};

// 管理员--修改课程成绩
modifyscore = function() {
	var l_id = $("#idtext").val();
	var l_co_id = $("#coidtext").val();
	var l_u_id = $("#stuidtext").val();
	var l_score = $("#scoretext").val();
	var l_evaluate = $("#evaluatetext").val();

	var confi = confirm("确认修改信息吗?");
	if (confi == true)
		$.ajax({
			type : "POST",
			url : "/sams/lesson/modifyscore.action",
			contentType : "application/json",
			data : JSON.stringify({
				'l_id' : l_id,
				'l_co_id' : l_co_id,
				'l_u_id' : l_u_id,
				'l_score' : l_score,
				'l_evaluate' : l_evaluate
			}),
			success : function(data) {
				if (l_id == "" || l_u_id == "")
					alert("学生ID和课程ID是必填项!");
				else
					alert("修改成功!");
			}
		});
};

// 管理员--删除学生成绩
deletescore = function(l_id) {
	var confi = confirm("确定删除该学生的该门课程及成绩信息?");
	if (confi == true)
		$.ajax({
			type : "POST",
			url : "/sams/lesson/deletescore.action",
			data : {
				'l_id' : l_id
			},
			success : function(data) {
				alert("删除成功!");
			}
		});
};

// 管理员--通过条件查询课程成绩
selectlessonByCondition = function() {
	var findtext = $("#findtext").val();
	var selectdepart = $("#selectdepart").val();
	var selectlevel = $("#selectlevel").val();
	$
			.ajax({
				type : "POST",
				url : "/sams/lesson/selectlessonbycondition.action",
				data : {
					findtext : findtext,
					selectdepart : selectdepart,
					selectlevel : selectlevel
				},
				dataType : "json",
				success : function(data) {
					con = "<tr align='center'><td style='width:20px;'>操作</td><td>ID</td><td>课程ID</td><td>课程名称</td><td>学生ID</td><td>学生姓名</td><td>课程分数</td><td>学生评教</td></tr>";
					var pagecounts = 1;
					var n = 0;
					var pagecon = "<li ><a href='#' onclick='selectpage(1)'>1<span class='sr-only'></span></a></li>";
					$(data)
							.each(
									function(index, item) {
										con = con + "<tr>";
										con = con
												+ "<td><button id='modifybutton' class='btn btn-info' onclick=\"modifyscoreback('"
												+ item.l_id
												+ "')\" data-target='#modifyscoremodal' data-toggle='modal'>修改</button><button id='deletebutton' class='btn btn-danger' onclick=\"deletescore('"
												+ item.l_id
												+ "')\">删除</button></td>";
										con = con + "<td>" + item.l_id
												+ "</td>";
										con = con + "<td>" + item.l_co_id
												+ "</td>";
										con = con + "<td>"
												+ item.course.co_name + "</td>";
										con = con + "<td>" + item.l_u_id
												+ "</td>";
										con = con + "<td>" + item.user.u_name
												+ "</td>";
										con = con + "<td>" + item.l_score
												+ "</td>";
										con = con + "<td>" + item.l_evaluate
												+ "</td>";
										con = con + "</tr>";
										n++;
										if (n % 12 == 0 && n != 0) {
											pagecounts++;
											pagecon = pagecon
													+ "<li ><a href='#' onclick='selectpage("
													+ pagecounts
													+ ")'>"
													+ pagecounts
													+ "<span class='sr-only'></span></a></li>";
										}
									});
					$("#pagecounts").html(pagecon);
					$("#scoretable").html(con);
				}
			});
};

// 管理员--跳页查询课程成绩
selectscorepage = function(page) {
	var findtext = $("#findtext").val();
	var selectdepart = $("#selectdepart").val();
	var selectlevel = $("#selectlevel").val();
	$
			.ajax({
				type : "POST",
				url : "/sams/lesson/lessonchangepage.action",
				data : {
					page : page,
					findtext : findtext,
					selectdepart : selectdepart,
					selectlevel : selectlevel
				},
				success : function(data) {
					con = "<tr align='center'><td style='width:20px;'>操作</td><td>ID</td><td>课程ID</td><td>课程名称</td><td>学生ID</td><td>学生姓名</td><td>课程分数</td><td>学生评教</td></tr>";
					var pagecounts = 1;
					var n = 0;
					var pagecon = "<li ><a href='#' onclick='selectpage(1)'>1<span class='sr-only'></span></a></li>";
					$(data)
							.each(
									function(index, item) {
										con = con + "<tr>";
										con = con
												+ "<td><button id='modifybutton' class='btn btn-info' onclick=\"modifyscoreback('"
												+ item.l_id
												+ "')\" data-target='#modifyscoremodal' data-toggle='modal'>修改</button><button id='deletebutton' class='btn btn-danger' onclick=\"deletescore('"
												+ item.l_id
												+ "')\">删除</button></td>";
										con = con + "<td>" + item.l_id
												+ "</td>";
										con = con + "<td>" + item.l_co_id
												+ "</td>";
										con = con + "<td>"
												+ item.course.co_name + "</td>";
										con = con + "<td>" + item.l_u_id
												+ "</td>";
										con = con + "<td>" + item.user.u_name
												+ "</td>";
										con = con + "<td>" + item.l_score
												+ "</td>";
										con = con + "<td>" + item.l_evaluate
												+ "</td>";
										con = con + "</tr>";
										n++;
										if (n % 12 == 0 && n != 0) {
											pagecounts++;
											pagecon = pagecon
													+ "<li ><a href='#' onclick='selectpage("
													+ pagecounts
													+ ")'>"
													+ pagecounts
													+ "<span class='sr-only'></span></a></li>";
										}

									});
					$("#pagecounts").html(pagecon);
					$("#scoretable").html(con);

				}
			});
};