<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<%@ include file="DBOpen.jsp" %>
<%@ include file="PageNav.jsp" %>  
<%
try
{
	PreparedStatement mStmt;
	PreparedStatement mStmt2;
	String sql = "delete from reply where no = " + no;
	mStmt      = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	mStmt.executeUpdate();
	mStmt.close();
	
			sql = "delete from board where no = " + no;
	mStmt2      = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	mStmt2.executeUpdate();
	mStmt2.close();
}
catch (Exception e)
{
	out.println("ERROR:" + e.getMessage());
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<link href="../style/header.css" rel="stylesheet" type="text/css">
<link href="../style/board.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<meta charset="EUC-KR">
<title>DELETE</title>
</head>
<body>
<header>
	<img src="../images/LOGO.png" id="mainimg" width="300px" onclick="location.href='../main/Main.jsp'" alt="Mainimage">
	<div id="lojo">
			<%
			String vid = (String)session.getAttribute("ID"); // 이름이 ID인 세션값을 받아옴 
			String vnick = (String)session.getAttribute("NICK"); // 이름이 ID인 세션값을 받아옴 
			String vu_no = (String)session.getAttribute("U_NO"); // 이름이 ID인 세션값을 받아옴 
			if(vid == null)
			{
				%>
				<a href="../user/Login.jsp">로그인</a><a href="../user/Join.jsp">회원가입</a>
				<%
			}else
			{
				%>
			
			<a href="../mypage/Mypage.jsp"><%= vnick %></a><span style="color:white">님 환영합니다.</span>
				<%				
			}
			%>
			<%
			if(vid != null)
			{
				%>
				<span><a href="../user/LogoutAction.jsp">로그아웃</a></span>
				<%
			}
			%>
		</div>
</header>
	<nav id="navi">
		<div id="menu">
		<ul id="main-menu">
			<li><a href="Talkboard.jsp">공감톡</a></li>
			<li><a href="Information.jsp">금연정보</a></li>
			<li><a href="../mypage/Mypage.jsp">마이페이지</a></li>
		</ul>
		</div>
	</nav>
		<section>
			<article>
				<div class="container" role="main" style="padding-left:250px;">
					<h1 style="display:inline;" ><b>정상적으로 처리되었습니다.</b></h1> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-sm btn-primary" id="btnList" onclick="location.href ='Talkboard.jsp?no=<%= no %>&page=<%= curpg %>&<%= adParam %>';">목록</button>
				</div>
			</article>
		</section>
</body>
</html>
<%@ include file="DBClose.jsp" %>