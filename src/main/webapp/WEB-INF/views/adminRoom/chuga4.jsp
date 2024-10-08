<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script>
		function srcview() {
			document.getElementById("src").innerText=document.getElementsByTagName("body")[0].innerHTML;
		}
	
		function add(){
			var len=document.getElementsByClassName("file").length;
			
			var inner=document.getElementById("one").cloneNode(true);
			document.getElementById("outer").appendChild(inner);
			
			document.getElementsByClassName("file")[len].name="fname"+len;
		}
		
		function del() {
			var len=document.getElementsByClassName("file").length;
			document.getElementsByClassName("file")[len-1].parentElement.remove();
		}
	</script>
</head>
<body>
	<input type="button" onclick="add()" value="추가">
	<input type="button" onclick="del()" value="삭제">
	<input type="button" onclick="srcview()" value="소스보기">
	<hr>
	<div id="outer">
		<p class="one" id="one"> <input type="file" name="fname0" class="file"> </p>
	</div>
	<hr>
	<div id="src"></div>
</body>
</html>