<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="../style/header.css" rel="stylesheet" type="text/css">
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
	<script type="text/javascript"></script>
	<script>
		
	</script>
	<style>
		img#mainimg
		{
			cursor: pointer;
		}
		#in1
		{
			position: absolute;
			left: 15%;
			margin-top: 50px
			background-color:white;
			display: inline-block;
		}
		
		#in1 li
		{
			display: inline-block;
			margin-left:50px;
			
			padding:69px;
		}
		section
		{
			height:100vh;
		}
	</style>
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
					<li><a href="../board/Talkboard.jsp">공감톡</a></li>
					<li><a href="Information.jsp">금연정보</a></li>
					<li>
					<%
					if(vid == null)
					{
						%>
						<a href="javascript:alert('로그인이 필요합니다.')">마이페이지</a>
						<%
					}else
					{
						%>
						<a href="../mypage/Mypage.jsp">마이페이지</a>
						<%				
					}
					%>
				</li>
				</ul>
			</div>
		</nav>
		<section>
			<article>
				<div>
					<ul id="in1">
						<li><a href="http://www.mohw.go.kr/"><img src="../images/smoke3.jpg" ></a></li>
						<li><a href="https://www.nosmokeguide.go.kr/index.do"><img src="../images/smoke1.png" width="400px" height="400px"></a></li>
						<li><a href="https://www.ncc.re.kr/main.ncc?uri=manage03"><img src="../images/smoke2.jpg" width="400px" height="400px"></a></li>
						<li><a href="https://nosmk.khealth.or.kr/nsk/user/extra/ntcc/261/service/nosmokeServiceSearch/jsp/LayOutPage.do"><img src="../images/smoke4.png" width="400px" height="400px"></a></li>
					</ul>
				</div>
			</article>
		</section>
	</body>
</html>