<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> <!-- 첨부파일 -->
<%@ page import="com.oreilly.servlet.MultipartRequest"%> <!-- 첨부파일 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> <!-- 첨부파일 -->
<%@ include file="DBOpen.jsp" %>
<%@ include file="PageNav.jsp" %>  
<%
request.setCharacterEncoding("UTF-8");
String saveFolder      = "D:/jsh/Team/WebContent/board/FileUpload";
String encoding        = "UTF-8";
int maxSize            = 10*1024*1024; //10mb
MultipartRequest multi = new MultipartRequest(request, saveFolder, maxSize, encoding, new DefaultFileRenamePolicy());
String title           = (String)multi.getParameter("title");
String content         = (String)multi.getParameter("content");
String realF           = multi.getFilesystemName("fileUp"); //filename은 중복이름이 들어올 경우 자동으로 index가 붙는데, index되기 전의 원본명
String originF         = multi.getOriginalFileName("fileUp");
String vu_no           = (String)session.getAttribute("U_NO");
int    num             = Integer.parseInt(multi.getParameter("no"));

if(title == null || content == null)
{
	out.print("입력된 자료가 없습니다.");
	return;	
}
title    = title.replace("'","''");
content  = content.replace("'","''");
try
{	
	PreparedStatement mStmt;
	ResultSet         rs;	
	
	String sql  = "update board set ";
		   sql += "title = '" + title + "', ";
		   sql += "content = '" + content + "', ";
		   if(originF != null)
		   {
		  	 	sql += "originF = '" + originF + "', ";
		   		sql += "realF = '"+ realF +"', ";
		   }
		   sql += "wdate = now() ";
		   sql += "where no = " + num;
	mStmt  = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	mStmt.executeUpdate();
	mStmt.close();

	realF           = multi.getFilesystemName("fileUp"); //filename은 중복이름이 들어올 경우 자동으로 index가 붙는데, index되기 전의 원본명
	originF         = multi.getOriginalFileName("fileUp");
	String typeF    = multi.getContentType("fileUp");    //타입을 구별해줌
	File f          = multi.getFile("fileUp");           //파일을 사용할 준비
	int len = 0; 
	if( f != null) //파일의 크기를 알려준다.
	{ 
		len = (int)f.length(); 
	}
%> <!--  
	SAVE      : <%= realF %><p/> 
	ORIGINAL  : <%= originF %><p/> 
	TYPE      : <%= typeF %><p/> 
	SIZE      : <%= len %><p/>
	-->
<% 
}
catch (Exception e)
{
	out.println("ERROR:" + e.getMessage());
	return;
}
//out.println("자료를 입력하였습니다.");
%>
<!-- <a href="View.jsp?no=<%= num %>&page=<%= curpg %>&<%= adParam %>">확인</a> -->
<%
response.sendRedirect("View.jsp?no="+num+"&page="+curpg+"&"+adParam); // WriterOk.jsp를 지나서 바로 작성한 글 상세보기 페이지(View.jsp)로 이동
%>
<%@ include file="DBClose.jsp" %>