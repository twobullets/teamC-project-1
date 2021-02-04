<%@ page language="java" contentType="text/html;"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
	<head>
		<title>JOIN</title>
		<link rel="stylesheet" type="text/css" href="../style/join.css"/>
	</head>
	<script src="../js/jquery-3.5.1.min.js"></script>
	<script>
		var fa = true; // 하나만 선언해서 그럼 맨 마지막에 true 값으로 바뀌어서 그럼
		var fb = true;
		var fc = true;
		var fd = true;
		var fd = true;
		 function check_pw()
		{
			 //var fa = true; // 전역변수 선언 여기에 하는게 아닌거 같음 
			var pw = document.getElementById('pw').value;
            if(document.getElementById('pw').value.length < 6 || document.getElementById('pw').value.length> 16)
            {
            	document.getElementById('check1').innerHTML='비밀번호는 6글자 이상, 16글자 이하만 이용 가능합니다.';
            	document.getElementById('check1').style.color ='red';
            	document.getElementById('check1').style.display ='inline';
            	fa = false;
           		
            }
            else
            {
            	document.getElementById('check1').innerHTML='비밀번호는 6글자 이상, 16글자 이하만 이용 가능합니다.';
            	document.getElementById('check1').style.display ='none';
            	fa= true;
            }
            
            
			var pw = document.getElementById('pw').value;
			var sc = ["!","@","#","$","%"];
			var check_sc= 0;
			
                 
               for(var i=0;i<sc.length;i++){
                if(pw.indexOf(sc[i]) != -1)
                {
                 check_sc = 1;
                }
            }
            if(check_sc == 0 )
            {
            	document.getElementById('check3').innerHTML='!,@,#,$,% 의 특수문자가 들어가 있지 않습니다.';
            	document.getElementById('check3').style.color ='red';
            	document.getElementById('check3').style.display ='inline';
            	fb = false;
            	
            }
            else
            {
            	document.getElementById('check3').innerHTML='';
            	document.getElementById('check3').style.display ='none';
            	fb= true;
            }
                         
            	if(document.getElementById('pw').value==document.getElementById('pw2').value)
                {
                    document.getElementById('check2').innerHTML='비밀번호가 일치합니다.';
                    document.getElementById('check2').style.color='blue';
                    fc= true;
                }
            	 else
            	 {
                	 document.getElementById('check2').innerHTML='비밀번호가 일치하지 않습니다.';
                     document.getElementById('check2').style.color='red';
                    fc= false;
            	 }
			}

	function registerCheckFunction() // 아이디 닉네임 사용 
	{

		var id = $('#id').val();
		$.ajax({
			type:'post',
			url:'Joinidcheck.jsp',
			data:{"id":id}, // id란 변수에 id 데이터값을 넣어서 보냄 
			success:function(result) // 성공적으로 수행되었으면 result로 값변환 result 정의
			{
				
				if(result.trim()=="1") // 성공하면 1 실패하면 0을 받아서 실행
				{						
					$("#checkMessage").text("사용할수 있는 아이디 입니다.");
					$('#checkMessage').css("color","blue");
					fd= true;
				}else
				{
					
					$("#checkMessage").text("사용할수 없는 아이디 입니다");
					$('#checkMessage').css("color","red");
					 fd= false;
				}
			}
		});
	}
		function registerCheckFunction2()
		{
			
		var nick = $('#nick').val();
		$.ajax({
			type:'post',
			url:'Joinnickcheck.jsp',
			data:{"nick":nick}, 
			success:function(result) // 성공적으로 수행되었으면 result로 값변환 result 정의
			{
				
				if(result.trim()=="1") // 성공하면 1 실패하면 0을 받아서 실행
				{						
					$("#checkMessage2").text("사용할수 있는 닉네임 입니다.");
					$('#checkMessage2').css("color","blue");
					fe= true;
					
				}else
				{
					$("#checkMessage2").text("사용할수 없는 닉네임 입니다");
					$('#checkMessage2').css("color","red");
					 fe= false;
				}
			}
		});
	
	}
 	function Dosubmit()
	{	
 		
 		var pw = document.getElementById('pw').value;
		var pw2 = document.getElementById('pw2').value;
		var id = document.getElementById('id').value;
		var u_name = document.getElementById('u_name').value;
		var nick = document.getElementById('nick').value;
		if( u_name == "" || nick == "" || id == "" || pw == "" || pw2 == "" )
			{
				alert('입력하지 않은 사항이 있습니다');		
					
			}
		else
		{
			
			if(fa==true&&fb==true&&fc==true&&fd==true&&fe==true)
			{
			document.join.submit();
			// session.setAttribute("id",id);
			// session.setAttribute("pw",pw);
			// session.setAttribute("nick",nick);
			// session.setAttribute("u_name",u_name);
			}							
			else
			{				
			alert('입력이 올바르지 않습니다.'); 		
			}
		}		
	}
	</script>
	<body>
		<header>
			<img src="../images/LOGO.png" id="mainimg" width="300px" onclick="location.href='../main/Main.jsp'" alt="Mainimage">
			<div id="lojo">
				<a href="Login.jsp">로그인</a><a href="Join.jsp">회원가입</a>
			</div>
		</header>
		<nav id="navi">
			<div id="menu">
				<ul id="main-menu">
					<li><a href="../board/Talkboard.jsp">공감톡</a></li>
					<li><a href="../information/Information.jsp">금연정보</a></li>
					<li>
					<%
					String vid = (String)session.getAttribute("ID"); // 이름이 ID인 세션값을 받아옴 
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
				<div class="fnt">
					<h2>회원가입</h2>
				</div>
				<form method="post" action="Joinok.jsp" id="join" name="join" >
					<fieldset>
						<input type="text" id="u_name" name="u_name" class="c1" placeholder="  이름" style="ime-mode:active;"><br>							
						<div id = check4 name="check4"></div>
						<input type="text" id="nick" name="nick" class="c1" oninput="registerCheckFunction2();" placeholder="  닉네임"><br>
						<span id="checkMessage2" ></span>						
						<input type="text" id="id" name="id" oninput="registerCheckFunction();" placeholder="  아이디 " style="ime-mode:disabled;"><br>
						<span id="checkMessage" ></span>					
						<input type="password" id="pw" name="pw" class="c1" placeholder="  비밀번호" 
						oninput="javascript:check_pw();"  style="ime-mode:disabled;"><br>	
						<div id= "check1" name= "check1"></div><br>
						<div id="check3" name="check3" ></div>
						<input type="password" id="pw2" name="pw2" class="c1"  placeholder="  비밀번호 확인" 
						style="ime-mode:disabled;" oninput="javascript:check_pw();">
						<span id="check2" name="check2"></span>
						
					</fieldset>
					<div class="btn">
						<button type="button" class="joinbtn" id="subbit" onclick="javascript:Dosubmit();">가입하기</button>
						<button class="joinbtn" onclick="location.href='../main/Main.jsp';">돌아가기</button>
					</div>
				</form>
			</article>
		</section>
	</body>
</html>