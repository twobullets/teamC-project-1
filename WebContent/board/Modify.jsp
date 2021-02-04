<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="DBOpen.jsp" %>
<%@ include file="PageNav.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
try
{
	PreparedStatement mStmt;
	ResultSet         rs;		

	String sql = "select no,title,content,hit,originF from board where no = " + no;

	mStmt= conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs = mStmt.executeQuery();
	rs.next();
	
	v_no      = rs.getString("no");
	v_title   = rs.getString("title");
	v_content = rs.getString("content");
	v_hit     = rs.getString("hit");
	v_originF = rs.getString("originF");
	
	//검색된 결과를 닫는다.
	rs.close();

	//stmt 를 닫는다.
	mStmt.close();	
}catch(Exception e)
{
	out.println("ERROR:" + e.getMessage());
}
%>   
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery-3.5.1.min.js"></script>
<link href="../style/header.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	section
	{
		width:100%;
	}
	article
	{
		width:70%;
		background-color: white;
		margin:0px auto;
	}
	form
	{
		position:relative;
		margin-right:0px;
	}
	.container
	{
		padding-top: 5%;
		padding-bottom: 10%;
	}
	
	#texta1{width:700px; height:40vh; font-size:30px;}
	#texta2{width:700px; height:10vh;}
	#board1{width:300px;height:30px; margin:3px;}
	#board2{width:690px; height:30px;margin:3px;}
	.click1{position:absolute; bottom:8%; right:660px; width:50px;}
	.click2{position:absolute; bottom:8%; right:605px; width:50px;}
	.fnt
	{
		border-bottom: 1px solid gray;
		
	}
</style>
</head>
<body>
<script type="text/javascript">

	function DoSubmit()
	{
		if(form.title.value == "")
		{
			alert("제목을 입력하세요.");
			form.title.focus();
			return;
		}
		if(form.content.value == "")
		{
			alert("내용을 입력하세요.");
			form.content.focus();
			return;
		}
		form.submit();
	}
	
</script>
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
			
				<a href="../mypage/Mypage.jsp"><%= vnick %></a></h3><span style="color:white">님 환영합니다.</span>
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
					<li><a href="../information/Information.jsp">금연정보</a></li>
					<li>
					<%
					if(vid == null)
					{
						%>
						<a href="javascript:alert('로그인이 필요합니다.')">금연계산기</a>
						<%
					}else
					{
						%>
						<a href="../mypage/Mypage.jsp">금연계산기</a>
						<%				
					}
					%>
				</li>
				</ul>
			</div>
		</nav>
	<section>
		<article>
		<div class="container" role="main">
			<h1 class="mt-3" style="margin-bottom:20px;"><b>수정하기</b></h1>
			<form name="form" id="form" role="form" method="post" action="ModifyOk.jsp" enctype="multipart/form-data">
				<input type="hidden" name="no" value="<%= v_no%>">
				<div class="mb-3">
					<label for="title">제목</label>
					<input type="text" class="form-control" name="title" id="title" value="<%= v_title %>">
				</div>
				<div class="mb-3">
					<label for="content">내용</label>
					<textarea class="form-control" rows="5" name="content" id="content" ><%= v_content %></textarea>
				</div>
				<div class="mb-3">
					<label for="file">첨부파일</label>&nbsp;&nbsp;&nbsp;
					<%= v_originF %>
					<input type="file" class="form-control" name="fileUp" id="fileUp">
				</div>
			</form>
			<div align="right">
				<button type="button" class="btn btn-sm btn-primary" id="btnSave" onclick="javascript:DoSubmit();">저장</button>
				<button type="button" class="btn btn-sm btn-primary" id="btnList" onclick="location.href ='View.jsp?no=<%= v_no %>&page=<%= curpg %>&<%= adParam %>';">취소</button>
			</div>
		</div>
		</article>
	</section>
</body>
</html>
<%@ include file="DBClose.jsp" %>