<!-- scheduler.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" import="java.sql.*"%>
<!-- <@ page import="schedule.ScheduleDAO" %> -->
<!-- <@ page import="schedule.Schedule" %> -->
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

<title>유용한 사이트</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
</style>
</head>
<%
	Calendar today = Calendar.getInstance(); //지금의 날자를 받아옴 
	String wantYear = request.getParameter("wantYear");
	String wantMonth = request.getParameter("wantMonth");

	if (wantYear != null && wantMonth != null) { //중간 실행으로 원하는 년도와 월이 지정됐을때
		int year = Integer.parseInt(wantYear);
		int month = Integer.parseInt(wantMonth);
		today.set(year, --month, 1);
	} else {
		wantMonth = Integer.toString(today.get(Calendar.MONTH)); //월의 두자리수 맞추기 위한 작업
	}

	if (wantMonth.length() == 1)
		wantMonth = "0" + wantMonth;

	Calendar firstDay = Calendar.getInstance(); //firstDay
	Calendar lastDay = Calendar.getInstance(); //lastDay

	firstDay.set(today.get(Calendar.YEAR), today.get(Calendar.MONTH), 1);
	lastDay.set(today.get(Calendar.YEAR), today.get(Calendar.MONTH) + 1, 1);

	int nYear = today.get(Calendar.YEAR);
	int nMonth = today.get(Calendar.MONTH);

	String link = null;
%>

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
	<%@ include file="schedulerConnDB.jsp"%>
	<%
		try {
			String pnMonth = Integer.toString(nMonth + 2); //다음달의 쿼리문을 만드는데 필요
			if (pnMonth.length() == 1)
				pnMonth = "0" + pnMonth;
			// Connection 클래스의 인스턴스로 부터 SQL 문 작성을 위한 Statement 준비
			String sql = "SELECT date,title FROM scheduletable WHERE date>=" + Integer.toString(nYear) + wantMonth
					+ "00 && date<" + Integer.toString(nYear) + pnMonth + "00 ORDER BY date";
			pstmt = conn.prepareStatement(sql);
			// username 값이 제대로 전달된 경우 sql 문장을 수행.
			rs = pstmt.executeQuery();
		} catch (Exception e) {
			System.out.println(e);
		}
	%>
	<br>
	<div class="table table-condensed">
		<table align="center" style="border: 1px solid #dddddd"
			cellspacing="0" cellpadding="0">
			<tr>
				<td style="background-color: #eeeeee; text-align: center;">
					<%
						int linkYear = nYear;
						int linkMonth = nMonth;
						if (nMonth == 0) {
							linkYear = nYear - 1;
							linkMonth = 12;
						} else {
							linkMonth = nMonth;
						}
						link = "scheduler.jsp?wantYear=" + linkYear + "&wantMonth=" + linkMonth; //이전달 링크
					%> <a href="<%=link%>"> 이전달</A>
				</td>
				<td colspan="5"
					style="background-color: #eeeeee; text-align: center;"><b>
						<%=today.get(Calendar.YEAR)%>년 <%=today.get(Calendar.MONTH) + 1%>월
				</b></td>
				<td style="background-color: #eeeeee; text-align: center;">
					<%
						if (nMonth == 11) {
							linkYear = nYear + 1;
							linkMonth = -1;
						}
						linkMonth += 2;
						link = "scheduler.jsp?wantYear=" + linkYear + "&wantMonth=" + linkMonth; //다음달 링크
					%> <a href="<%=link%>"> 다음달</A>
				</td>
			</tr>
			<tr style="text-align: center;">
				<td width="95"><font size="2" color="red"><b>SUN</b></font></td>
				<td width="95"><font size="2"><B>MON</B></font></td>
				<td width="95"><font size="2"><B>TUE</B></font></td>
				<td width="95"><font size="2"><B>WED</B></font></td>
				<td width="95"><font size="2"><B>THU</B></font></td>
				<td width="95"><font size="2"><B>FRI</B></font></td>
				<td width="95"><font size="2" color="blue"><B>SAT</B></font></td>
			</tr>
			<tr>
				<%
					String day = "";
					String span = " colspan=\"+" + firstDay.get(Calendar.DAY_OF_WEEK) + "\""; //쉘 병합
					String rsDay = "0"; //리절트 셋에서 가져온 날자
					String rsTitle = ""; //러절트 셋에서 가저온 제목
					boolean key = true;
					while (firstDay.before(lastDay)) { // 세부 일 출력하기
						day = "" + firstDay.get(Calendar.DATE); // day . 날짜 값을 문자열로 에 저장한다
				%>
				<td align="right" <%=span%> nowrap>
					<!-- 달력 칸 조절 -->
					<table cellspacing="0" cellpadding="0"
						style="width: 120; border: 1px solid #dddddd">
						<tr bgcolor="#337ab7" align="center">
							<th align="center"><a class="btn btn-primary form-control"
								href="scheduleView.jsp?year=<%=firstDay.get(Calendar.YEAR)%>&month=<%=firstDay.get(Calendar.MONTH) + 1%>&day=<%=day%>">
									<font size="2" color="#ffffff" text-align="center"><%=day%></font>
							</a></th>
						</tr>
						<tr height="50" bgcolor="#eeeeee">
							<td></td>
						</tr>
					</table>
				</td>
				<%
					if (firstDay.get(Calendar.DAY_OF_WEEK) % 7 == 0) {
				%>
			</tr>
			<tr>
				<%
					}
						span = "";
						firstDay.add(Calendar.DATE, 1);
					}
				%>
			</tr>
		</table>
	</div>

	<!--	다른 년도와 월을 선택하여 이동하는 기능	-->
	<form action="scheduler.jsp" method="GET">
		<table align="center">
			<tr>
				<td colspan="7" align="center"><font size="2">다른 날짜보기</font>> <select
					name="wantYear">
						<%
							//현재의 년도와 월이 selected로 기본 옵션
							for (int selectYear = nYear - 10; selectYear < nYear + 10; selectYear++) {
						%>
						<option value="<%=selectYear%>"
							<%if (selectYear == nYear)
					out.print(" selected");%>><%=selectYear%>
							<%
								}
							%>
						
				</select>년&nbsp; <select name="wantMonth">
						<%
							for (int selectMonth = 1; selectMonth <= 12; selectMonth++) {
						%>
						<OPTION value="<%=selectMonth%>"
							<%if (selectMonth == nMonth + 1)
					out.print(" selected");%>><%=selectMonth%>
							<%
								}
							%>
						
				</select>월&nbsp; <input type="submit" value="확인"></td>
		</table>
	</form>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</body>
</html>