<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ include file="DBOpen.jsp" %>
<%@ include file="PageNav.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
String num = request.getParameter("no");

try
{
	PreparedStatement mStmt;
	ResultSet         rs;	
	
	String sql  = "update board set hit = hit + 1 "; //조회수를 1씩 올려준다.
		   sql += "where no = " + num;
	
	mStmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	int rsint   = mStmt.executeUpdate();
	
    sql  = "select u_no,no,title,content,hit,wdate,originF from board where no = " + num; //조회수를 올리고 데이터를 가져온다.
	mStmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs    = mStmt.executeQuery();
		   
	rs.next();
	
	v_no        = rs.getString("no");        // 게시글 번호
	v_title     = rs.getString("title");     // 게시글 제목
	v_content   = rs.getString("content");   // 게시글 내용
	v_content   = v_content.replace("\n","<br>");
	v_hit       = rs.getString("hit");       // 게시글 조회수 
	v_wdate     = rs.getString("wdate");     // 게시글 작성일
	v_originF   = rs.getString("originF");   // 게시글 첨부파일명
	v_u_no      = rs.getString("u_no");      // 유저 번호
	
	rs.close();    //검색된 결과를 닫는다.
	mStmt.close(); //stmt 를 닫는다.
	
}catch(Exception e)
{
	System.out.println("ERROR:" + e.getMessage());
}

if(v_originF == null || v_originF.equals("null"))
{
	v_originF = "";
}
%>
<!DOCTYPE html>
<html>
<head>
<link href="../style/header.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<meta charset="EUC-KR">
<title>VIEW</title>
<style>
	section
	{
		background-image: linear-gradient(to top, #d5d4d0 0%, #d5d4d0 1%, #eeeeec 31%, #efeeec 75%, #e9e9e7 100%);
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
	function saveFn() 
	{
		$.ajax
		({
			url:"ReplyOk.jsp",
			type:"GET",
			data:$("#rep").serialize(),
			success:function(data)
			{
				var output = "";
				var json = JSON.parse(data);
				for(var i=0; i<json.length; i++)
				{	
					output += "<div id='replydiv_"+json[0]["r_no"]+"'>";
					output += "<input type='hidden' id='hiddenTx_"+json[0]["r_no"]+"' value='"+json[0]["r_no"]+"'>";
					output += "<span style ='display:inline-block; width:200px; text-align:center;'>"+json[i]["nick"]+"</span>";
					output += "<span style ='display:inline-block; width:500px;' id='Rcnt_"+json[0]["r_no"]+"'>"+json[i]["r_content"]+"</span>";
					output += "<span style ='display:inline-block; width:200px;'><small>"+json[i]["r_date"]+"</small></span>";
					output += "<span style ='display:inline-block; width:50px;' id='btnSp_"+json[0]["r_no"]+"'><a href='javascript:updateFn("+json[0]["r_no"]+")'>UPDATE</a></span>&nbsp;&nbsp;&nbsp;&nbsp;";
					output += "<span style ='display:inline-block; width:50px;' id='btnSp_"+json[0]["r_no"]+"'><a href='javascript:deleteFn("+json[0]["r_no"]+")'>DELETE</a></span>";
					output += "</div>";
				}
				$("#replyList").append(output);
			}
		});
	}
	
	function updateFn(r_no)
	{	
		var content = $("#Rcnt_"+r_no).text();
		var str  = "";
			str += "<span id='contentTx_"+r_no+"'><input type='text' id='textTx_"+r_no+"' value='"+content+"'></span>"; //수정시 input에 원래 내용 뜨게
			
		$("#Rcnt_"+r_no).html(str);
		var str2  = "";
			str2 += "<a href='javascript:saveFn2("+r_no+")'>SAVE</a>";
		$("#btnSp_"+r_no).html(str2);
	}
	
	function saveFn2(r_no)
	{
		var contVal = $("#textTx_"+r_no).val();
		var hiddVal = $("#hiddenTx_"+r_no).val();
		var uNo = $("#uNo").val();
		var data = 
		{
				content:contVal,
				r_no:hiddVal,
				uNo:uNo
		}
		$.ajax
		({
			url:"ReplyUpdate.jsp",
			type:"GET",
			data:$.param(data),
			success:function(data)
			{
				var json = JSON.parse(data);
				$("#contentTx_"+r_no).html(json[0]["r_content"]);
				var str  = "<a href='javascript:updateFn("+json[0]["r_no"]+")'>UPDATE</a>";
				$("#btnSp_"+r_no).html(str);
			}
		});
	}
	
	function deleteFn(r_no)
	{
		var hiddVal = $("#hiddenTx_"+r_no).val();
	
		$.ajax
		({
			url:"ReplyDelete.jsp",
			type:"GET",
			data:"r_no=" + hiddVal,
			success:function(data)
			{
				$("#replydiv_"+r_no).remove();
			}
		});
	}
</script>
<header>
	<img src="../images/LOGO.png" id="mainimg" width="300px" onclick="location.href='../main/Main.jsp'" alt="Mainimage">
	<div id="lojo">
			<%
			String vid   = (String)session.getAttribute("ID");     // 이름이 ID인 세션값을 받아옴 
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
	<article>
		<div class="container" role="main">
				<h3 class="mt-3" style="margin-bottom:20px;"><%= v_title %></h3>
					<span class="board_date" style="position:absolute; right:350px"><b>조회수</b> <%= v_hit %></span>
				<hr/>
			<div class="bg-white rounded shadow-sm">
				<div class="board_title"><h4></h4></div>
				<div class="board_info_box">
					<span class="board_author">&nbsp;&nbsp;&nbsp;</span><span class="board_date" style="position:absolute; right:350px"><%= v_wdate %></span><p/>
				</div>
				<div class="board_content" style="height:50vh; margin-top:80px"><font size="4"><%= v_content %></font></div><P/>
				<div class="board_content"><b>첨부파일 다운로드</b>&nbsp;&nbsp;&nbsp;
				<%
				if(v_originF.equals(""))
				{
					%>등록된 첨부파일이 없습니다.<%
				}else
				{
					%><a href="Download.jsp?file=<%= v_originF %>"><%= v_originF %></a><%
				}
				%></div>
			</div>
			<div style="margin-top : 20px" align="right">
					<%
					//out.print(v_u_no+vu_no);
					if(v_u_no.equals(vu_no))
					{
					%>
						<button type="button" class="btn btn-sm btn-primary" id="btnUpdate" onclick="location.href ='Modify.jsp?no=<%= v_no %>&page=<%= curpg %>&<%= adParam %>'">수정</button>
						<button type="button" class="btn btn-sm btn-primary" id="btnDelete" onclick="location.href ='Delete.jsp?no=<%= v_no %>&page=<%= curpg %>&<%= adParam %>'">삭제</button>
					<%
					}else
					{
						%>
				
						<%
					}
					%>
				<button type="button" class="btn btn-sm btn-primary" id="btnList"   onclick="location.href ='Talkboard.jsp?no=<%= v_no %>&page=<%= curpg %>&<%= adParam %>'">목록</button>
			</div>
			<form id="rep" name="rep">
				<input type="hidden" value="<%= v_no %>" name="no">
				<input type="hidden" value="<%= v_u_no %>" name="uNo" id="uNo">
				<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">
					<div class="row">
						<div class="col-sm-10">
							<textarea id="content" name="rep1" class="form-control" rows="3" placeholder="로그인 후 댓글을 입력해 주세요"></textarea>
						</div>
						<div class="col-sm-2">
							<button type="button" class="btn btn-sm btn-primary" id="btnReplySave" style="width: 100%; margin-top: 10px" onclick="saveFn()">SAVE</button>
						</div>
					</div>
				</div>
			</form>
			<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px" style="height:100px">
				<h6 class="border-bottom pb-2 mb-0"><b>댓글 목록</b></h6>
				<form id="reply" name="reply">
					<div id="replyList">
						<%
							ResultSet rs2 = null;
							PreparedStatement mStmt2;
							String sql2  = "select u_no,r_no,r_content,r_date,(select nick from users where u_no = reply.u_no) as nick from reply where no = " + num; // 댓글을 가져오기 위한 부분
						   	mStmt2  = conn.prepareStatement(sql2,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
						   	rs2     = mStmt2.executeQuery();
							while(rs2.next())
							{
								String Rno      = rs2.getString("r_no");
								String Rcontent = rs2.getString("r_content");
								String Rdate    = rs2.getString("r_date");
								String RNick    = rs2.getString("nick");
								String Uno      = rs2.getString("u_no");
								
						%>
							<div>
								<input type="hidden" id="r_no" name="r_no" value="<%= Rno %>">
								<span style ='display:inline-block; width:200px; text-align:center;'><%= RNick %></span>
								<span style ='display:inline-block; width:500px;' id='Rcnt_"+json[0]["r_no"]+"'><%= Rcontent %></span>
								<span style ='display:inline-block; width:200px;'><small><%= Rdate %></small></span>
								<%
									if(Uno.equals(vu_no))
									{
									%>
										<a href='javascript:updateFn("+json[0]["r_no"]+")'>UPDATE</a></span>&nbsp;&nbsp;&nbsp;&nbsp;
										<a href='javascript:deleteFn("+json[0]["r_no"]+")'>DELETE</a></span>
									<%
									}else
									{
										%>
								
										<%
									}
									%>
							</div>
						<%
							}
						rs2.close();
						mStmt2.close();
						%>
					</div>
				</form>
			</div>
		</div>
	</article>
</body>
</html>
<%@ include file="DBClose.jsp" %>