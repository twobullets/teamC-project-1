<%@ page language="java" contentType="text/html;"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
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
	String u_no  = request.getParameter("u_no");
	
	/*if(id.equals("test"))
	{
		out.print("OK");
	}else
	{
		out.print("아이디가 틀렸수");
	}
	*/
	
	Connection conn = null;
	ResultSet rs = null;
	ResultSet rs2  = null;  //다른 것을 사용해야함
	PreparedStatement psmt = null;
	PreparedStatement psmt2 = null;
	try 
	 {
		 String dbURL = "jdbc:mysql://192.168.0.68/team?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
		 String dbID = "root"; 
		 String dbPassword = "mySQL1234";
		 Class.forName("com.mysql.jdbc.Driver");
		 conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		
		
		String sql = "select id,nick,u_no,pw from users where id=? " ; //id랑 pw값가져와서 갯수(cnt) 출력
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,id);
		rs = psmt.executeQuery(); 
		if(rs.next()== true) 
		{
		
				String vid =rs.getString("id"); // db에서 찾아온 값이 지정됨
				String vnick =rs.getString("nick"); // 
				String vu_no =rs.getString("u_no"); // 
				String vpw =rs.getString("pw"); //
				if(vpw.equals(pw))
				{				
				out.print("0"); // true 저장된 (TRUE)아이디
				session.setAttribute("ID", vid); //ID는 세션이름선언 id는 실제 값 
				session.setAttribute("NICK", vnick);
				session.setAttribute("U_NO", vu_no); 
					//로그인 성공
				}else
				{
					//비번틀림
					out.print("1");
					
				}
				
		} 
	
			
		}catch(Exception e)
		{
			e.printStackTrace();
		
		}finally  // 어떻게든 실행이 되는 구문
		{
			try 
			{
				if(rs!= null)rs.close();
				if(rs2!= null)rs2.close();
				if(psmt!=null)psmt.close();
				if(psmt2!=null)psmt2.close();
			}catch(Exception e)
			{
				e.printStackTrace();
			}
			conn.close();

		}

%>