<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    /* CSS Reset */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    @font-face {
        font-family: 'GmarketSansMedium';
        src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }

    html, body {
    	
    	min-height: 100%;
        font-family: 'GmarketSansMedium', Arial, sans-serif;
        margin: 0;
        padding: 0;
        background: #FAFBFF;
        display: flex;
        flex-direction: column;
    }

    body {
        display: flex;
        flex-direction: column;
        flex: 1;
		user-select: none; /* 텍스트 선택 방지 */
		-webkit-user-drag: none; /* 이미지 드래그 방지 */
    }
    
    body > section {flex:1 !important;}

    #outer {
        width: 100%;
        height: 40px;
        background: black;
        color: white;
        display: flex;
        justify-content: center; 
        flex-shrink: 0;
    }

    #outer .content {
        display: flex;
        align-items: center;
        width: 100%;
        max-width: 1000px;
        position: relative;
    }

    #outer .content .left {
        position: absolute;
        left: 0;
    }

    #outer .content .center {
        margin: auto;
        text-align: center; 
    }

    #outer .content .right {
        position: absolute;
        right: 0;
    }

    header, nav, main {
        width: 100%;
        max-width: 1000px;
        margin: 0 auto;
    }

    header {
        height: 108px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    header .logo {
        margin: 45px;
        padding: 10px;
    }

    header .flex-container {
        display: flex;
        justify-content: flex-end;
        align-items: center;
    }

    header .flex-container a {
        margin-right: 8px; /* 오른쪽 링크들 사이에 간격 추가 */
        text-decoration: none;
        color: inherit;
        
    }

    header .flex-container .dropdown {
        position: relative;
        display: inline-block;
        height: 100%; /* 부모 요소의 높이를 상속받도록 설정 */
    }

    header .flex-container .dropdown a {
        display: inline-flex;
        align-items: center;
        height: 100%; /* 부모 요소의 높이를 상속받도록 설정 */
    }

    nav {
        margin-top: 10px;
        height: 50px;
        font-size:16px;
        position: relative;
    	z-index: 999;
    }

    nav ul {
        display: flex;
        list-style: none;
        padding-left: 0;
        margin: 0;
        
    }
	nav a{font-size: 16px;}
    nav ul li {
        flex: 1;
        text-align: center;
        font-weight: 900;
        position: relative;
        font-size:20px;
    }

    nav > ul > li:hover {
        color: black;
        transform: scale(1.1);
        cursor: default;
    }

    nav ul li a {
        text-decoration: none;
        color: black;
        display: block;
        font-size:20px;
    }

    nav ul li a:hover {
        text-decoration: none;
        color: black;
  /*      transform: scale(1.1);*/
    }

    nav ul li ul {
        position: absolute;
        top: 100%;
        left: 0;
        background: white;
        visibility: hidden;
        list-style: none;
        display: flex;
        flex-direction: column;
        z-index: 1000;
        padding: 0px;    
        margin-top: 10px;
        margin: auto;
        width: 150px;
        border: 1px solid black;
        left: 50%; /* 수정: 부모의 중앙으로 이동 */
        transform: translateX(-50%); /* 수정: 중앙 정렬 */
    }

    nav ul li:hover ul {
        visibility: visible;
    }

    nav ul li ul li {
        padding: 0px;
        border-bottom: 1px solid #ccc;
        text-align: left;
    }

    nav ul li ul li:hover {
        background: #848484;
    }

    nav ul li ul li a {
        display: block;
        padding: 10px; /* 패딩을 a 태그로 이동 */
        text-decoration: none;
        color: black;
        width: 100%; /* a 태그가 li 태그의 전체 너비를 차지하도록 */
        box-sizing: border-box; /* 패딩과 테두리를 포함하여 크기 계산 */
        font-size: 16px;
    }

    nav ul li ul li a:hover {
    	
        text-decoration: none;
        color: white;
        text-shadow: 1px 1px 2px black;
    }

    nav ul li ul li:last-child {
        border-bottom: none;
    }

    main {
        flex: 1; /* main 요소가 남은 공간을 차지하도록 설정 */
    }

    footer {
        height: 120px;
        width:100%;
        background: black;
        color: white;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-shrink: 0; /* footer가 화면 크기에 따라 줄어들지 않도록 설정 */
    }
    
    .footer {width:100%;}

    header .flex-container .dropdown-content {
	    display: none;
	    position: absolute;
	    background-color: white;
	    min-width: 160px;
	    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
	    z-index: 1001; /* z-index를 상단 메뉴보다 높게 설정 */
	    right: 0;
	    left: 50%; /* 부모 요소의 중앙에 위치하도록 */
	    transform: translateX(-50%); /* 중앙 정렬 */
	    
	}

    header .flex-container .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }

    header .flex-container .dropdown-content a:hover {
        background-color: #f1f1f1;
    }

    header .flex-container .dropdown:hover .dropdown-content {
        display: block;
    }

    header .flex-container a:hover {
        text-decoration: none;
        color: white; /* 마우스를 올렸을 때의 색상 */
        text-shadow: 1px 1px 2px black;
    }
</style>
<script>
	function viewMenu(){
		if(document.getElementById("menu").innerHTML.trim()==""){
		var chk = new XMLHttpRequest();
		chk.onload = function(){
			var rooms = JSON.parse(chk.responseText);
			for(room of rooms){
				var addLi = document.createElement("li");
				addLi.innerHTML = "<a href='../room/roomView?id=" + room.id + "'>" + room.title + "</a>";
				document.getElementById("menu").appendChild(addLi);
			}
		}
		chk.open("get", "../getRooms");
		chk.send();		
		}
	}
</script>
<decorator:head/>
</head>
<body>
    <div id="outer">
        <div class="content">
            <div class="left">LEFT</div>
            <div class="center">광고성 글</div>
            <div class="right">X</div>
        </div>
    </div>
    <header>
        <a href="../main/index"><div class="logo"><img src="../resources/aaa2.png" width="100px"></div></a>
        <div class="flex-container">
            <c:if test="${empty userid}">
                <a href="../member/login">로그인</a>
                <a href="../member/member">회원가입</a>
                <a href="../inquiry/write">문의하기</a>
            </c:if>
            <c:if test="${!empty userid}">
            	<c:if test="${userid=='admin'}">
            	<a href="../adminRoom/list">객실관리</a>
            	<a href="../adminRoom/reserveList">예약관리</a>
            	<a href="../adminRoom/inquiryList">문의관리</a>
            	</c:if>
            	<div class="dropdown">
                <a href="">${userid} 님</a>
                <div class="dropdown-content">
                        <a href="../member/memberView">회원정보</a>
                        <a href="../member/reserveList">예약정보</a>
                        <a href="../member/myWrite">내가 작성한 글</a>
             	</div>
             	</div>
                <a href="../member/logout">로그아웃</a>
                <a href="../inquiry/write">문의하기</a>
            </c:if>
        </div>
    </header>
    <nav>
        <ul>
            <li>펜션소개
                <ul>
                    <li><a href="">펜션지기</a></li>
                    <li><a href="">오시는길</a></li>
                </ul>
            </li>
            <li>주변볼거리
                <ul>
                    <li><a href="">호수공원</a></li>
                    <li><a href="">킨 텍 스</a></li>
                    <li><a href="">한류월드</a></li>
                    <li><a href="">서 오 능</a></li>
                </ul>
            </li>
            <li>주변맛집
                <ul>
                    <li><a href="">버거킹</a></li>
                    <li><a href="">서가원</a></li>
                    <li><a href="">대동관</a></li>
                    <li><a href="">김밥천국</a></li>
                </ul>
            </li>
            <li onmouseover="viewMenu()"><a href="../room/list">객실현황</a>
                <ul id="menu">
                    <c:forEach var="room" items="${rooms}">
                    <li><a href="../room/roomView?id=${room.id}">${room.title }</a></li>
                    </c:forEach>
                </ul>
            </li>
            <li>예약관련
                <ul>
                    <li><a href="">예약 안내</a></li>
                    <li><a href="../reserve/reserve">실시간 예약</a></li>
                </ul>
            </li>
            <li>커뮤니티
                <ul>
                   <li> <a href="../notice/list">공지사항</a></li>
                    <li> <a href="../tour/list">여행후기</a> </li>
                    <li><a href="../board/list">회원게시판</a></li>
                </ul>
            </li>
        </ul>
    </nav>
    
    
    	<decorator:body/>
    
    <div class="footer"><footer>펜션 정보</footer></div>
</body>
</html>
