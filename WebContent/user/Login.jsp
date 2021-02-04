<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
    <%   	
	session.setAttribute("ID",null);
	session.setAttribute("NICK",null);
	session.setAttribute("U_NO",null);
    %>
    
<!DOCTYPE html>
<html>
	<head>
	<link rel="stylesheet" type="text/css" href="../style/login.css"/>
		<title>LOGIN</title>
		<script src="../js/jquery-3.5.1.min.js"></script>	
	</head>
		<script>
		var fa = true;
		var fb = true;
		function Dosubmit()
		{
	 		var pw = document.getElementById('pw').value;
			var id = document.getElementById('id').value;
			if(id ==""|| pw=="")
			{
				alert("입력하지 않은사항이 있습니다.")
				return;
			}
			 var id = $('#id').val();
		 	 var pw = $('#pw').val();
			 $.ajax({
				 type:'post',
				 url:'Loginpwcheck.jsp',
				 data:{id:id,pw:pw},
				 success:function(result)
				 {
							
					 if(result.trim() == "0")
					{					
						//document.login.submit();
						document.location="../main/Main.jsp";
						 return;
					}
					 if(result.trim() == "1")
					{
						alert("비밀번호가 틀렸습니다.");
					}
					 else
					 {
						 alert("아이디가 없습니다.");
					 } 
				 }	
			});
		}
		</script>	
	<body>
		<section>
			<article style="margin-top:13%">
				<img src="../images/LOGO2.png" onclick="location.href='../main/Main.jsp'" style="width: 200px">
				<form action="Loginok.jsp" method="post" id="login" name="login">
					<input type="text" name="id" id="id" placeholder="아이디" style="ime-mode:disabled;"><br>
					<input type="password" name="pw" id="pw" placeholder="비밀번호"style="ime-mode:disabled;"><br>
					<input type="hidden" name="u_name" id="u_name">
					<input type="hidden" name="nick" id="nick">
					<input type="hidden" name="pw2" id="pw2">		
					<button type="button" onclick="Dosubmit()" >로그인</button>
				</form>
				<br>
				<nav>
				<a href="#">아이디 찾기</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">비밀번호 찾기</a>
				</nav>
			</article>
		</section>
		<footer>
			<div>
				금연 화이팅 하세요!
			</div>
		</footer>
	</body>
</html>
