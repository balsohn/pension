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
</head>
<body>
	<section>
		<form method="post" action="updateOk" name="uform">
		<input type="hidden" name="id" value="${bdto.id}">
		<h3>게시글 수정</h3>
		<div> <input type="text" name="title" placeholder="제 목" value="${bdto.title}"> </div>
		<div> <textarea name="content" placeholder="공지사항 내용">${bdto.content}</textarea></div>
		<div> <input type="submit" value="수정" id="sub"> </div>
		</form>
	</section>
</body>
</html>