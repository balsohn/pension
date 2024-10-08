<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:forEach var="mdto" items="${mlist}">
	<p>	${mdto.userid} : ${mdto.name} : ${mdto.email} </p>
	</c:forEach>
	<hr>
	<c:forEach var="mdto1" items="${mapAll}">
	<p>	${mdto1.userid} : ${mdto1.name} : ${mdto1.email}	<p>
	</c:forEach>
</body>
</html>