<!-- 
	본 페이지는 해당 스케줄에 대한 수정을 눌렀을때,
	수정하기 위한 폼을 출력한다.	-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" import="java.sql.*"%>

<% request.setCharacterEncoding("utf-8");
response.setContentType("text/html;charset=utf-8;");

//해당 년도와 월을 받아온다.
String title = request.getParameter("title");
String context = request.getParameter("context");
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
%>

<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/bootstrap.css">

<link href="https://fonts.googleapis.com/css?family=Share+Tech+Mono"
	rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Anton'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Neucha'
	rel='stylesheet' type='text/css'>

<meta name="viewport" content="width=device-width" initial-scale="1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>schedule modify</title>
</head>

<body>
	<%
		String userID = null; // 로그인이 된 사람들은 로그인정보를 담을 수 있도록한다
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<!-- 홈페이지의 로고 -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expand="false">
				<span class="icon-bar"></span>
				<!-- 줄였을때 옆에 짝대기 -->
				<span class="icon-bar"></span> <span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">유용한 사이트</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
				<li><a href="weather.jsp">날씨</a></li>
				<li class="active"><a href="scheduler.jsp">스케줄</a></li>
				<li><a href="map.jsp">지도</a></li>
			</ul>
			<%
				// 접속하기는 로그인이 되어있지 않은 경우만 나오게한다
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
				// 로그인이 되어있는 사람만 볼수 있는 화면
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<form action="scheduleModifyAction.jsp" method="POST">
		<table border="0" cellspacing="1" style="width: 100%;">
			<tr>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="2" sytle="background-color:lavender;" align="center"><B>스케줄
						수정하기</TD>
			</tr>
			<tr style="background-color: oldlace">
				<td style="width: 5%" align="center">제목</td>
				<td><input style="width: 100%" name="title" type="text"
					value="<%=title%>"></td>
			</tr>
			<tr style="background-color: oldlace">
				<td style="text-align: center">시간</TD>
				<td><%=year%>년 <%=month%>월 <%=day%>일</td>
			</tr>
			<tr style="background-color: oldlace">
				<td align="center" style="width: 5%;">내용</td>
				<td><textarea name="context" rows="5" style="width: 95%"><%=context%></textarea>
				</td>
			</tr>
			<tr style="background-color: oldlace">
				<td  style="text-align: center;" align="center"><input style="width:100%;"class="btn btn-primary"
					type="submit" value="수정하기"></td>
			</tr>
		</table>
		<input type="hidden" name="id" value='<%=request.getParameter("id")%>'>
		<input type="hidden" name="startYear" value='<%=year%>'> <input
			type="hidden" name="startMonth" value='<%=month%>'> <input
			type="hidden" name="startDay" value='<%=day%>'>
	</form>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</body>
</html>
