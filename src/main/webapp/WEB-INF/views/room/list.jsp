<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section { width:1000px; height: auto; display:grid; grid-template-columns:1fr 1fr 1fr; gap:20px; margin:auto;}
	section .room-container {margin: 10px; border: 1px solid red; margin: 20px auto;width: 300px; height: 500px;}
	section .room-container .title{text-align: center; margin: 20px;}
	section .room-container .src{border:1px solid black; width:80%; height: 60%; margin: auto;}
	section .room-container .info{text-align: center; margin: 20px;}
	section .room-container .room{text-align: center; margin: 20px;}
</style>
</head>
<body>
	<section>
		<c:forEach var="rlist" items="${list}">
		<div class="room-container">
			<div class="title"> ${rlist.title } </div>
			<div class="src"> 방사진 </div>
			<div class="info"> ${rlist.min}명~${rlist.max}명 / ${rlist.price }원 </div>
			<div class="room"><a href="">방 상세보기</a></div>
		</div>
		</c:forEach>
	</section>

</body>
</html>