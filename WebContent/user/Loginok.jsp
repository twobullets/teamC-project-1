<%@ page language="java" contentType="text/html;"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%
		String u_name = request.getParameter("u_name");
		String nick   = request.getParameter("nick");
		String id     = request.getParameter("id");
		String pw     = request.getParameter("pw");
		String pw2 	  = request.getParameter("pw2");
		int u_no  = Integer.parseInt(request.getParameter("u_no"));
%>
	 <script>
	 
	 alert('로그인에 성공하셧습니다.');
	 location.href = '../main/Main.jsp'	 
	 </script>