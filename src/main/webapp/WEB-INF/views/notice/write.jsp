<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		section { width: 1000px; height: 600px; margin:auto;text-align: center;padding-bottom: 40px;}
		section form { width:65%; margin: auto; position: relative;border-radius: 10px; padding:20px;}
		section h2 {margin:20px;}
		section input[type=text] {height: 30px; width:100%; border-radius: 8px; margin-bottom: 10px;}
		section textarea{height: 30px; width:100%; resize: vertical; min-height: 300px; border-radius: 8px;}
		input::placeholder, textarea::placeholder { font-size: 14px; color: #999; padding-left:10px;}
		textarea::placeholder {padding-top:10px; }
		section input[type=radio] {margin:20px 0;}
		section input[type=submit] {width:150px; height: 30px; border:none; background:green; color:white; font-family: 'GmarketSansMedium'; cursor: pointer;}
		section input[type=submit]:hover {background: #006400;}
	</style>
</head>
<body>
	<section>
		<form method="post" action="writeOk">
		<h2>공지사항 글쓰기</h2>
		<div> <input type="text" name="title" placeholder="제 목"> </div>
		<div> <textarea name="content" placeholder="공지사항 내용"></textarea></div>
		<div>
			<label><input type="radio" name="state" value="0"> 일반공지</label>
			<label><input type="radio" name="state" value="1"> 상시공지</label>
			<label><input type="radio" name="state" value="2"> 필수공지</label>
		</div>
		<div> <input type="submit" value="공지사항 글쓰기" id="sub"> </div>
		</form>
	</section>
</body>
</html>