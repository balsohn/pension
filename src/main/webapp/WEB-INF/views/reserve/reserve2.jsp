<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.example.com/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 달력</title>
<style>
    
    section {
        text-align: center;
        margin-top: 50px;
    }
    section h1 {
        margin-bottom: 20px;
        color: #333;
        font-size: 24px;
    }
    section table {
        width: 700px;
        margin: 20px auto;
        text-align: center;
        border: 2px solid #444;
        border-spacing: 0;
        background-color: #fff;
    }
    section table th {
        height: 40px;
        background-color: #444;
        color: white;
        border-bottom: 2px solid #333;
    }
    section table td {
        height: 100px;
        vertical-align: top;
        border: 1px solid #ddd;
        padding: 5px;
        background-color: #f9f9f9;
        position: relative;
    }
    section table td:hover {
        background: #e0e0e0;
    }
    section table td a {
        text-decoration: none;
        color: #007bff;
        font-size: 14px;
    }
    section table td p {
        margin: 0;
        padding: 0;
        font-size: 12px;
        color: #555;
    }
    section table td div {
        margin: 5px 0;
    }
    section table td div a {
        color: #444;
        font-weight: bold;
        font-size: 14px;
    }
    section span {
        font-size: 14px;
        margin: 0 15px;
        color: #007bff;
    }
    section span a {
        text-decoration: none;
        color: #007bff;
    }
    section span a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
<section>
<h1>
    <c:choose>
        <c:when test="${month <= 1}">
            <span><a href="reserve?year=${year-1}&month=12">이전달</a></span>
        </c:when>
        <c:otherwise>
            <span><a href="reserve?year=${year}&month=${month-1}">이전달</a></span>
        </c:otherwise>
    </c:choose>
    ${year}년 ${month}월 달력
    <c:choose>
        <c:when test="${month >= 12}">
            <span><a href="reserve?year=${year+1}&month=1">다음달</a></span>
        </c:when>
        <c:otherwise>
            <span><a href="reserve?year=${year}&month=${month+1}">다음달</a></span>
        </c:otherwise>
    </c:choose>
</h1>

<table>
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
        <c:forEach var="i" begin="1" end="${firstDayOfWeek - 1}">
            <td></td>
        </c:forEach>
        <c:forEach var="day" begin="1" end="${daysInMonth}">
            <c:set var="date" value="${year}-${month}-${day}" />
            <td align="left">
                <strong>${day}</strong>
                <p>
                    <c:if test="${fn:dayBefore(date)}">
                        <c:forEach items="${rdto}" var="rdto">
                            <c:set var="rid" value="${rdto.id}" />
                            <c:choose>
                                <c:when test="${fn:isCheck(date, rid)}">
                                    <div align="right" style="color:red;font-size:14px;">${rdto.title}</div>
                                </c:when>
                                <c:otherwise>
                                    <div align="right">
                                        <a href="reserveNext?year=${year}&month=${month}&day=${day}&id=${rdto.id}">${rdto.title}</a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:if>
                </p>
            </td>
            <c:if test="${(day + firstDayOfWeek - 1) % 7 == 0}">
                </tr><tr>
            </c:if>
        </c:forEach>
    </tr>
</table>
</section>
</body>
</html>
