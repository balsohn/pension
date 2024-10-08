<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section .inquiry-container {width:50%; margin:auto; border:1px solid black;}
	section h2 {margin-left: 30px;}
	section .inquiry-container form > div {text-align:center;}
	section select {width:90%; height: 30px; }
	section textarea {width: 90%; height: 200px;}
	section input {width: 70%; height:30px; text-align: center;}
	section .non {width :300px; margin:auto;}
	
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
		<div class="inquiry-container">
		<form method="post" action="writeOk">
		<h2> 문의하기 </h2>
			<div> 
				<select name="title">
					<option value="0"> 펜션 예약 </option>
					<option value="1"> 입실 퇴실 </option>
					<option value="2"> 주변 맛집 </option>
					<option value="3"> 웹 사이트 </option>
					<option value="4"> 기타 </option>
				</select>
			</div>	
			<div> <textarea name="content"></textarea></div>
			<div> <input type="submit" value="문의하기"></div>		
		</form>
		</div>
	</section>
</body>
</html>









