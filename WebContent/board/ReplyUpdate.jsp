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
String r_content = request.getParameter("content");
int    r_no      = Integer.parseInt(request.getParameter("r_no"));


PreparedStatement mStmt =null;
String sql  = "update reply set r_content = ?, r_date = now() where r_no = ?";
mStmt  = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
mStmt.setString(1,r_content);
mStmt.setInt(2,r_no);
mStmt.executeUpdate();

PreparedStatement mStmt2 = null;
sql = "select nick from users where u_no = " + uNo ;
mStmt2  = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
ResultSet rst = mStmt2.executeQuery();
rst.next();
String nick = rst.getString("nick");
rst.close();

PreparedStatement mStmt3 = null;
sql = "select * from reply where r_no ="+r_no +" ";
mStmt3  = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

ResultSet rs = mStmt3.executeQuery();

JSONArray jsonArrList = new JSONArray();

rs.next();

JSONObject jsonList = new JSONObject();
jsonList.put("nick", nick);
jsonList.put("r_no", rs.getString("r_no"));
jsonList.put("r_date", rs.getString("r_date").substring(0,10));
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