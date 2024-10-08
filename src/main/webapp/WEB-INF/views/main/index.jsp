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
		#community {display: flex; position:relative; justify-content: space-between; align-items: center;}
		.item {border: 1px solid black; text-align: center; width: 30%; height: 80%;
				padding: 20px; margin: 50px; border-radius: 10px;}
	</style>
</head>
<body>

	<section>
		<div id="image"> <img src="../resources/2-4.jpg" class="main-img"> </div>
		<div id="community">
			<div id="notice" class="item">공지사항 
				<div>안녕하세요 PENSON 입니다.</div>
			</div>
			<div id="tour" class="item">여행후기</div>
			<div id="board" class="item">게시판</div> 
		</div>
	</section>

</body>
</html>