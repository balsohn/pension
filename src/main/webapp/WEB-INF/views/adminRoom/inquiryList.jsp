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
	section table {border:1px solid black; margin: auto; margin:10px auto;
					border-spacing: 0;}
	section td, section tr{border:1px solid black;}
	section textarea {
      width:100%;
      height:98px;
      outline:none;
      border:none;
   }
</style>
</head>
<body>
	<section>
		<c:forEach var="idto" items="${ilist}">
		<form method="post" action="inquiryOk">
		<input type="hidden" name="id" value="${idto.id}">
		<table width="800" align="center">
			<tr>
				<td rowspan="2" width="140" align="center">${idto.title2}
					<div>[${idto.userid}]</div>
				</td>
				<td height="100" style="padding:5px 10px;">${idto.content }</td>
				<td rowspan="2" width="140" align="center">
					${idto.writeday }<p>
					<input type="submit" value="답변달기">
				</td>
			</tr>
			<td height="100"> 
              <textarea name="answer" id="answer" placeholder="답변 대기중">${idto.answer}</textarea> 
           </td>
		</table>
		</form>
		</c:forEach>
	</section>
</body>
</html>