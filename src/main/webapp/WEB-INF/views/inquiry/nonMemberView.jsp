<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section {margin : auto; width:1000px;}
	table {border:1px solid black; margin:auto; border-spacing: 0px;}
	table td {border:1px solid black;}
</style>
</head>
<body>
	<section>
	<table width="800" align="center">
		<tr>
			<td rowspan="2" width="140" align="center">${idto.title2}</td>
			<td height="100" style="padding:5px 10px;">${idto.content }</td>
			<td rowspan="2" width="140" align="center">${idto.writeday }</td>
		</tr>
		<tr>
			<td style="padding:5px 10px;">${idto.answer}</td>
		</tr>
	</table>
	</section>
</body>
</html>