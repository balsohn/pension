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
      text-align:center;
   }
   section div {
      width:600px;
      height:50px;
      line-height:50px;
      border:1px solid green;
      margin:auto;
      margin-top:8px;
   }
   section #content {
     height:300px;
     overflow:auto;
     text-align:left;
     padding: 10px; /* Add padding */
     line-height: 30px;
     
   }
   section #rnum {
     font-size:11px;
     color:green;
   }
   section #btn a {
     display:inline-block;
     text-decoration:none;
     width:100px;
     height:28px;
     line-height:30px;
     border:1px solid green;
     color:green;
   }
   section #btn a:hover {
   		background: green;
   		color: white;
   }
  </style>
</head>
<body> <!-- gongji/content.jsp -->
 <section>
    <h3> 게시글 작성 </h3>
    <div> ${bdto.title} </div>
    <div> ${bdto.readnum} <span id="rnum">(조회수)</span> </div>
    <div id="content"> ${bdto.content} </div>
    <div id="btn">
      <a href="list"> 목록 </a>
      <c:if test="${userid==bdto.userid}">
      <a href="update?id=${bdto.id}"> 수정 </a>
      <a href="delete?id=${bdto.id}"> 삭제 </a>
      </c:if>
      <c:if test="${userid=='admin'}">
      <a href="delete?id=${bdto.id}"> 삭제 </a>
      </c:if>
    </div>
 </section>
</body>
</html>