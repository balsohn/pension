<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>    
<style>
	section {width:550px; margin:10px auto; margin-top:50px; font-weight: bold; font-size: 18px;}
	section h2{margin-bottom:10px;}
	.first {display:grid; grid-template-columns:2fr 8fr; grid-gap:5px 0; align-items: center;}
	.first input {width:85%;height:30px; box-sizing: border-box;}
	
	.third {display:grid; grid-template-columns:2fr 3fr 2fr 3fr; align-items: center; margin:10px auto; width:550px;}
	.third select {width:60%;height: 30px;}
	.second {margin:10px auto;}
	.second textarea {resize:vertical; width:100%; height: 500px; margin-top:10px;}
    .preview img {
        max-width: 100px;
        max-height: 100px;
    }
    
    .thumbnail-container {
        position: relative;
        display: inline-block;
        margin: 10px;
    }
    .thumbnail {
        width: 100px;
        height:auto;
    }
    .delete-btn {
        position: absolute;
        top: 0;
        right: 0;
        background: red;
        color: white;
        border: none;
        cursor: pointer;
        width:20px;
        height: 20px;
    }
    #drop-area {
        border: 4px dashed gray;
        border-radius: 5px;
        width: 100%;
        min-height: 100px;
        height: auto;
        margin: 10px auto;
        display: flex;
        justify-content: center;
        align-items: center;
        text-align: center;
        cursor: pointer;
        flex-wrap: wrap;
        padding: 20px;
        position: relative;
    }
    #drop-area.highlight {
        border-color: green;
    }
    #drop-area-text {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        pointer-events: none;
        color: #aaa;
    }
    
    section .btn {text-align: right; margin-top: 20px;} /* 중앙 정렬 및 상단 여백 */
	section .btn input {
		font-family: 'GmarketSansMedium';
		margin: 0 10px; /* 버튼들 사이 간격 */
		text-decoration: none; /* 링크 밑줄 제거 */
		color: white; /* 텍스트 색상 */
		background-color: black; /* 배경색 */
		padding: 10px 20px; /* 패딩 */
		border-radius: 3px; /* 모서리 둥글게 */
		border:none;
		cursor: pointer;
		font-size: 15px;
		margin-bottom:30px;
	}
	section .btn input:hover {
		background-color: #0056b3; /* 호버 시 배경색 */
	}
</style>
<script>
    var imgnum = "";

    function aaaa(bbbb) {
        document.getElementById(bbbb).remove();
        imgnum = imgnum + bbbb + "/";
        document.getElementById("imgnum").value = imgnum;
    }
    
    document.addEventListener("DOMContentLoaded", function() {
        let fileInputCounter = 0;

        const dropArea = document.getElementById('drop-area');
        const fileElem = document.getElementById('fileElem');
        const dropAreaText = document.getElementById('drop-area-text');

        dropArea.addEventListener('click', (e) => {
            if (e.target === dropArea) {
                triggerFileInput();
            }
        });

        function triggerFileInput() {
            fileElem.click();
        }

        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            dropArea.addEventListener(eventName, preventDefaults, false);
        });

        function preventDefaults(e) {
            e.preventDefault();
            e.stopPropagation();
        }

        ['dragenter', 'dragover'].forEach(eventName => {
            dropArea.addEventListener(eventName, () => dropArea.classList.add('highlight'), false);
        });

        ['dragleave', 'drop'].forEach(eventName => {
            dropArea.addEventListener(eventName, () => dropArea.classList.remove('highlight'), false);
        });

        dropArea.addEventListener('drop', handleDrop, false);
        fileElem.addEventListener('change', handleFiles, false);

        function handleDrop(e) {
            const dt = e.dataTransfer;
            const files = dt.files;
            handleFiles({ target: { files } });
        }

        function handleFiles(e) {
            const files = e.target.files;
            ([...files]).forEach(file => {
                addFileInputForDroppedFile(file);
            });
            updateDropAreaText();
        }

        function addFileInputForDroppedFile(file) {
            fileInputCounter++;
            const newFileInput = document.createElement('input');
            newFileInput.type = 'file';
            newFileInput.name = 'fname' + fileInputCounter;
            newFileInput.style.display = 'none';
            newFileInput.onchange = previewFile;

            const dataTransfer = new DataTransfer();
            dataTransfer.items.add(file);
            newFileInput.files = dataTransfer.files;

            document.getElementById('imagePreviewContainer').appendChild(newFileInput);
            previewFile({ target: newFileInput });
        }

        function previewFile(event) {
            const file = event.target.files[0];
            if (file) {
                const imageContainer = document.createElement('div');
                imageContainer.className = 'thumbnail-container';
                const imgId = file.name;

                const deleteButton = document.createElement('button');
                deleteButton.innerHTML = 'X';
                deleteButton.className = 'delete-btn';
                deleteButton.onclick = function() {
                    imageContainer.remove();
                    event.target.remove();
                    aaaa(imgId);
                    updateDropAreaText();
                };

                if (file.type.startsWith('image/')) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        const image = document.createElement('img');
                        image.src = e.target.result;
                        image.className = 'thumbnail';

                        imageContainer.id = imgId;
                        imageContainer.appendChild(image);
                        imageContainer.appendChild(deleteButton);
                        dropArea.appendChild(imageContainer);
                    };
                    reader.readAsDataURL(file);
                }
            }
        }

        function updateDropAreaText() {
            const thumbnails = document.querySelectorAll('.thumbnail-container');
            if (thumbnails.length === 0) {
                dropAreaText.style.display = 'block';
            } else {
                dropAreaText.style.display = 'none';
            }
        }

        const existingImages = document.querySelectorAll('.existing-img');
        existingImages.forEach(img => {
            const imgId = img.dataset.imgId;
            img.onclick = () => {
                aaaa(imgId);
            };
        });

        updateDropAreaText();
    });
</script>
</head>
<body>
    <section>
    	<h2>객실 수정</h2>
        <form method="post" action="updateOk" enctype="multipart/form-data">
            <input type="hidden" name="imgnum" id="imgnum">
            <input type="hidden" name="id" value="${rdto.id}">
            <div class="first">
                <div>객실명</div> <div><input type="text" name="title" value="${rdto.title}"></div>
                <div>1박 가격 </div>
	            <div> <input type="text" name="price" value="${rdto.price}"></div>
			</div>	            
	        <div class="third">
                <div>최소인원</div>
                <div>
                    <select name="min">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                    </select>
                </div>
                <div>최대인원</div>
                <div>
                    <select name="max">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                    </select>
                </div>
	        </div>    
            
            <div class="second">
                <div>객실설명</div>
                <div><textarea name="content">${rdto.content}</textarea></div>
                <div id="drop-area">
                    <span id="drop-area-text">사진 추가</span>
                    <c:forEach var="img" items="${imgs}">
                        <c:if test="${!empty img}">
                            <div id="${img}" class="thumbnail-container">
                                <img src="../resources/room/${img}" class="thumbnail">
                                <button type="button" class="delete-btn" onclick="aaaa('${img}')">X</button>
                                <div>${img}</div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
                <input type="file" id="fileElem" multiple style="display:none;">
                <div id="imagePreviewContainer"></div>
            </div>
            <div class="btn">
                <input type="submit" value="객실 수정">
            </div>
        </form>
    </section>
</body>
</html>
