<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        .content-container {
            background-color: #ffffff;
            padding: 20px;
            margin: 30px auto 10px auto;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            max-width: 800px;
        }
        .content {
            margin: 10px 0;
        }
        .title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .userid, .writeday {
            font-size: 14px;
            color: #777777;
        }
        .aa {
            font-size: 24px;
            font-weight: bold;
            margin-top: 30px;
            margin-bottom: 10px;
        }
        .bb {
            font-size: 16px;
            line-height: 1.5;
            margin-bottom: 30px;
        }
        #mainImage {
            display: block;
            max-width: 100%;
            margin: auto;
            margin-top:20px;
            margin-bottom:20px;
            border: 1px solid #cccccc;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        #imagePreviewContainer {
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            background: #ccc;
            
        }
        #imagePreview {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            justify-content: center;
        }
        #imagePreview img {
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            object-fit: cover;
            flex: 1 1 auto;
            height: 150px;
        }
        #imagePreview img:hover {
            transform: scale(1.1);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .btn {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-top: 20px;
        }
        .btn div {
            padding: 10px 20px;
            background-color: #007BFF;
            color: #ffffff;
            border-radius: 5px;
            text-align: center;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .btn div:hover {
            background-color: #0056b3;
        }
        .btn div a {
            color: #ffffff;
            text-decoration: none;
        }
        .cc {width:50%; align:center;}
    </style>
</head>
<body>

<section>
    <div class="content-container">
        <div class="content title">${tdto.title}</div><hr>
        <div class="content userid">작성자</div>
        <div class="content">${tdto.userid}</div>
        <div class="content writeday">작성일</div>
        <div class="content">${tdto.writeday}</div>
    </div>
    <div class="content-container">
    	<img id="mainImage" src="" alt="Click an image to view it here">
        <div id="imagePreviewContainer">
            <div id="imagePreview">
                <c:forEach var="img" items="${imgs}">
                    <img src="../resources/tour/${img}" onclick="displayMainImage('../resources/tour/${img}')">
                </c:forEach>
            </div>
        </div>
        <div class="aa">후기<hr></div>
        <div class="bb">${tdto.content}</div><hr>
        
        <c:if test="${userid==tdto.userid}">
        <div class="btn">
            <div><a href="update?id=${tdto.id}">수정</a></div>
            <div><a href="delete?id=${tdto.id}" onclick="return del()">삭제</a></div>
        </div>
        </c:if>
    </div>
</section>
    <script>
        window.onload = function() {
            const images = document.querySelectorAll('#imagePreview img');
            if (images.length > 0) {
                displayMainImage(images[0].src);
            }
            adjustImageSizes();
        };

        function displayMainImage(src) {
            const mainImage = document.getElementById('mainImage');
            mainImage.src = src;
        }

        function del() {
            return confirm("정말 삭제하시겠습니까?");
        }

        function adjustImageSizes() {
            const imagePreview = document.getElementById('imagePreview');
            const images = imagePreview.querySelectorAll('img');
            const containerWidth = imagePreview.clientWidth;
            const imageCount = images.length;
            const imageWidth = (containerWidth - (imageCount - 1) * 10) / imageCount; // gap adjustment
            images.forEach(img => {
                img.style.width = imageWidth + 'px';
            });
        }

        window.onresize = adjustImageSizes;
    </script>
</body>
</html>
