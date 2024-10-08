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
            grid-template-columns: 4fr 2fr 1fr 2fr; /* 첫 번째와 마지막 열의 너비를 증가 */
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
        .grid-container .title {margin-left: 5px; padding-left:5px; text-align: left;}
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
			<div class="column-1 title"> 제 목 </div>
			<div> 작성자 </div>
			<div> 조회수 </div>
			<div class="column-last"> 작성일 </div>
		</div>
		<c:forEach var="glist" items="${glist}">
		<div class="grid-container son">
			<div class="title"><a href="readnum?id=${glist.id}">${glist.title}</a></div>
			<div> 관리자 </div>
			<div> ${glist.readnum}</div>
			<div> ${glist.writeday }</div>
		</div>
		</c:forEach>
		<c:if test="${userid=='admin'}">
		<div class="btn"><a href="write">글쓰기</a></div>
		</c:if>
		
	</section>
</body>
</html>