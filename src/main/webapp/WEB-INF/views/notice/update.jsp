<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		section { width: 1000px; height: 600px; margin:auto; border: 1px solid black; text-align: center;padding-bottom: 40px;}
		section div {margin-top: 10px;}
		section div input {border: 1px solid green; outline:none;}
		section #txt {width: 400px; height: 40px;}
		section #pwdx {width: 400px; height: 40px;}
		section #sub {width: 406px; height: 44px;}
		section #sub:hover {background:green; color:white;}
		span {font-size: 11px;}
	</style>
	<script>
		window.onload=function() {
			document.uform.state[${ndto.state}].checked=true;
			
		}
	</script>
</head>
<body>
	<section>
		<form method="post" action="updateOk" name="uform">
		<input type="hidden" name="id" value="${ndto.id}">
		<h3>공지사항 수정</h3>
		<div> <input type="text" name="title" placeholder="제 목" value="${ndto.title}"> </div>
		<div> <textarea name="content" plcaeholder="공지사항 내용">${ndto.content}</textarea></div>
		<div>
			<input type="radio" name="state" value="0"> 일반공지
			<input type="radio" name="state" value="1"> 상시공지
			<input type="radio" name="state" value="2"> 필수공지
		</div>
		<div> <input type="submit" value="수정" id="sub"> </div>
		</form>
	</section>
</body>
</html>