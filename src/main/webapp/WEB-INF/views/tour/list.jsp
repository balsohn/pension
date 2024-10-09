<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        body {
            font-family: 'GmarketSansMedium';
        }
        section {
            width: 700px;
            margin: auto;
        }
        .grid-container {
            margin: auto;
            width: 700px;
            display: grid;
            grid-template-columns: 1.5fr 3fr 1fr 1fr 1.5fr; /* 첫 번째와 마지막 열의 너비를 증가 */
            border-bottom: 2px solid black;
            padding: 7.5px 0;
        }
        .grid-container.header {
            font-weight: bold;
            border-top: 3px solid black;
            border-bottom: 3px solid black;
        }
        .grid-container.son {
            border-bottom: 1px solid black;
        }
        .grid-container div {
            text-align: center;
        }
        .grid-container .title {padding-left:5px; text-align: left;}
        .grid-container .title a{ text-decoration: none; color: black;}
        .grid-container .title a:visited {color:gray;}
        .btn {
            display: flex;
            justify-content: flex-end;
            margin: 20px;
            
        }
        .btn a {
            display: inline-block;
            width: 100px;
            background: green;
            color: white;
            text-align: center;
            text-decoration: none;
            padding: 5px 0;
        }
    </style> 
</head>
<body>
    <section>
        <div class="grid-container header">
            <div class="column-1">글번호</div>
            <div class="title">제목</div>
            <div>조회수</div>
            <div>작성자</div>
            <div class="column-last">작성일</div>
        </div>
        <c:forEach var="tlist" items="${tlist}">
        <div class="grid-container son">
            <div class="column-1">${tlist.id}</div>
            <c:if test="${userid!=tlist.userid}">
            <div class="title"><a href="readnum?id=${tlist.id}">${tlist.title }</a></div>
            </c:if>
            <c:if test="${userid==tlist.userid}">
            <div class="title"><a href="content?id=${tlist.id}">${tlist.title }</a></div>
            </c:if>
            <div>${tlist.readnum}</div>
            <div>${tlist.userid}</div>
            <div class="column-last">${tlist.writeday}</div>
        </div>
        </c:forEach>
        <c:if test="${!empty userid}">
        <div class="btn"><a href="write">후기 등록</a></div>
        </c:if>
    </section>
</body>
</html>
