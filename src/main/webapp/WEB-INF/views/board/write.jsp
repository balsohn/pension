<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		section {
			width: 700px;
			margin: auto;
		}   
		
		span {
			width:80px;
			display: inline-block;
		}
		
		.write-container div {
			margin-top: 10px;
		}
		
		.write-container input[type="text"] {
			height: 30px;
			width: 100%;
		}
		
		textarea {
			width: 100%;
			height: 300px;
			resize: vertical;
		}
		
		.btn {
			text-align: center;
		}
		.write-container input[type="submit"] {
			text-align: center;
			width: 100px;
			height: 30px;
			border: none;
			border-radius: 5px;
			background: black;
			color: white;
			margin-top:10px;
		}
		
		.write-container input[type="submit"]:hover {
			background: #ccc;
		}
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
			<div class="btn"> <input type="submit" value="글쓰기" id="sub"> </div>
		</div>
		</form>
	</section>
</body>
</html>