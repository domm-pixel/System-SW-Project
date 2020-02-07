<!-- 새로운 스케줄을 입력받는 폼을 형성하고
	입력할 내용을 다음으로 넘겨준다. -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8;");
	//날자를 받아 오는 과정
	Calendar today = Calendar.getInstance();
	String inputYear = request.getParameter("year");
	if (inputYear == null)
		inputYear = "" + today.get(Calendar.YEAR);
	String inputMonth = request.getParameter("month");
	if (inputMonth == null)
		inputMonth = "" + today.get(Calendar.MONTH);
	String inputDay = request.getParameter("day");
	if (inputDay == null)
		inputDay = "" + today.get(Calendar.DATE);
	int intYear = Integer.parseInt(inputYear);
	int intMonth = Integer.parseInt(inputMonth);
	int intDay = Integer.parseInt(inputDay);
%>

<HTML>
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
</head>
<!-- 새로운 스케줄 입력 폼 -->
<body>
	<form name="newScheduleForm" action="scheduleInputAction.jsp"
		method="POST">
		<table align="center" border="0" cellspacing="1"
			style="background-color: #eeeeee; width: 90%">
			<tr>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd" colspan="2"
					height="60"><b>새 스케줄 추가하기</b></td>
			</tr>
			<tr><td><br></td></tr>
			<tr>
				<td align="center" style="width: 5%;"><font size="3">제목</font></td>
				<td style="text-align:left"><input name="title" type="text"
					style="width: 95%;"></td>
			</tr>
			<tr>
				<!-- 안보이게 처리 할꺼임 -->
				<td><input type="hidden" name="startYear"
					value="<%=inputYear%>"> <input type="hidden"
					name="startMonth" value="<%=inputMonth%>"> <input
					type="hidden" name="startDay" value="<%=inputDay%>"></td>
					
			</tr>
			<tr><td><br></td></tr>
			<tr>
				<td align="center">내용</TD>
				<td><textarea name="context" rows="5" style="width: 95%;"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" sytle="text-align:center" align="center"><br>
					<input type="submit" value="저장하기"></td>
			</tr>
		</table>
	</form>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</body>
</html>