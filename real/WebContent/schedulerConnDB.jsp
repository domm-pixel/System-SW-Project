<!-- 스케줄러의 구현중
	DB에 접속을 위한 코드가 많이 중복되기에 이 페이지로 이용	-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" import="java.sql.*"%>

<%
// 데이터베이스 연결관련 변수 선언
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
// 데이터베이스 연결관련정보를 문자열로 선언
			String dbURL = "jdbc:mysql://localhost:3301/JSP?useUnicode=true&characterEncoding=UTF-8";
			String dbID = "root";
			String dbPassword = "markany1@";
			Class.forName("com.mysql.jdbc.Driver");
// 데이터베이스 연결정보를 이용해 Connection 인스턴스 확보
conn = DriverManager.getConnection(dbURL,dbID,dbPassword);	
%>