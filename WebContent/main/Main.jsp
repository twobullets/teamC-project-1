<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String vid = (String)session.getAttribute("ID"); // 이름이 ID인 세션값을 받아옴 
String vnick = (String)session.getAttribute("NICK"); // 이름이 ID인 세션값을 받아옴 
String vu_no = (String)session.getAttribute("U_NO"); // 이름이 ID인 세션값을 받아옴 
%>
<html>
<head>
	<link href="../style/main.css" rel="stylesheet" type="text/css">
	<title>MAIN</title>
</head>
<style>
	ul
	{
		list-style: none;
	}
	li
	{
		display: inline-block;
		text-align: center;
		padding-top: 300px;
	}
	.container
	{

		width :100%;
		height : 1000px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.item
	{ 
		width:200px;
		height: 250px;
		border:10px solid white;
		margin :-100px 50px 20px 50px;
	}
	.item:hover 
	{
		border :10px solid #B90000;
	}
	.item p
	{
		color: white;
		font-size: 25px;
		font-weight: bold;
	}
	h3
	{
		display:inline;
	}
</style>
<body>
	<div class="container">
		<div id="logo">
			<img src="../images/LOGO.png" width="300px" onclick="location.href='Main.jsp'">
		</div>
		<div id="lojo">
			<%
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
		<ul>
			<li>
				<div class="item">
					<img src="../images/aksu.png" width="130px" onclick="location.href='../board/Talkboard.jsp'" style="padding-top: 15px">
					<p>공감톡</p>
				</div>
			</li>
			<li>
				<div class="item">
					<img src="../images/help.png" width="130px" onclick="location.href='../information/Information.jsp'" style="padding-top: 15px">
					<p>금연정보</p>
				</div>
			</li>
			<li>
				<div class="item">
						<%
						if(vid == null)
						{
						%>
					<img src="../images/mypage.png" width="130px" onclick="javascript:alert('로그인이 필요합니다.')" style="padding-top: 15px">
					<p>금연계산기</p>
						<%
						}else
						{
						%>
					<a href="../mypage/Mypage.jsp"><img src="../images/mypage.png" width="130px" style="padding-top: 15px"></a>
					<p>금연계산기</p>
						<%				
						}
						%>					
				</div>
			</li>
		</ul>
	</div>
</body>
</html>