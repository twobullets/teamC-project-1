<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> <!-- 첨부파일 -->
<%@ page import="com.oreilly.servlet.MultipartRequest"%> <!-- 첨부파일 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> <!-- 첨부파일 -->
<%@ include file="DBOpen.jsp" %>
<%
request.setCharacterEncoding("UTF-8"); //한글 입력 가능.
String saveFolder      = "C:/eugene/Team/WebContent/board/FileUpload";
String encoding        = "UTF-8";
int maxSize            = 10*1024*1024; //10mb
MultipartRequest multi = new MultipartRequest(request, saveFolder, maxSize, encoding, new DefaultFileRenamePolicy());
String title           = (String)multi.getParameter("title");
String content         = (String)multi.getParameter("content");
String realF           = multi.getFilesystemName("fileUp"); //filename은 중복이름이 들어올 경우 자동으로 index가 붙는데, index되기 전의 원본명
String originF         = multi.getOriginalFileName("fileUp");
String vu_no           = (String)session.getAttribute("U_NO");
if(title == null || content == null)
{
	out.print("입력된 자료가 없습니다.");
	return;	
}

title    = title.replace("'","''");
content  = content.replace("'","''");

String sql  = "insert into board (u_no,title,content,wdate,originF,realF) ";
       sql += "values ('"+vu_no+"','"+ title +"','"+ content +"',now(),'"+ originF +"','"+ realF +"')";
     //sql += "values (?,?) ";

PreparedStatement mStmt;
mStmt  = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
//mStmt.setString(1,title);
//mStmt.setString(2,body);
mStmt.executeUpdate();
mStmt.close();

sql   = "select last_insert_id()";
mStmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
ResultSet rs = mStmt.executeQuery();
rs.next();
int ArtiNo = rs.getInt(1);
rs.close();
mStmt.close();
//out.print(ArtiNo);
try
{

	//파일이 서버에 업로드되는 시점은 MultipartRequest 객체 생성 순간이다. 
	
	//request가 되는 순간 null로 변한다. 
	//out.print("성공");
	
	realF           = multi.getFilesystemName("fileUp"); //filename은 중복이름이 들어올 경우 자동으로 index가 붙는데, index되기 전의 원본명
	originF         = multi.getOriginalFileName("fileUp");
	String type     = multi.getContentType("fileUp");    //타입을 구별해줌
	File f          = multi.getFile("fileUp");           //파일을 사용할 준비
	int len = 0; 
	if( f != null) //파일의 크기를 알려준다.
	{ 
		len = (int)f.length(); 
	}


%> <!--  
	SAVE      : <%= realF %><p/> 
	ORIGINAL  : <%= originF %><p/> 
	TYPE      : <%= type %><p/> 
	SIZE      : <%= len %><p/>
	-->
<% 
}catch (Exception e) 
{ 
	e.printStackTrace(); 
} 
%>
<%@ include file="DBClose.jsp" %>
<%
response.sendRedirect("View.jsp?no="+ArtiNo); // WriterOk.jsp를 지나서 바로 작성한 글 상세보기 페이지(View.jsp)로 이동
%>