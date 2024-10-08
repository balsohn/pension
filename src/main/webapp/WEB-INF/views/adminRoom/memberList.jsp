<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    section {margin: auto; width: 1200px;}
    table {text-align: center; margin: auto; width: 100%; border-collapse: collapse;}
    th, td {padding: 10px 15px; border: 1px solid black;} 
    th {background-color: #f2f2f2;} 
</style>
</head>
<body>
    <section>
        <table>
            <tr>
                <th>회원번호</th>
                <th>아이디</th>
                <th>이름</th>
                <th>비밀번호</th>
                <th>이메일</th>
                <th>전화번호</th>
                <th>가입일자</th>
                <th>회원상태</th>
            </tr>
            <c:forEach var="mem" items="${mlist}">
            <tr>
                <td>${mem.id }</td>
                <td>${mem.userid }</td>
                <td>${mem.name }</td>
                <td>${mem.pwd }</td>
                <td>${mem.email }</td>
                <td>${mem.phone }</td>
                <td>${mem.writeday }</td>
                <td>
                	<c:if test="${mem.state==0}">
                		<a href="memberUp?id=${mem.id}&state=3">정상</a>
                	</c:if>
                	<c:if test="${mem.state==1}">
                		<a href="memberUp?state=2&id=${mem.id}">탈퇴신청중</a>
                	</c:if>
                	<c:if test="${mem.state==2}">탈퇴회원</c:if>
                	<c:if test="${mem.state==3}">진상</c:if>
				</td>
            </tr>
            </c:forEach>
        </table>
    </section>  
</body>
</html>
