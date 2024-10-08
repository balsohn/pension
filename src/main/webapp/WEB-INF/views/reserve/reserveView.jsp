<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section {width:700px; height:100%; margin:50px auto;}
	section h2{margin:10px 0;}
	.first {display:grid; grid-template-columns:1fr 3fr 1.2fr 3fr; grid-gap:10px 0; margin:30px 0;
			border:1px solid black; padding:20px; border-radius: 4px;}
	.first div:nth-child(odd) { font-weight: bold; }
</style>
</head>
<body>	<!-- reserve/reserveView.jsp -->
	<section>
		<div><h2>${userid}님의 예약 내용</h2></div>
		<div><h4>예약번호 :  ${rdto.jumuncode}</h4>
		<div class="first">
			<div>예약객실</div><div>${title}</div>
			<div>예약날짜</div><div>${rdto.writeday}</div>
			<div>입실날짜</div><div>${rdto.inday}</div>
			<div>퇴실날짜</div><div>${rdto.outday}</div>
			<div>입실인원</div><div>${rdto.inwon}</div>
			<div>총결제금액</div><div>${price} 원</div>
			<div>BBQ</div><div>${rdto.bbq} 세트</div>
			<div>숯불</div><div>${rdto.fire} 회분</div>
		</div>
	</section>
</body>
</html>