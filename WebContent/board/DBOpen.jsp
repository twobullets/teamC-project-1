<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
Class.forName("com.mysql.cj.jdbc.Driver");

String mDBMS     = "jdbc:mysql://192.168.0.68/team?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
String mUserID   = "root";
String mUserPass = "mySQL1234";

//게시물 자료
String v_no        = "";
String v_title     = "";
String v_content   = "";
String v_wdate     = "";
String v_hit       = "";
String v_originF   = "";
String v_u_no      = "";
String v_r_no      = "";
String v_r_content = "";
String v_r_date    = "";

Connection  conn = DriverManager.getConnection( mDBMS, mUserID ,mUserPass );

%>