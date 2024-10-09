<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		section {width: 1000px; height: 600px; margin: auto;}
		section #image {width: 1000px; margin: auto; text-align: center;}
		section #community {width: 1000px; height: 300px; margin: auto;}
		.main-img {width:1000px;}
		#community {
			display: flex;
			justify-content: space-between;
			align-items: flex-start;
			gap: 20px; /* 아이템 사이에 간격 추가 */
			width: 100%;
			margin: 0 auto;
			flex-wrap: wrap; /* 아이템이 너무 많을 경우 다음 줄로 내려가도록 */
		}
		.item {
			flex: 1;
			max-width: 30%;
			height: 80%;
			border: 1px solid #ccc;
			border-radius: 10px;
			padding: 20px;
			margin: 10px;
			background-color: #f9f9f9;
			transition: transform 0.3s ease, box-shadow 0.3s ease;
			box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
			display: flex;
			flex-direction: column;
			justify-content: space-between;
			overflow: hidden;
		}
		
		.item:hover {
			overflow:auto;
		}
		.item a {
			text-decoration: none;
			color: #333;
			font-weight: bold;
			transition: color 0.3s ease;
		}
		.item:hover {
			transform: translateY(-10px);
			box-shadow: 0 10px 15px rgba(0, 0, 0, 0.15);
		}
		.item a:hover {
			color: #d33;
		}

	</style>
</head>
<body>

	<section>
		<div id="image"> <img src="../resources/2-4.jpg" class="main-img"> </div>
		<div id="community">
			<div id="notice" class="item">공지사항 
				<div style="text-align: left;">
				<c:forEach var="ndto" items="${notice}">
				<div><a href="../notice/content?id=${ndto.id}">${ndto.title}</a></div>
				</c:forEach>
				</div>
			</div>
			<div id="tour" class="item">여행후기
				<div style="text-align: left;">
				<c:forEach var="tdto" items="${tour}">
				<div><a href="../tour/content?id=${tdto.id}">${tdto.title}</a></div>
				</c:forEach>
				</div>
			</div>
			<div id="board" class="item">게시판
				<div style="text-align: left;">
				<c:forEach var="bdto" items="${board}">
				<div><a href="../board/content?id=${bdto.id}">${bdto.title}</a></div>
				</c:forEach>
				</div>
			</div> 
		</div>
	</section>

</body>
</html>