<%@ page language="java" contentType="text/html; charset=UTF-8"
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
		String u_no   = request.getParameter("u_no");
		
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement psmt = null;
	 try 
	 {
		 String dbURL = "jdbc:mysql://192.168.0.68/team?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
		 String dbID = "root"; 
		 String dbPassword = "mySQL1234";
		 Class.forName("com.mysql.jdbc.Driver");
		 conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		
		 String sql = "insert into users values(u_no,?,?,?,?,0) "; 
		 	psmt = conn.prepareStatement(sql); 
			psmt.setString(1,u_name);
			psmt.setString(2,id);
			psmt.setString(3,pw); 
			psmt.setString(4,nick); 
			psmt.executeUpdate();
		}catch(Exception e) 
		{ 
			e.printStackTrace(); 
		}finally
		{
			psmt.close();
			conn.close();
		}
	 %>

	 <script>
	 alert('가입에 성공하셧습니다.');
	 location.href = 'Login.jsp'
	 </script>


	 
		