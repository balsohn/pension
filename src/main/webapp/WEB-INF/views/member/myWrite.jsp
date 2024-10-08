<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section {margin: auto; width:1000px;}
	section table {border:1px solid black; margin: auto; margin:10px auto;  border-spacing: 0px;}
	section td, section tr{border:1px solid black;}
</style>
</head>
<body>
	<section>
		<h3>게시판</h3>
		<div class="board-container">
		
		</div>
		<hr>
		<h3>여행후기</h3>
		<div class="tour-container">
		
		</div>
		<hr>
		<h3>문의 내용</h3>
			<c:forEach var="inqlist" items="${inqlist}">
			<div>
				<div>[${inqlist.title2}] ${inqlist.content2}</div>
			</div>
			<table width="800" align="center">
				<tr>
					<td rowspan="2" width="140" align="center">${inqlist.title2}</td>
					<td height="100" style="padding:5px 10px;">${inqlist.content }</td>
					<td rowspan="2" width="140" align="center">${inqlist.writeday }</td>
				</tr>
				<tr>
					<td style="padding:5px 10px;">${inqlist.answer}</td>
				</tr>
			</table>
			</c:forEach>
		<hr>
	</section>
</body>
</html>