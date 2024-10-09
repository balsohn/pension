<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>     
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
		
		.write-container select {
			height: 30px;
			width: 100px;
		}
</style>
</head>
<body>
	<section>
		<div class="non">
		<c:if test="${empty userid}">
		<div>비회원으로 문의</div>
		<form method="post" action="nonMemberView">
			<input type="text" name="inqNumber">
			<input type="submit" value="문의 확인">
		</form>
		</c:if>
		</div>
		<div class="write-container">
		<form method="post" action="writeOk">
		<h2> 문의하기 
			<span> 
				<select name="title">
					<option value="0"> 펜션 예약 </option>
					<option value="1"> 입실 퇴실 </option>
					<option value="2"> 주변 맛집 </option>
					<option value="3"> 웹 사이트 </option>
					<option value="4"> 기타 </option>
				</select>
			</span>	</h2>
			<div> <textarea name="content"></textarea></div>
			<div class="btn"> <input type="submit" value="문의하기"></div>		
		</form>
		</div>
	</section>
</body>
</html>









