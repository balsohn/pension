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
   section table td {
     border-bottom:1px solid black;
     padding:5px;
     height:35px;
   }
   section table tr:first-child td {
     border-top:2px solid black;
     border-bottom:2px solid black;
   }
   section table tr:last-child td {
     border-bottom:2px solid black;
     height: 
   }
   section #write {
     display:inline-block;
     width:100px;
     background:green;
     color:white;
     text-align:center;
     text-decoration:none;
     padding-top:5px;
     padding-bottom:5px;
   }
  </style>	
</head>
<body>
	<section>
		<table width="800" align="center">
		<caption><h3>회원 게시판</h3></caption>
		<tr align="center">
			<td> 글번호 </td>
			<td width="400px"> 제 목</td>
			<td> 작성자 </td>
			<td> 조회수 </td>
			<td> 작성일 </td>			
		</tr>
		<c:forEach var="blist" items="${blist}">
		<tr align="center">
			<td> ${blist.id }</td>
			<c:if test="${userid!=blist.userid}">
			<td align="left"><a href="readnum?id=${blist.id}">${blist.title}</a></td>
			</c:if>
			<c:if test="${userid==blist.userid}">
			<td align="left"><a href="content?id=${blist.id}">${blist.title}</a></td>
			</c:if>
			<td> ${blist.userid } </td>
			<td> ${blist.readnum } </td>
			<td> ${blist.writeday } </td>			
		</tr>
		</c:forEach>
		<c:if test="${!empty userid}">
		<tr>
			<td colspan="5" align="right"><a href="write" id="write">글쓰기</a></td>
		</tr>
		</c:if>
		</table>
	</section>
</body>
</html>