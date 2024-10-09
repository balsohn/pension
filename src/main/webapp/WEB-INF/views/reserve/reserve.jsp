<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.example.com/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 달력</title>
<style>
	section {width:800px; margin:auto;}
	table {
		margin:auto;
		width:700px;
		height: 300px;
	}
	th, td {width: 14%; text-align: center;}
	td:hover {background:#ccc;}
	#dateForm {
		text-align: center;
		margin-top: 30px;
	}
	
	#dateForm #inday,#outday {
		width: 150px;
		height: 30px;
		margin-bottom:10px;
		text-align: center;
	}
	
	input[type="submit"],input[type="button"] {
		border:none;
		width: 80px;
		height: 30px;
		background: #ccc;
	}
	
	input[type="submit"]:hover,input[type="button"]:hover {
		background: black;
		color: white;
		cursor: pointer;
	}
	
	a {
		text-decoration: none;
		color: black;
	}
	
	td {
		cursor: pointer;
	}
</style>
<script>


function chkdate(date) {
	var inday=document.getElementById("inday");
	var outday=document.getElementById("outday");
    var selectedDate=new Date(date);
    var inDate=inday.value?new Date(inday.value):null;

    if(!inDate) {
        inday.value=date;
        location.href="reserve?year=${year}&month=${month}&inday="+date;
    } else if (inDate>=selectedDate) {
        outday.value="";
        inday.value=date;
        location.href="reserve?year=${year}&month=${month}&inday="+date;
    } else {
        outday.value=date;
        
    }
}

function resetDate() {
	document.getElementById("inday").value="";
	document.getElementById("outday").value="";
}

function chk() {
	var inday=document.getElementById("inday");
	var outday=document.getElementById("outday");
    if(!inday.value) {
        alert("체크인 날짜를 선택해주세요");
        return false;
    } else if(!outday.value) {
        alert("체크아웃 날짜를 선택해주세요");
        return false;
    } else {
        return true;
    }
}

</script>
</head>
<body>
	<section>
	<table>
		<tr>
			<td>
				<c:choose>
			        <c:when test="${month <= 1}">
			            <a href="reserve?year=${year-1}&month=12&inday=${param.inday}">이전달</a>
			        </c:when>
			        <c:otherwise>
			            <a href="reserve?year=${year}&month=${month-1}&inday=${param.inday}">이전달</a>
			        </c:otherwise>
			  	</c:choose>
			</td>
			<td colspan="5" style="text-align: center;">
				<h2>${year}년 ${month}월</h2>
			</td>
			<td>
				<c:choose>
			        <c:when test="${month >= 12}">
			            <a href="reserve?year=${year+1}&month=1&inday=${param.inday}">다음달</a>
			        </c:when>
			        <c:otherwise>
			            <a href="reserve?year=${year}&month=${month+1}&inday=${param.inday}">다음달</a>
			        </c:otherwise>
			  	</c:choose>
			</td>
		</tr>
		<tr>
			<th>일</th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th>토</th>
		</tr>
		<tr>
			<c:forEach var="i" begin="1" end="${firstday}">
				<td></td>
			</c:forEach>
			<c:forEach var="day" begin="1" end="${chong}">
				<c:set var="date" value="${year}-${month}-${day}"/>
				<td id="${date}" onclick="chkdate('${date}')">${day}</td>
				<c:if test="${(day + firstday) % 7 == 0}">
					</tr><tr>
				</c:if>
			</c:forEach>
		</tr>
	</table>
	<form method="post" id="dateForm" action="roomView" onsubmit="return chk()">
		<div>입실&nbsp;&nbsp;<input type="text" id="inday" name="inday" value="${param.inday}" readonly></div>
		<div>퇴실&nbsp;&nbsp;<input type="text" id="outday" name="outday" value="${param.outday}" readonly></div>
		<div>
			<input type="submit" id="submit" value="예약하기"> 
			<input type="button" onclick="resetDate()" value="날짜 초기화">
		</div>
	</form>
	</section>
</body>
</html>
