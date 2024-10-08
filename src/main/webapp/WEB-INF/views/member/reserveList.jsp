<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  

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
   }
  section table {
     border-spacing:0px;  
     margin-bottom:200px;
   }
   section table td {
     border-bottom:1px solid green;
     padding:5px;
     height:35px;
     
   }
   section table tr:first-child td {
     border-top:2px solid green;
     border-bottom:2px solid green;
   }
   section table tr:last-child td {
     border-bottom:2px solid green;
   }
  </style>
</head>
<body>  <!-- member/reserveList -->
  <section>
    <table width="900" align="center">
      <caption> <h3> ${userid}님의 예약 현황 </h3> </caption>
      <tr align="center">
        <td> 입실일 </td>
        <td> 퇴실일 </td>
        <td> bbq </td>
        <td> 숯불 </td>
        <td> 결제금액 </td>
        <td> 예약일 </td>
        <td> 상태 </td>
        <td> 취소 </td>
      </tr>
     <c:forEach items="${rlist}" var="rdto">
      <c:if test="${rdto.chk==true}">
       <tr align="center">
      </c:if>
      <c:if test="${rdto.chk==false}">
       <tr align="center" style="background:#eeeeee">
      </c:if>

        <td> ${rdto.inday} </td>
        <td> ${rdto.outday} </td>
        <td> ${rdto.bbq} </td>
        <td> ${rdto.fire} </td>
        <td> <fmt:formatNumber value="${rdto.chgprice}" pattern="#,###"/>원  </td>
        <td> ${rdto.writeday} 
         <fmt:formatDate value="<%=new java.util.Date()%>" var="today" pattern="yyyy-MM-dd"/>
         <fmt:parseDate  value="${rdto.outday}" var="xday" pattern="yyyy-MM-dd"/>
         <fmt:formatDate value="${xday}" var="xday" pattern="yyyy-MM-dd"/>
         <c:if test="${today >= xday}">
           <td> 사용완료 </td>
           <td> -- </td>
         </c:if>
         <c:if test="${today < xday}"> 
           <td> 사용전</td>
           <td> 
             <c:if test="${rdto.state==2}">
               취소완료
             </c:if>
             <c:if test="${rdto.state==1}">
              <input type="button" value="취소신청중">
             </c:if> 
             <c:if test="${rdto.state==0}">
              <input type="button" value="취소신청" onclick="location='cancelRe?id=${rdto.id}&state=1'">
             </c:if> 
           </td>
         </c:if>
        </td>
        <!-- reserve테이블의 state  0:예약완료  1:취소신청  2:취소완료 -->
      </tr>
     
     </c:forEach>
    </table>
     <fmt:formatDate value="<%=new java.util.Date()%>" var="imsi" pattern="yyyy-MM-dd a hh:mm:ss"/>
    
  </section>
</body>
</html>