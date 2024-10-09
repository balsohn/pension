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
	section table { margin: auto; margin:10px auto;  border-spacing: 0px;}
	#inquiry td {
		border: 1px solid black;
	}
</style>
</head>
<body>
	<section>
		<h3>게시판</h3>
		<div class="board-container">
		<table width="800" align="center">
		<tr align="center">
			<td width="400px"> 제 목</td>
			<td> 작성자 </td>
			<td> 조회수 </td>
			<td> 작성일 </td>			
		</tr>
		<c:forEach var="blist" items="${blist}">
		<tr align="center">
			<c:if test="${userid!=blist.userid}">
			<td align="left"><a href="../board/readnum?id=${blist.id}">${blist.title}</a></td>
			</c:if>
			<c:if test="${userid==blist.userid}">
			<td align="left"><a href="../board/content?id=${blist.id}">${blist.title}</a></td>
			</c:if>
			<td> ${blist.userid } </td>
			<td> ${blist.readnum } </td>
			<td> ${blist.writeday } </td>			
		</tr>
		</c:forEach>
		<c:if test="${!empty userid}">
		<tr>
			<td colspan="4" align="right"><a href="../board/write" id="write">글쓰기</a></td>
		</tr>
		</c:if>
		</table>
		</div>
		<hr>
		<h3>여행후기</h3>
		<div class="tour-container">
		<table width="800" align="center">
		<tr align="center">
			<td width="400px"> 제 목</td>
			<td> 작성자 </td>
			<td> 조회수 </td>
			<td> 작성일 </td>			
		</tr>
		<c:forEach var="tlist" items="${tlist}">
		<tr align="center">
			<c:if test="${userid!=tlist.userid}">
			<td align="left"><a href="../tour/readnum?id=${tlist.id}">${tlist.title}</a></td>
			</c:if>
			<c:if test="${userid==tlist.userid}">
			<td align="left"><a href="../tour/content?id=${tlist.id}">${tlist.title}</a></td>
			</c:if>
			<td> ${tlist.userid } </td>
			<td> ${tlist.readnum } </td>
			<td> ${tlist.writeday } </td>			
		</tr>
		</c:forEach>
		<c:if test="${!empty userid}">
		<tr>
			<td colspan="4" align="right"><a href="../tour/write" id="write">글쓰기</a></td>
		</tr>
		</c:if>
		</table>
		</div>
		<hr>
		<h3>문의 내용</h3>
			<c:forEach var="inqlist" items="${inqlist}">
			<table width="800" align="center" id="inquiry">
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