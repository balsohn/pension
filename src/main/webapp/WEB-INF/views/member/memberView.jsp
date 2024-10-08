<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		section {width:1000px; margin:auto;}
		section h2,section h4 { text-align: center;}
		section > h4{ margin-bottom: 20px;}
		section .info-container {max-width:500px; margin:auto; }
		section .sel {display: flex; text-align: center; margin:5px 0; }
		section .sel .q {width:200px; }
		section #update {display: none; margin:30px 0px; text-align: center;}
		section #update form #info {width: 200px; height: 25px;}
	</style>
	<script>
		function viewForm(n) {
			if(n==0){
				document.getElementById("info").name="email";
				document.getElementById("info").value="${mdto.email}";
				document.getElementById("form").action="emailEdit";
				document.getElementById("update").style.display="block";
				document.getElementById("update-type").innerText="이메일 변경";
			} else if(n==1) {
				document.getElementById("info").name="phone";
				document.getElementById("info").value="${mdto.phone}";
				document.getElementById("form").action="phoneEdit";
				document.getElementById("update").style.display="block";
				document.getElementById("update-type").innerText="전화번호 변경";
			} else if(n==2) {
				document.getElementById("info").name="oldpwd";
				document.getElementById("info").placeholder="비밀번호 입력";
				document.getElementById("info").value="";
				document.getElementById("form").action="pwdchk";
				document.getElementById("update").style.display="block";
				document.getElementById("update-type").innerText="비밀번호 변경";
			}
		}
		function cancelForm() {
			document.getElementById("update").style.display="none";
		}
	</script>
</head>
<body>
	<section>
		<h2>회원님 정보</h2>
		<h4 onclick="viewForm(2)" align="right">비밀번호 변경</h4>
		<div class="info-container">
			
			<div class="sel">
				<div class="q">아이디</div><div>${mdto.userid }</div>
			</div>
			<div class="sel">
				<div class="q">이름</div><div>${mdto.name }</div>
			</div>
			<div class="sel">
				<div class="q">이메일</div>
				<div>
					<div id="emailOne">${mdto.email } <input type="button" value="수정" onclick="viewForm(0)"></div>
            	</div> 
				</div>
			<div class="sel">
				<div class="q">전화번호</div><div>${mdto.phone } <input type="button" value="수정" onclick="viewForm(1)"></div>
			</div>
			<div id="update">
				<h4 id="update-type"></h4>
				<form method="post" id="form" action="phoneEdit">
	               	<input type="text" id="info" name="email" value="${mdto.phone}">
	               	<input type="submit" value="수정">
	               	<input type="button" value="취소" onclick="cancelForm()">
	           	</form>
			</div>
			</div>
		
	</section>
</body>
</html>