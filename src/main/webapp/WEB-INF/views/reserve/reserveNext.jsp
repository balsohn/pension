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
        margin: 30px auto;
        width: 600px;
        height: 100%;
    }
    section .one, section .two, section .three, section .four {
        display: grid;
        grid-gap: 10px;
        margin: 10px auto;
    }
    section .one {
        grid-template-columns: 1.2fr 1fr 1.2fr 1fr;
    }
    section .two {
        grid-template-columns: 1.2fr 1fr 1.2fr 1fr;
    }
    section .three {
        grid-template-columns: 1.2fr 1fr 1.2fr 1fr;
    }
    section .four {
        grid-template-columns: 1fr;
    }
    section .four img {
        max-width: 100%;
        height: auto;
    }
    .img-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 10px; /* 이미지 사이의 간격 */
    }
    .imgs {
        width: 50px;
        height: 30px;
        flex-shrink: 0;
    }
    .imgs img {
        width: 100%;
        height: 100%;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .imgs:hover img {
        transform: scale(1.4);
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
    }
    section select {width:100px; height:20px;}
    
    .preview {text-align: center;}
    .btn {text-align:right;}
    .btn input {border:none; padding:10px 20px; background: black; color: white;    
    			font-family: 'GmarketSansMedium', Arial, sans-serif; border-radius: 3px;}
    .btn input:hover {background-color: #0056b3; cursor: pointer;}
</style>
<script>
    function chgPrice() {
        var sukprice = ${rdto.price}; // 숙박 기본 가격
        var min = ${rdto.min}; // 최소 인원
        var inwonSelect = document.getElementsByName("inwon")[0];
        var bbqSelect = document.getElementsByName("bbq")[0];
        var fireSelect = document.getElementsByName("fire")[0];
        var sukSelect = document.getElementsByName("suk")[0];

        var inwonprice = (parseInt(inwonSelect.value) - min) * 10000 * sukSelect.value; // 추가 인원 가격 (1인당 10,000원)
        var bbqprice = parseInt(bbqSelect.value) * 50000; // BBQ 가격 (1개당 50,000원)
        var fireprice = parseInt(fireSelect.value) * 20000; // 숯불 가격 (1개당 20,000원)
        var sukprice = parseInt(sukSelect.value) * ${rdto.price};

        var totalPrice = sukprice + inwonprice + bbqprice + fireprice;
        var totalPrice1 = new Intl.NumberFormat().format(totalPrice);
        document.getElementById("totalPrice").innerText = totalPrice1;
        document.getElementById("chgprice").value=totalPrice;
    }
    
    function chgImg(src) {
        document.querySelector(".four img").src = src;
    }
</script>
</head>
<body>
<section>
	<form method="post" action="reserveOk">
	<input type="hidden" name="inday" value="${date}">
	<input type="hidden" name="chgprice" id="chgprice" value="${rdto.price}">
	<input type="hidden" name="rid" value="${rdto.id}">
    <h2>${rdto.title} 예약</h2>
    총 가격 : <span id="totalPrice">${rdto.price2}</span> 원
    <div class="one">
        <div>입실일</div> <div>${date}</div>
        <div>숙박일수</div>
        <div>
            <select name="suk" onchange="chgPrice()">
            	<c:forEach begin="1" end="${suk}" var="i">
                <option value="${i}">${i}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="two">
        <div>기본정보</div> <div>${rdto.min}인 / ${rdto.max}인</div>
        <div>입실인원</div>
        <div>
            <select name="inwon" onchange="chgPrice()">
                <c:forEach begin="${rdto.min}" end="${rdto.max}" var="i">
                    <option value="${i}">${i}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="three">
        <div>BBQ(50,000원)</div> 
        <div>
            <select name="bbq" onchange="chgPrice()">
                <option value="0">선택안함</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
            </select>
        </div>
        <div>숯불(20,000원)</div>
        <div>
            <select name="fire" onchange="chgPrice()">
                <option value="0">선택안함</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
            </select>
        </div>
    </div>
    <div class="four">
        <div><h3>객실사진</h3></div>
        <c:if test="${!empty imgs[0]}">
        <div class="preview"><img src="../resources/room/${imgs[0]}"></div>
        </c:if>
        <div class="img-container">
            <c:forEach var="img" items="${imgs}">
            	<c:if test="${!empty img}">
                <div class="imgs"><img src="../resources/room/${img}" onclick="chgImg(this.src)"></div>
                </c:if>
            </c:forEach>
        </div>
        <div><h3>객실정보</h3></div> <div>${rdto.content}</div>
    </div>
    <div class="btn"><input type="submit" value="예약"></div>
    </form>
</section>
</body>
</html>
