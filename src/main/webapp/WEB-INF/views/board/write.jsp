<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		section { width: 1000px; height: 600px; margin:auto; border: 1px solid black; text-align: center;padding-bottom: 40px;}
		section .write-container {width:700px; margin:10px auto; border:1px solid black; text-align:left;}
		section div {margin-top: 10px;}
		section div input {border: 1px solid green; outline:none;}
		section #txt {width: 400px; height: 40px;}
		section #pwdx {width: 400px; height: 40px;}
		section #sub {width: 406px; height: 44px;}
		section #sub:hover {background:green; color:white;}
		span {border:1px solid black; width:100px; display:inline-block; text-align: center;}     
	</style>
</head>
<body>
	<section>
		<form method="post" action="writeOk">
		<h3>게시글 쓰기</h3>
		<div class="write-container">
			<div> <span>작성자</span> ${userid}</div>
			<div> <span>제목</span><input type="text" name="title" placeholder="제 목"> </div>
			<div> <div>내용</div><textarea name="content" placeholder="내 용"></textarea></div>
			<div> <input type="submit" value="글쓰기" id="sub"> </div>
		</div>
		</form>
	</section>
</body>
</html>