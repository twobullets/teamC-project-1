<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ include file="DBOpen.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

int r_no = Integer.parseInt(request.getParameter("r_no"));

PreparedStatement mStmt =null;
String sql  = "delete from reply where r_no=?";
mStmt  = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
mStmt.setInt(1,r_no);
mStmt.executeUpdate();
mStmt.close();
%>
<%@ include file="DBClose.jsp" %>