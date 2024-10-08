<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		section {width:600px; margin:30px auto;}
		section .first {display:grid; grid-template-columns:1fr 1fr; margin:10px auto; grid-gap:5px 0;}
		section .second {display:grid; margin:10px auto; grid-gap:10px auto;}
		section .second h2 {margin:20px 0;}
		section .second img {max-width: 100%; height:auto; border-radius: 3px;}
		.img-container {display:flex; flex-wrap: nowrap; justify-content: center; gap: 10px;}
		.img-container .imgs img{width:60px; height:40px; margin-top:17px;}
		.imgs img:hover {transform:scale(1.4); box-shadow: 0 4px 8px rgba(0,0,0,0.2);}
		section .btn {text-align: center; margin: 60px 0;} /* 중앙 정렬 및 상단 여백 */
		section .btn a {
			margin: 0 10px; /* 버튼들 사이 간격 */
			text-decoration: none; /* 링크 밑줄 제거 */
			color: white; /* 텍스트 색상 */
			background-color: black; /* 배경색 */
			padding: 5px 18px; /* 패딩 */
			border-radius: 3px; /* 모서리 둥글게 */
		}
		section .btn a:hover {
			background-color: #0056b3; /* 호버 시 배경색 */
		}
	</style>
	<script>
		function chgImg(n) {
			document.querySelector(".second img").src=n;
		}
	</script>
</head>
<body>
	<section>
		<h2>${rdto.title }</h2>
		<div class="first">
			<div> 최소인원 </div> <div> ${rdto.min} </div>
			<div> 최대인원 </div> <div> ${rdto.max} </div>
			<div> 객실가격 </div> <div> ${rdto.price} </div>
		</div>
		<div class="second">
			<div><h2>객실사진</h2></div>
	        <div><img src="../resources/room/${img[0]}"></div>
	        <div class="img-container">
	            <c:forEach var="img" items="${img}">
	                <div class="imgs"><img src="../resources/room/${img}" onclick="chgImg(this.src)"></div>
	            </c:forEach>
	        </div>
	        <h2>객실설명</h2>
	        <div>${rdto.content }</div>
        </div>
        <c:if test="${userid=='admin'}">
        <div class="btn">
            <a href="../adminRoom/update?id=${rdto.id}">수정</a>
            <a href="../adminRoom/delete?id=${rdto.id}">삭제</a>
        </div>
        </c:if>
    </section>
</body>
</html>
