<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="DBOpen.jsp" %>
<%	
String type    = request.getParameter("type");    //select type
String keyword = request.getParameter("keyword"); //input  keyword
if (type == null)
{
	type = "1";
	
}
if (keyword == null)
{
	keyword = "";
}
String adParam = "type=" + type + "&keyword=" + keyword;

String curpg   = request.getParameter("page"); //현재 페이지 번호

if (curpg == null)
{
	curpg = "1";
}
%>
<!DOCTYPE html>
<html>
<head>
<link href="../style/header.css" rel="stylesheet" type="text/css">
<link href="../style/board.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<meta charset="EUC-KR">
<title>TALKBOARD</title>
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
		padding-bottom: 5%;
	}
	
</style>
</head>
<body>
<script src="../js/jquery-3.5.1.min.js"></script>
<script>
</script>
<header>
	<img src="../images/LOGO.png" id="mainimg" width="300px" onclick="location.href='../main/Main.jsp'" alt="Mainimage">
	<div id="lojo">
			<%
			String vid = (String)session.getAttribute("ID");     // 이름이 ID인 세션값을 받아옴 
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
		 <div class="container">
			<h2><b>공감톡</b></h2>
			<div id="searchbox" name="searchbox" >
				<form align="right" id="fm" name="fm" method="get" action="Talkboard.jsp">
					<select id="type" name="type"> <!-- 검색 구문 -->
						<% 
						if( type.equals("A"))
						{
							%><option value="A" selected>전체</option><%
						}else
						{
							%><option value="A">전체</option><%
						}
						if( type.equals("T"))
						{
							%><option value="T" selected>제목</option><%
						}else
						{
							%><option value="T">제목</option><%
						}
						if( type.equals("C"))
						{
							%><option value="C" selected>내용</option><%
						}else
						{
							%><option value="C">내용</option><%
						}
						%>		
					</select>
					<input type="text" id="keyword" name="keyword" value=<%= keyword %>>
					<input type="submit" value="검색">
				</form>
			</div>
			<form id="f1" name="f1">
				<div>
					<table class="table table-hover">
						<thead>
							<tr align="center">
								<th>번호</th>
								<th>제목</th>
								<th>댓글수</th>
								<th>닉네임</th>
								<th>조회수</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody id="t1">
						<%
							int pgno        = 0; //페이지 번호
							int perpg       = 0; //페이지 마다 보일 목록 수
							int startpg     = 0; //시작 페이지 번호
							int recordTotal = 0; //담는 페이지
							
							try
							{
								PreparedStatement mStmt;
								ResultSet         rs;
								String sql  = "select count(*) as cnt from board ";
								if( !keyword.equals("")) // where를 넣어서 검색된 수에 따라 페이징 처리.
								{
									switch(type)
									{
									case "A" : // 전체검색
										sql += "where title like '%"+ keyword +"%' ";
										sql += "or content like '%"+ keyword +"%'";
									break;
									case "T" : // 제목검색
										sql += "where title like '%"+ keyword +"%'";
									break;
									case "C" : // 내용검색
										sql += "where content like '%"+ keyword +"%'";
									break;
									}
								}
								mStmt       = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
								rs          = mStmt.executeQuery(); // 주어질 sql 구문 입력.
								rs.next();
								recordTotal = Integer.parseInt(rs.getString("cnt")); //count문은 결과 값이 무조건 정수.
								
								rs.close();      //검색된 결과를 닫는다.(쿼리 실행 종료)
								mStmt.close();   //stmt를 닫는다.(쿼리 실행 종료)
								
								pgno    = Integer.parseInt(curpg);   //페이지 번호
								perpg   = 10;                        //페이지 마다 보일 목록 수
								startpg = ((pgno - 1) * perpg) ;     //시작 페이지 번호
										
								sql = "select no, title, wdate, hit, (select nick from users where u_no = board.u_no) as nick, (select count(*) from reply where no = board.no) as rcnt from board ";
								
								if( !keyword.equals(""))
								{
									switch(type)
									{
									case "A" : // 전체검색
										sql += "where title like '%"+ keyword +"%' ";
										sql += "or content like '%"+ keyword +"%'";
									break;
									case "T" : // 제목검색
										sql += "where title like '%"+ keyword +"%'";
									break;
									case "C" : // 내용검색
										sql += "where content like '%"+ keyword +"%'";
									break;
									}
								}
								sql += "order by no desc ";
								sql += "limit " + startpg + "," + perpg ;
								
								mStmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
								rs    = mStmt.executeQuery();
								
								int i = recordTotal - ((pgno - 1) * perpg); // 게시물 번호
								
								while(rs.next())
								{	
									String Tno      = rs.getString("no");     //번호
									String Ttitle   = rs.getString("title");  //제목
									String Thit     = rs.getString("hit");    //조회수
									String Twdate   = rs.getString("wdate");  //작성일
									String Tnick    = rs.getString("nick");	  //닉네임
									int    Trcnt    = Integer.parseInt(rs.getString("rcnt")); //댓글수
									if(Tnick == null)
									{
										Tnick = "-";
									}
									Ttitle = Ttitle.replace(keyword,"<font color=red>"+keyword+"</font>");
							%>
								<tr bgcolor="white">
									<td align="center"><%= i-- %></td>
									<td><a href="View.jsp?no=<%= Tno %>&page=<%=curpg%>&<%=adParam%>"><%= Ttitle %></a></td>
									<td align="center"><%= Trcnt %></td>
									<td align="center"><%= Tnick %></td>
									<td align="center"><%= Thit %></td>
									<td align="center"><%= Twdate %></td>
								</tr>
							<%
							}
							rs.close();
							mStmt.close();
								
							}catch(Exception e)
							{
								out.println("ERROR : " +e.getMessage());
								return;
							}
							%>
						</tbody>
					</table>
				</div>
				</form>
				<%
					// 페이징 처리
					int maxPage = recordTotal / perpg ;
					if((recordTotal % perpg) != 0)
					{
						maxPage++;
					}
				%>
			<div align="right" >
			<%@ include file="Page.jsp" %>
					<%
					if(vid == null)
					{
						%>
						<a class ="btn btn-primary" href="javascript:alert('로그인이 필요합니다.')">글쓰기</a>
						
						<%
					}else
					{
						%>
						<a class ="btn btn-primary" href="../board/Writer.jsp">글쓰기</a>
						<%				
					}
					%>
			</div>
   		</div>			
		</article>
	</section>
</body>
</html>
<%@ include file="DBClose.jsp" %>