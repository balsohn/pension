<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		section {width: 1000px; height: 600px; margin: auto; text-align: center;}
		section div {margin-top: 10px;}
		section div input {border: 1px solid green; outline:none;}
		section #txt {width: 400px; height: 40px;}
		section #pwdx {width: 400px; height: 40px;}
		section #sub {width: 406px; height: 44px;}
		section #sub:hover {background:green; color:white;}
		span {font-size: 11px;}
	</style>
	<script>
		var uPass=0;
		var pPass=0;
	
	
		function dupChk(userid) {
			
			if(userid.trim().length>=4) {
				var chk=new XMLHttpRequest();
				chk.onload=function() {
					var result=chk.responseText;
					if(result==1) {
						document.getElementById("useridChk").innerText="중복된 아이디입니다.";
						document.getElementById("useridChk").style.color="red";
						uPass=0;
					}
					else {
						document.getElementById("useridChk").innerText="";
						document.getElementById("useridChk").style.color="red";
						uPass=1;
					}
					
				}
				chk.open("get","useridChk?userid="+userid);
				chk.send();
			}
			else {
				document.getElementById("useridChk").innerText="아이디 길이는 4자 이상입니다.";
				document.getElementById("useridChk").style.color="red";
				uPass=0;
			}
		}
		
		function pwdChk() {
			var pwd1=document.mform.pwd.value;
			var pwd2=document.mform.pwd2.value;
			
			if(pwd1.length>=6) {
				document.getElementById("pwd1Chk").innerText="";
				if(pwd1==pwd2) {
					document.getElementById("pwd2Chk").innerText="사용가능한 비밀번호 입니다.";
					document.getElementById("pwd2Chk").style.color="blue";
					pPass=1;
				}
				else {
					if(pwd2==""){
						document.getElementById("pwd2Chk").innerText="";
						document.getElementById("pwd2Chk").style.color="red";
						pPass=0;
					} else {
						document.getElementById("pwd2Chk").innerText="비밀번호가 일치하지 않습니다.";
						document.getElementById("pwd2Chk").style.color="red";
						pPass=0;
						
					}
				}
			
			}
			else {
				document.getElementById("pwd1Chk").innerText="비밀번호는 6글자 이상입니다.";
				document.getElementById("pwd1Chk").style.color="red";
				pPass=0;
			}
		}
		
		function signUp() {
			if(uPass==1 && pPass==1) {
				return true;
			} else {
				location.href="../member/member?err=1";
				return false;
			}
		}
	</script>
</head>
<body>
	<section>
		<form method="post" action="memberOk" name="mform" onsubmit="return signUp()">
			<h3>회원 가입</h3>
			<div id="userid"> 
				<input type="text" name="userid" oninput="dupChk(this.value)" placeholder="아이디" id="txt"> 
				<br><span id="useridChk"></span>
			</div>
			<div id="name"> <input type="text" name="name" placeholder="이름" id="txt"> </div>
			<div id="pwd1">
				<input type="password" name="pwd" oninput="pwdChk()" placeholder="비밀번호" id="pwdx">
				<br> <span id="pwd1Chk"></span> 
			</div>
			<div id="pwd2"> 
				<input type="password" name="pwd2" oninput="pwdChk()" placeholder="비밀번호 확인" id="pwdx">
				<br> <span id="pwd2Chk"></span> 
			</div>
			<div id="email"> <input type="text" name="email" placeholder="이메일" id="txt"> </div>
			<div id="phone"> <input type="text" name="phone" placeholder="연락처" id="txt"> </div>
			<div id="submit"> <input type="submit" value="회원가입" id="sub"> </div>
		</form>
		<c:if test="${param.err==1}"><span style="color:red;">정보를 확인해주세요.</span></c:if>
	</section>
</body>
</html>