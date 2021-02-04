<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%
String no      = request.getParameter("no");
String type    = request.getParameter("type");    //select type
String keyword = request.getParameter("keyword"); //input  keyword
if (type == null)
{
	type = "1";
}
if (keyword == null)
{
	keyword = "";
}
String adParam = "type=" + type + "&keyword=" + keyword; //type과 keyword

String curpg   = request.getParameter("page");           //현재 페이지 번호
if (curpg == null)
{
	curpg = "1";
}
%>