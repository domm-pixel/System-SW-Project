<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
body, hmtl {
	background: #ffffff;
}
</style>
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
<title>kakao map api</title>
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
				<li><a href="scheduler.jsp">스케줄</a></li>
				<li class="active"><a href="map.jsp">지도</a></li>
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
	<!-- 
	 마크애니 좌표 37.563090, 127.003595
	 키 d6b6b9c29a4e013b76aea8b234dd4948
 -->
	<div align="center" id="map" style="width: 100%; height: 550px;"></div>
	<p>
		<button onclick="setOverlayMapTypeId('traffic')">교통정보 보기</button>
		<button onclick="setOverlayMapTypeId('roadview')">로드뷰 도로정보 보기</button>
		<button onclick="setOverlayMapTypeId('terrain')">지형정보 보기</button>
		<button onclick="setOverlayMapTypeId('use_district')">지적편집도
			보기</button>
	</p>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d6b6b9c29a4e013b76aea8b234dd4948"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.563090, 127.003595), // 지도의 중심좌표
			level : 2
		// 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		// 지도에 추가된 지도타입정보를 가지고 있을 변수입니다
		var currentTypeId;

		// 버튼이 클릭되면 호출되는 함수입니다
		function setOverlayMapTypeId(maptype) {
			var changeMaptype;

			// maptype에 따라 지도에 추가할 지도타입을 결정합니다
			if (maptype === 'traffic') {

				// 교통정보 지도타입
				changeMaptype = kakao.maps.MapTypeId.TRAFFIC;

			} else if (maptype === 'roadview') {

				// 로드뷰 도로정보 지도타입
				changeMaptype = kakao.maps.MapTypeId.ROADVIEW;

			} else if (maptype === 'terrain') {

				// 지형정보 지도타입
				changeMaptype = kakao.maps.MapTypeId.TERRAIN;

			} else if (maptype === 'use_district') {
				// 지적편집도 지도타입
				changeMaptype = kakao.maps.MapTypeId.USE_DISTRICT;
			}
			// 이미 등록된 지도 타입이 있으면 제거합니다
			if (currentTypeId) {
				map.removeOverlayMapTypeId(currentTypeId);
			}
			// maptype에 해당하는 지도타입을 지도에 추가합니다
			map.addOverlayMapTypeId(changeMaptype);

			// 지도에 추가된 타입정보를 갱신합니다
			currentTypeId = changeMaptype;
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</body>
</html>