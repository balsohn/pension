<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section {margin:auto; width:1000px; text-align:center; border:1px solid black;}
	section .content-container {width:500px; border:1px solid black;}
	section div {display:inline-block; width:78%;}
	section .content {width:20%;}
	.aa {margin-top:20px; font-size: 20px; font-weight: bold;}
	.bb {text-align:left; width:500px;}
	.btn {display: flex; width:400px; margin:auto;}
	#cform {display:none;}
</style>

</head>
<body>
	<section>
		<div class="content-container">
			<div class="content title">제 목</div>
			<div> ${tdto.title}</div>
			<div class="content userid">작성자</div>
			<div>${tdto.userid}</div>
			<div class="content writeday">작성일</div>
			<div>${tdto.writeday}</div>
		</div>
		<div class="aa"> 후기 </div>
		<div class="bb"> ${tdto.content}</div>
		<div>
		<c:forEach var="img" items="${imgs}">
		<img src="../resources/tour/${img}" width="150" height="150">
		</c:forEach>
		</div>
		<c:if test="${userid==tdto.userid}">
		<div class="btn">
			<div><a href="update?id=${tdto.id}">수정</a></div>
			<div><button onclick="del()">삭제</button></div>
		</div>
		</c:if>
	</section>
</body>
</html>

