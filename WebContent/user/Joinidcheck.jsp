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
		
		
		String sql = "select*from users where id=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,id); // getId()?
		rs = psmt.executeQuery();
		if(rs.next()||id.equals("")) 
		{
			out.print(0); // true 이미 존재하는 아이디
		}
		else 
		{
			out.print(1); // false  사용가능한 아이디 
		}
			
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}finally  // 어떻게든 실행이 되는 구문
		{
			try 
			{
				if(rs!= null)rs.close();
				if(psmt!=null)psmt.close();
			}catch(Exception e)
			{
				e.printStackTrace();
			}
			conn.close();
		}

	
%>