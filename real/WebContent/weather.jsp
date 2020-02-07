<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>

<!DOCTYPE html>
<html>

<title>weather</title>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css?family=Share+Tech+Mono"
	rel="stylesheet">
<link rel="stylesheet" href="css/bootstrap.css">
<link href='https://fonts.googleapis.com/css?family=Anton'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Neucha'
	rel='stylesheet' type='text/css'>

<meta charset="utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
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
				<li class="active"><a href="weather.jsp">날씨</a></li>
				<li><a href="scheduler.jsp">스케줄</a></li>
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
	<div>
		<!-- 날씨 넣는 자리! -->
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script>
		//Seoul , my_key = cf44bcda1d701285605a308a35cd5ef5
		var apiURI = "http://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=cf44bcda1d701285605a308a35cd5ef5";
		var result = document.getElementById('ajaxValue');
		$.ajax({
		    url: apiURI,
		    dataType: "json",
		    type: "GET",
		    async: "false",
		    success: function(resp) {
		    	var html="";
		    	html += "<table align= "+ "center" + "class=" + "table table-condensed" + "style=" + "border:1px solid #dddddd"+ ">" + "<tr>"
		    	html += "<td>" +  resp.sys.country + " / "+ resp.name + "</td></tr>";
		    	var imgURL = "http://openweathermap.org/img/w/" + resp.weather[0].icon + ".png";
		    	html += "<tr><td><img src="+ imgURL +"></td></tr>"
		    	var temp = parseInt(resp.main.temp -273.15)
		    	html += "<tr><td colspan" +"=" + "2"+">"+ "현재 온도 : " + temp + "</td></tr>"
		    	html += "<tr><td colspan" +"=" + "2"+">"+ "현재 습도 : " + resp.main.humidity +"%" + "</td>";
		    	html += "<tr><td>풍속 : " + resp.wind.speed + "</td></tr>"
		    	html += "<td>풍향  : " +  resp.wind.deg + "º</td></tr>";
		    	html += "<tr><td colspan" +"=" + "2"+">"+ "구름  : "+ (resp.clouds.all) +"%"+ "<td></tr>";
		    	html += "</table>"
		    	$("weather1").append(html);
		    }
		})	
	</script>
		<script>
		//Washington , my_key = cf44bcda1d701285605a308a35cd5ef5
		var apiURI = "http://api.openweathermap.org/data/2.5/weather?q=Washington&appid=cf44bcda1d701285605a308a35cd5ef5";
		var result = document.getElementById('ajaxValue');
		$.ajax({
		    url: apiURI,
		    dataType: "json",
		    type: "GET",
		    async: "false",
		    success: function(resp) {
		    	var html="";
		    	html += "<table align= "+ "center" + "class=" + "table-condensed" + "style=" + " border:1px solid #dddddd>" + "<tr>"
		    	html += "<td>" +  resp.sys.country + " / "+ resp.name + "</td></tr>";
		    	var imgURL = "http://openweathermap.org/img/w/" + resp.weather[0].icon + ".png";
		    	html += "<tr><td><img src="+ imgURL +"></td></tr>"
		    	var temp = parseInt(resp.main.temp -273.15)
		    	html += "<tr><td colspan" +"=" + "2"+">"+ "현재 온도 : " + temp + "</td></tr>"
		    	html += "<tr><td colspan" +"=" + "2"+">"+ "현재 습도 : " + resp.main.humidity +"%" + "</td>";
		    	html += "<tr><td>풍속 : " + resp.wind.speed + "</td></tr>"
		    	html += "<td>풍향  : " +  resp.wind.deg + "º</td></tr>";
		    	html += "<tr><td colspan" +"=" + "2"+">"+ "구름  : "+ (resp.clouds.all) +"%"+ "<td></tr>";
		    	html += "</table>"
		    	$("weather2").append(html);
		    }
		})	
	</script>
		<script>
		//London , my_key = cf44bcda1d701285605a308a35cd5ef5
		var apiURI = "http://api.openweathermap.org/data/2.5/weather?q=London&appid=cf44bcda1d701285605a308a35cd5ef5";
		var result = document.getElementById('ajaxValue');
		$.ajax({
		    url: apiURI,
		    dataType: "json",
		    type: "GET",
		    async: "false",
		    success: function(resp) {
		    	var html="";
		    	html += "<table align=" + "center" + "class=" + "table table-condensed" + "style=" + "border:1px solid #dddddd>" + "<tr>"
		    	html += "<td>" +  resp.sys.country + " / "+ resp.name + "</td></tr>";
		    	var imgURL = "http://openweathermap.org/img/w/" + resp.weather[0].icon + ".png";
		    	html += "<tr><td><img src="+ imgURL +"></td></tr>"
		    	var temp = parseInt(resp.main.temp -273.15)
		    	html += "<tr><td colspan" +"=" + "2"+">"+ "현재 온도 : " + temp + "</td></tr>"
		    	html += "<tr><td colspan" +"=" + "2"+">"+ "현재 습도 : " + resp.main.humidity +"%" + "</td>";
		    	html += "<tr><td>풍속 : " + resp.wind.speed + "</td></tr>"
		    	html += "<td>풍향  : " +  resp.wind.deg + "º</td></tr>";
		    	html += "<tr><td colspan" +"=" + "2"+">"+ "구름  : "+ (resp.clouds.all) +"%"+ "<td></tr>";
		    	html += "</table>"
		    	$("weather3").append(html);
		    }
		})
	</script>
		<script>
		//Sydney , my_key = cf44bcda1d701285605a308a35cd5ef5
		var apiURI = "http://api.openweathermap.org/data/2.5/weather?q=Sydney&appid=cf44bcda1d701285605a308a35cd5ef5";
		var result = document.getElementById('ajaxValue');
		$.ajax({
		    url: apiURI,
		    dataType: "json",
		    type: "GET",
		    async: "false",
		    success: function(resp) {
		    	var html="";
		    	html += "<table align=" + "center" + "class=" + "table table-condensed" + "style=" + "border:1px solid #dddddd>" + "<tr>"
		    	html += "<td>" +  resp.sys.country + " / "+ resp.name + "</td></tr>";
		    	var imgURL = "http://openweathermap.org/img/w/" + resp.weather[0].icon + ".png";
		    	html += "<tr><td><img src="+ imgURL +"></td></tr>"
		    	var temp = parseInt(resp.main.temp -273.15)
		    	html += "<tr><td colspan" +"=" + "2"+">"+ "현재 온도 : " + temp + "</td></tr>"
		    	html += "<tr><td colspan" +"=" + "2"+">"+ "현재 습도 : " + resp.main.humidity +"%" + "</td>";
		    	html += "<tr><td>풍속 : " + resp.wind.speed + "</td></tr>"
		    	html += "<td>풍향  : " +  resp.wind.deg + "º</td></tr>";
		    	html += "<tr><td colspan" +"=" + "2"+">"+ "구름  : "+ (resp.clouds.all) +"%"+ "<td></tr>";
		    	html += "</table>"
		    	$("weather4").append(html);
		    }
		})
	</script>
	<script>
		//New Delhi , my_key = cf44bcda1d701285605a308a35cd5ef5
		var apiURI = "http://api.openweathermap.org/data/2.5/weather?q=New%20Delhi&appid=cf44bcda1d701285605a308a35cd5ef5";
		var result = document.getElementById('ajaxValue');
		$.ajax({
		    url: apiURI,
		    dataType: "json",
		    type: "GET",
		    async: "false",
		    success: function(resp) {
		    	var html="";
		    	html += "<table align=" + "center" + "class=" + "table table-condensed" + "style=" + "border:1px solid #dddddd>" + "<tr>"
		    	html += "<td>" +  resp.sys.country + " / "+ resp.name + "</td></tr>";
		    	var imgURL = "http://openweathermap.org/img/w/" + resp.weather[0].icon + ".png";
		    	html += "<tr><td><img src="+ imgURL +"></td></tr>"
		    	var temp = parseInt(resp.main.temp -273.15)
		    	html += "<tr><td colspan" +"=" + "2"+">"+ "현재 온도 : " + temp + "</td></tr>"
		    	html += "<tr><td colspan" +"=" + "2"+">"+ "현재 습도 : " + resp.main.humidity +"%" + "</td>";
		    	html += "<tr><td>풍속 : " + resp.wind.speed + "</td></tr>"
		    	html += "<td>풍향  : " +  resp.wind.deg + "º</td></tr>";
		    	html += "<tr><td colspan" +"=" + "2"+">"+ "구름  : "+ (resp.clouds.all) +"%"+ "<td></tr>";
		    	html += "</table>"
		    	$("weather5").append(html);
		    }
		})
	</script>
		<div align="center">
			<br>
			<br>
			<table align="center" class="table table-striped" style="width:80%;">
				<td><weather1></weather1></td><!-- korea, seoul -->
				<td><weather2></weather2></td><!-- USA, Washington -->
				<td><weather3></weather3></td><!-- UK, London -->
				<td><weather4></weather4></td><!-- AUS, Sydney -->
				<td><weather5></weather5></td><!-- ROI, New Delhi -->
			</table>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</body>
</html>