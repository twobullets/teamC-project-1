<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ include file="DBOpen.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String no        = request.getParameter("no");
String uNo       = request.getParameter("uNo");
String r_content = request.getParameter("rep1");
String vu_no = (String)session.getAttribute("U_NO");

String sql  = "insert into reply (no,r_content,r_date,u_no) ";
	   sql += "values (?,?,now(),?) ";

PreparedStatement mStmt =null;
mStmt  = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
mStmt.setInt(1,Integer.parseInt(no));
mStmt.setString(2,r_content);
mStmt.setInt(3,Integer.parseInt(vu_no));
mStmt.executeUpdate();


PreparedStatement mStmt2 = null;
sql = "select nick from users where u_no = " + vu_no ;
mStmt2  = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
ResultSet rst = mStmt2.executeQuery();
rst.next();
String nick = rst.getString("nick");
rst.close();

PreparedStatement mStmt3 = null;
sql = "select * from reply where r_no = (select max(r_no) from reply )";
mStmt3  = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

ResultSet rs = mStmt3.executeQuery();

JSONArray jsonArrList = new JSONArray();

rs.next();

JSONObject jsonList = new JSONObject();
jsonList.put("nick", nick);
jsonList.put("r_no", rs.getString("r_no"));
jsonList.put("r_date", rs.getString("r_date"));
jsonList.put("r_content", rs.getString("r_content"));
jsonList.put("u_no", rs.getString("u_no"));
jsonArrList.add(jsonList);

out.print(jsonArrList);

int ArtiNo = rs.getInt(1); 

rs.close(); 
mStmt.close();
mStmt2.close();
mStmt3.close();
%>
<%@ include file="DBClose.jsp" %>