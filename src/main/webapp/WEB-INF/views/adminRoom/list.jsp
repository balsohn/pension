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
      width:1000px;
      height:600px;
      margin:auto;
      font-family: 'GmarketSansMedium';
   }
   section table {
     border-spacing:0px;  
     margin-bottom:200px;
     margin:auto;
   }
</style>
</head>
<body>
	<section>
		<table width="700" align="center">
			<tr>
				<td> 객실명 </td>
				<td> 최소인원 </td>
				<td> 최대인원 </td>
				<td> 가 격 </td>
				<td> 등록일 </td>
			</tr>
			<c:forEach items="${rlist}" var="rdto">
			<tr>
				<td><a href="content?id=${rdto.id}"> ${rdto.title } </a></td>
				<td> ${rdto.min } </td>
				<td> ${rdto.max } </td>
				<td> ${rdto.price2 } </td>
				<td> ${rdto.writeday} </td>
			</tr>
			</c:forEach>
			<tr>
				<td colspan="5" align="right">
					<a href="write">객실 추가</a>
				</td>
			</tr>
		</table>
	</section>
</body>
</html>