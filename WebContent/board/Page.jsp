<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

	<ul>
		<li align="center" height="40">
			<%
			for(int j = 1; j <= maxPage; j++)
			{
				%><a href="Talkboard.jsp?page=<%= j %>&<%= adParam %>"><%= j %></a>&nbsp;&nbsp;<%
			}
			%> 
		</li>
	</ul>
