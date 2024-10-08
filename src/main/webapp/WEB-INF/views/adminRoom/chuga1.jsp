<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script>
	var new2=document.createElement("input");
	function srcview() {
		document.getElementById("src").innerText=document.getElementsByTagName("body")[0].innerHTML;
		
	}
	
	function chuga() {
//		document.getElementById("aa").innerHTML="<b> 오늘은 월요일 </b>"
/*		var new1=document.createElement("b");
		new1.innerText="오늘은 월요일";
		document.getElementById("aa").appendChild(new1);*/
		
/*		var new1=document.createElement("div");
		document.getElementById("aa").appendChild(new1);
		
		var new2=document.createElement("input");
		new2.type="file";
		new2.name="fname";
		
		new1.appendChild(new2);
		document.getElementById("aa").appendChild(new1);*/
		
		var new1=document.createElement("img");
		new1.src="../resources/asdf.jpg";
		document.getElementById("aa").appendChild(new1);
	}
	</script>
</head>
<body>
	<input type="button" onclick="chuga()" value="태그추가">
	<div id="aa"></div>
	<hr><hr>
	<input type="button" onclick="srcview()" value="소스 확인">
	<div id="src"></div>
</body>
</html>