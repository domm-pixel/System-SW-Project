<!--
	본 페이지는 해당 날자의 스케줄의 내용을 출력하는 화면이다.	-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
	String title = request.getParameter("title");
	String context = request.getParameter("context");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	if (year == null)
		year = "2020";
	if (month == null)
		month = "01";
	if (day == null)
		day = "01";
	if (month.length() == 1)
		month = "0" + month;
	if (day.length() == 1)
		day = "0" + day;
	String date = year + month + day;
	String link_main = "scheduler.jsp";
%>

<%@ include file="schedulerConnDB.jsp"%>
<%
	try {
		// select 문장을 문자열 형태로 구성한다.
		String sql = "SELECT * FROM scheduletable where date = " + date;
		pstmt = conn.prepareStatement(sql);
		// select 를 수행하면 데이터정보가 ResultSet 클래스의 인스턴스로 리턴됨.
		rs = pstmt.executeQuery();
%>

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 반응형 웹에 사용하는 메타태그 -->
<link rel="stylesheet" href="css/bootstrap.css">
<!-- 참조  -->

<script>
function del(id){
	if(	confirm( "<%=year%>년 <%=month%>월 <%=day%>일의 이 일정을 삭제하시겠습니까?" ) ){
		location.href ='scheduleDelete.jsp?id='+id+'&year=<%=year%>&month=<%=month%>&day=<%=day%>';
	}
	return;
}
function modify(){
	return;
};


</script>
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
	<div align="center">
		<script>
			opener.location.reload();
		</script>
		<table class="table table-striped"
			style="text-align: center;align:center; border: 1px solid #dddddd">
			<tr>
				<td	style="text-align: center;border: 1px solid #dddddd">
					<p>
						<b><%=year%>년 <%=month%>월 <%=day%>일 스케줄 보기 </b>
					</p>
				</td>
			</tr>
			<tr>
				<td>
					<%
						//해당 날자에 몇개의 스케줄이 입력되어있는지 계산한다.
							rs.last();
							int recordCount = rs.getRow();
							rs.beforeFirst();

							if (recordCount > 0) {
								out.print("&nbsp;- " + recordCount + "개의 등록된 스케줄이 있습니다. -");
							} else {
								out.print("&nbsp;- 등록된 스케줄이 없습니다. -<BR>");
							}

							// 마지막 데이터까지 반복함.
							while (rs.next()) {
					%>
					<table align="cetner" class="table table-striped"
						style="text-align:center; border: 1px;width:100%;">
						<tr>
							<td colspan="3" style="background-color: #eeeeee"></td>
						</tr>
						<tr>
							<td
								style="text-align: center; width: 10%; background-color: #ffffff">제목</td>
							<td style="width: *%; background-color: #ffffff;text-align:left;"><%=rs.getString("title")%></td>
							<td width="5%">
								<a	class="btn btn-primary" onClick="modify()"
									href='scheduleModify.jsp?year=<%=year%>
									&month=<%=month%>&day=<%=day%>&title=<%=rs.getString("title")%>&context=<%=rs.getString("context")%>
									&id=<%=rs.getString("id")%>'>수정</a>
								<a class="btn btn-primary"
									onClick='del(<%=rs.getString("id")%>)' href="#">삭제</a>
							</td>
						</tr>
						<tr>
							<td style="background-color: #ffffff" align="center">내용</td>
							<td style="background-color: #ffffff; text-align:left;" colspan="2"><%=rs.getString("context")%></td>
						</TR>
					</table>
			<%
				}
					// 사용한 자원의 반납.
					rs.close();
					pstmt.close();
					conn.close();
				} catch (Exception e) {
					System.out.println(e);
				}
			%>

			<TR>
				<TD align="center"><BR><%@ include
						file="scheduleInput.jsp"%></TD>
			</TR>
		</table>
		<A class="btn btn-primary form-control" href="<%=link_main%>">달력
			보기</A>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</BODY>
</HTML>