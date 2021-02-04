<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="../style/header.css" rel="stylesheet" type="text/css">
<link href="../style/board.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<meta charset="EUC-KR">
<title>WRITER</title>
</head>
<body>
<script src="../js/jquery-3.5.1.min.js"></script>
<script language="javascript">
	function Datacheck()
	{
		if(document.form.title.value == "")
		{
			alert("제목을 입력하세요.");
			document.form.title.focus();
			return;
		}
		if(document.form.content.value == "")
		{
			alert("내용을 입력하세요.");
			document.form.content.focus();
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
				<h1 class="mt-3" style="margin-bottom:20px;"><b>글쓰기</b></h1><p/>
				<form name="form" id="form" role="form"  method="post" enctype="multipart/form-data" action="WriterOk.jsp">
					<input type="hidden" id="u_no" name="u_no">
					<div class="mb-3">
						<label for="title">제목</label>
						<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요">
					</div>
					<div class="mb-3">
						<label for="content">내용</label>
						<textarea class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력해 주세요" ></textarea>
					</div>
					<div class="mb-3">
						<label for="fileUp">첨부파일</label>
						<input type="file" class="form-control" id="fileUp" name="fileUp">
					</div>
				</form>
				<div align="right">
					<button type="button" class="btn btn-sm btn-primary" id="btnSave" onclick="javascript:Datacheck()">저장</button>
					<button type="button" class="btn btn-sm btn-primary" id="btnList" onclick="location.href ='Talkboard.jsp';">취소</button>
				</div>
			</div>
		</article>
	</section>
</body>
</html>
