<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8"); 
	String ys=request.getParameter("sel_year");
	String ms=request.getParameter("sel_month");
	String ds=request.getParameter("day_span");
%>
<!DOCTYPE html>
<html>
<head>
<link href="../style/header.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-3.5.1.min.js"></script>
<meta charset="EUC-KR">
<title>MYPAGE</title>
<script>

var date = new Date();
$(document).ready(function(){
	setYear();
	jf_setMonth();
	
});
	function checkit()
	{
		var output="";
		output +="<div class='t1'>";
		output +="<div>나의 금연 시작일은</div>"
		output +="<div id='thisis'></div>"
		output +="<span>현재</span><span id='Cal'></span><span>일째금연성공하셨습니다!</span>";
		output +="</div><br>";
		output +="<div class='t1'>";
		output +="<div>금연으로 현재까지</div>"		
		output +="<span id='price'></span><span>원 절약하셨습니다</span>";
		output +="</div>";
		$("#dday1").html(output);

	
		var sel_year = document.getElementById("sel_year");
		
		var sel_month = document.getElementById("sel_month");
		var day_span = document.getElementById("day_span");
		var fulldate = sel_year.value+"-"+sel_month.value+"-"+day_span.value;
		
		
		var nosmoke = new Date(fulldate);
		var today = new Date();
		var day = Math.ceil((today.getTime()-nosmoke.getTime())/1000/60/60/24);
			
		if(day<0){
			alert("선택다시해라");
			//텍스트 내용 제거해주는 영역
			$("#tbody").html("");
			$
			return false;
			
		}else if(day<100){
			$(".here0").html("<img src='../images/img.png' id='im8' class='img'>");			
		}else if(day<200){			
			$(".here0").html("");
			$(".here1").html("<img src='../images/img.png' id='im8' class='img'>");
		}else if(day<300){	
			$(".here0").html("");
			$(".here1").html("");
			$(".here2").html("<img src='../images/img.png' id='im8' class='img'>");
		}else if(day<400){
			$(".here0").html("");
			$(".here1").html("");
			$(".here2").html("");
			$(".here3").html("<img src='../images/img.png' id='im8' class='img'>");
		}else if(day<500){
			$(".here0").html("");
			$(".here1").html("");
			$(".here2").html("");
			$(".here3").html("");
			$(".here4").html("<img src='../images/img.png' id='im8' class='img'>");
		}else if(day<600){
			$(".here0").html("");
			$(".here1").html("");
			$(".here2").html("");
			$(".here3").html("");
			$(".here4").html("");
			$(".here5").html("<img src='../images/img.png' id='im8' class='img'>");
		}else if(day<700){
			$(".here0").html("");
			$(".here1").html("");
			$(".here2").html("");
			$(".here3").html("");
			$(".here4").html("");
			$(".here5").html("");
			$(".here6").html("<img src='../images/img.png' id='im8' class='img'>");
		};
			$("#thisis").html(sel_year.value+"년"+sel_month.value+"월"+day_span.value+"일입니다.");
			$("#Cal").html(day);
		
			
			var smoke1 = document.getElementById("smoke1").value;
			var smoke2 = document.getElementById("smoke2").value;
			
			var newsmoke=$("#you1 option:selected").val();

			var smokePc1 = Number(smoke1)*newsmoke;
			var smokePc2 = Number(smoke2)*(newsmoke/20);
			
			var totalPc = (smokePc1+smokePc2)*day;
			$("#price").html(totalPc);
		}
//년도 세팅
function setYear(){
	
	var year = date.getFullYear();
	var year_select = "";
	
	year_select += ' <select id="sel_year" name="sel_year" style="width:90px; height:22px;"> ';
	for(var i=1990; i<(year+1) ; i++){
		year_select += " <option value='"+i+"' ";		
		if( i == 2020){
			year_select += " selected ";
		}
		year_select += " >"+i+"년 </option> ";
	}
	year_select += "</select>";
	$("#year_span").html(year_select);
}
function jf_setMonth(){
	
	var monthTemp = "";
	var month_select = "";
	
	month_select += ' <select id="sel_month" name="sel_month" style="width:90px; height:22px;"> ';
	for(var i=1; i<13 ; i++){
		
		if(i < 10){
			monthTemp = "0"+i;
		}else{
			monthTemp = i;
		}
		
		month_select += " <option value='"+monthTemp+"' ";
		
		if(i == 11){
			month_select += " selected ";
		}
		month_select +=" >"+monthTemp+"월 </option> ";
	}
	month_select += "</select>";
	
	$("#month_span").html(month_select);
}

</script>
<style>
	input{outline:none;}
	.table01
	{
		margin-top: 50px;
		width: 1000px;
		height : 500px;
		background-color: white;
	}
	td img
	{
		width: 100px;
		height: 100px;
	}
	.title
	{
		font-size: 2.5vh;
	}
	.note
	{
		font-size: 1.0vh;
	}
	.t1,.t2,.t3,.t4,.t5,.t6
	{
		font-size: 2.5vh;
	}
	.tr2 td
	{
		padding-top: 5px;
	}
	.img
	{
		width: 30px;
		height: 20px;
		padding-left: 50px;
	}
	.t0
	{
		border-top: none;
		border-bottom:none;
	}
	
	#dday1{font-size: 2.5vh;}
	.btn{ width:100px; height:35px;}
	table{margin:auto; padding:7px;}
</style>
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
				<li><a href="../board/Talkboard.jsp">공감톡</a></li>
				<li><a href="../information/Information.jsp">금연정보</a></li>
				<li><a href="Mypage.jsp">마이페이지</a></li>
			</ul>
		</div>
	</nav>
	<section>
		<article>
		<form name="frm" id="frm" method="get" action="Mypage.jsp" >
			<table border="2" class="table01 table table-hover">
				<thead>
					<tr>
						<td colspan="7" align="center" class="title"class="table table-hover">현재티어</td>
					</tr>
					<tr>
						<td class="t0 here0"></td>  <!-- 화살표 넣는 공간 // 수정 해야함 -->
						<td class="t0 here1"></td>
						<td class="t0 here2"></td>
						<td class="t0 here3"></td>
						<td class="t0 here4"></td>
						<td class="t0 here5"></td>
						<td class="t0 here6"></td>
					</tr>
					<tr align="center" class="tr2" id="power">	<!--티어 이미지 넣은 곳-->
						<td width="14%" class="img_t0"><img src="../images/1.png"id="im1"></td>
						<td width="14%" class="img_t1"><img src="../images/2.png"id="im2"></td>
						<td width="14%" class="img_t2"><img src="../images/3.png"id="im3"></td>
						<td width="14%" class="img_t3"><img src="../images/4.png"id="im4"></td>
						<td width="14%" class="img_t4"><img src="../images/5.png"id="im5"></td>
						<td width="14%" class="img_t5"><img src="../images/6.png"id="im6"></td>
						<td width="14%" class="img_t6"><img src="../images/7.png"id="im7"></td>
					</tr>
					
					<tr>
						<td colspan="7" align="center" class="title">금연시작일 지정</td>
					</tr>
					<tr id="sap1"><!-- 수정할 부분 -->
						<td colspan="1" align="center"><img src="../images/time.png"></td>
						<td colspan="3" class="table table-hover">
						<div class="clock">
			                	<div class="t5">나의 금연 시작일 : </div> <span id="year_span" name="year_span" >
			                	</span><span id="month_span" name="month_span"></span>
								<select name="day_span" id="day_span" class="selectpicker" style="width:90px; height:22px;">
									<option value="1">1일</option>
									<option value="2">2일</option>
									<option value="3">3일</option>
									<option value="4">4일</option>
									<option value="5">5일</option>
									<option value="6">6일</option>
									<option value="7">7일</option>
								</select>
						</div>
						</td>
						<td colspan="3" rowspan="2"id="dday1">흡연일을 설정해주세요</td>	
					</tr>				
					<tr id="sap2">
						<td colspan="1" align="center"><img src="../images/pig.png"></td>
						<td colspan="3" class="table table-hover">
						<div class="t5">니꺼 담배 뭔지 선택해라:
							<select id="you1" class="selectpicker"style="width:90px; height:22px;">
								<option value="4000" >4000</option>
								<option value="4500" selected>4500</option>
								<option value="5000" >5000</option>
							</select>
						</div>
						<div class="t5">나의 흡연량 :
			                <span>
								 <select  title="나의 흡연량(갑)" name="smoke1" id="smoke1"   class="selectpicker" style="width:90px; height:22px;">
					 				<option value="0" selected>0갑 </option>
					 				<option value="1" >1갑 </option>
					 				<option value="2" >2갑 </option>
					 				<option value="3" >3갑 </option>
					 				<option value="4" >4갑 </option>
					 				<option value="5" >5갑 </option>
	                            </select>
							</span>
							<span>
								 <select title="나의 흡연량(개비)" name="smoke2" id="smoke2" title="나의 하루 흡연량(개비)"style="height:22px;">
					 				<option value="0" >0개비 </option>
					 				<option value="1" >1개비 </option>
					 				<option value="2" >2개비 </option>
					 				<option value="3" >3개비 </option>
					 				<option value="4" >4개비 </option>
					 				<option value="5" >5개비 </option>
					 				<option value="6" >6개비 </option>
					 				<option value="7" >7개비 </option>
					 				<option value="8" >8개비 </option>
					 				<option value="9" >9개비 </option>
					 				<option value="10" selected>10개비 </option>
					 				<option value="11" >11개비 </option>
					 				<option value="12" >12개비 </option>
					 				<option value="13" >13개비 </option>
					 				<option value="14" >14개비 </option>
					 				<option value="15" >15개비 </option>
					 				<option value="16" >16개비 </option>
					 				<option value="17" >17개비 </option>
					 				<option value="18" >18개비 </option>
					 				<option value="19" >19개비 </option>
	                            </select>
							</span>
						</div>
						</td>
					</tr>
				</thead>
				<tbody id="tbody">
		
				</tbody>
			</table>
			<table id="btn_">
			<tfoot>
				<tr align="center">
					<td  class="note">
						<input class="btn" type="button" value="확인" onclick="checkit()">
						<input class="btn" type="button" value="취소"> 
					</td>
				</tr>
			</tfoot>
			</table>
			</form>
		</article>
	</section>
</body>
</html>