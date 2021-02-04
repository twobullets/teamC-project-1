<%@ page language="java" contentType="text/html;"
    pageEncoding="UTF-8"%>

	<%
	session.setAttribute("ID",null);
	session.setAttribute("NICK",null);
	session.setAttribute("U_NO",null);
	%>
	<script>
		alert('로그아웃되셨습니다.');
		location.href = '../main/Main.jsp';
	</script>