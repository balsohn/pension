<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function winClose() {
		close();
	}
	
	function moveLogin() {
		opener.location="../member/login";
		close();
	}
	
</script>
</head>
<body>
	<div> 당신의 아이디 : ${userid}</div>
	<div>
		<input type="button" onclick="winClose()" value="창닫기">
		<input type="button" onclick="moveLogin()" value="로그인으로 이동">
		<input type="button" onclick="" value="비밀번호 찾기">
	</div>
</body>
</html>