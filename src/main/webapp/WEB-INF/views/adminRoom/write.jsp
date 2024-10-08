<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>객실 추가</title>
<style>
    section {
        width: 1000px;
        height: auto;
        margin: auto;
        margin-bottom: 50px;
        text-align: center;
    }
    section table {
        border-spacing: 0;
        text-align: center;
        margin: auto;
        width: 700px;
    }
    section table td {
        border-bottom: 1px solid green;
        padding: 5px;
        height: 35px;
    }
    section table tr:first-child td {
        border-top: 2px solid green;
    }
    section table tr:last-child td {
        border-bottom: 2px solid green;
    }
    section table input[type=text],
    section table select,
    section table textarea {
        width: 100%;
        border: 1px solid green;
        outline: none;
    }
    section table input[type=text],
    section table select {
        height: 28px;
    }
    section table textarea {
        height: 200px;
    }
    section table input[type=button],
    section table input[type=submit] {
        width: 150px;
        height: 28px;
        background: #654321;
        color: white;
        border: 1px solid green;
        cursor: pointer;
        font-family: 'GmarketSansMedium', Arial, sans-serif;
    }
    section table input[type=submit] {
        width: 304px;
    }
    .file-container {
        display: flex;
        align-items: center;
        justify-content: space-around;
        width: 100%;
        margin-bottom: 10px;
        padding: 0 30px;
    }
    .file-container div {
        margin: 5px 0;
    }
    .file-container input[type=file] {
        display: none;
    }
    .file-label {
        cursor: pointer;
        color: black;
        font-weight: bold;
        text-decoration: underline;
    }
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
        height: 100px;
    }
    .delete-btn {
        position: absolute;
        top: 0;
        right: 0;
        background: red;
        color: white;
        border: none;
        cursor: pointer;
    }
    #drop-area {
        border: 4px dashed gray;
        border-radius: 5px;
        width: 500px;
        min-height:100px;
        height: auto;
        margin: 10px auto;
        display: flex;
        justify-content: center;
        align-items: center;
        text-align: center;
        cursor: pointer;
        flex-wrap: wrap; /* 추가: 미리보기 이미지가 영역 내에 표시되도록 */
        padding: 20px;
        position: relative; /* 추가: 텍스트와 이미지의 위치 관계를 설정하기 위해 */
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
</style>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        let fileInputCounter = 0;

        const dropArea = document.getElementById('drop-area');
        const fileElem = document.getElementById('fileElem');
        const dropAreaText = document.getElementById('drop-area-text');

        dropArea.addEventListener('click', (e) => {				// dropArea를 클릭하면 click한곳이 e
            if (e.target === dropArea) {						// 클릭한곳(e)가 dropArea라면
                triggerFileInput();								// triggerFileinput 객체 실행
            }
        });																	

        function triggerFileInput() {							
            fileElem.click();									// triggerFileInput 객체 실행=fileElem(input type="file") 클릭
        }

        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {		// 'dragenter', 'dragover', 'dragleave', 'drop' 4개중 
            dropArea.addEventListener(eventName, preventDefaults, false);			// 하나가 작동되면 preventDefaults 객체 실행
        });

        function preventDefaults(e) {							// preventDefaults 객체
            e.preventDefault();									// 파일을 인터넷 창에 올려놨을때 다운로드,업로드 등 이외의 활동 제어
            e.stopPropagation();
        }
		
        // highlight는 무언가를 드래그로 dropArea에 올려놨을때 style을 변경해주는 효과
        // class를 추가 및 삭제함으로써 <style>의 highlight에 style을 적용 및 해제 
        ['dragenter', 'dragover'].forEach(eventName => {		// 'dragenter', 'dragover' 하나가 작동되면 dropArea의 class="highlight" 추가
            dropArea.addEventListener(eventName, () => dropArea.classList.add('highlight'), false);
        });

        ['dragleave', 'drop'].forEach(eventName => {			// 'dragleave', 'drop' 하나가 작동되면 dropArea의 class="highlight" 삭제
            dropArea.addEventListener(eventName, () => dropArea.classList.remove('highlight'), false);
        });

        dropArea.addEventListener('drop', handleDrop, false);		// dropArea에 drop이 작동되면 handelDrop 객체 실행
        fileElem.addEventListener('change', handleFiles, false);	// fileElem(input type="file")에 change되면 handleFiles 객체 실행

        function handleDrop(e) {					// drop시에 이 객체로 이동
            const dt = e.dataTransfer;				// drop으로 받은 파일 저장
            const files = dt.files;					// dt에 담긴 이미지의 file을 files의 배열에 저장
            handleFiles({ target: { files } });		// handleFiles(매개변수) 객체 실행
        }

        function handleFiles(e) {					// 드랍이나 input으로 받은후 실행되는 객체
            const files = e.target.files;			
            ([...files]).forEach(file => {			// ..?
                addFileInputForDroppedFile(file);	// addFileInputForDroppedFile 객체 실행
            });
            updateDropAreaText();					// updateDropAreaText 객체 실행
        }

        function addFileInputForDroppedFile(file) {			// file을 받아서 <input type="file" name="fname0"> 에 dataTransfer.items.add로 입력하기
            fileInputCounter++;
            const newFileInput = document.createElement('input');		// input 태그 만들기
            newFileInput.type = 'file';
            newFileInput.name = 'fname' + fileInputCounter;		
            newFileInput.style.display = 'none';
            newFileInput.onchange = previewFile;		// 파일을 넣을때 onchange로 반응=>previewFile객체 실행

            const dataTransfer = new DataTransfer();
            dataTransfer.items.add(file);
            newFileInput.files = dataTransfer.files;	// input파일에 사진 등록

            document.getElementById('imagePreviewContainer').appendChild(newFileInput);		// 위에 만들어진 input 태그 생성
            previewFile({ target: newFileInput });		// previewFile 객체 실행
        }

        function previewFile(event) {
            const file = event.target.files[0];
            if (file) {
                const imageContainer = document.createElement('div');	// <div class="tumbnail-container"></div>
                imageContainer.className = 'thumbnail-container';

                const deleteButton = document.createElement('button');  // <button class="delete-btn" onclick=""> X </button>
                deleteButton.innerHTML = 'X';
                deleteButton.className = 'delete-btn';
                deleteButton.onclick = function() {
                    imageContainer.remove();		// onclick=imageContainer 삭제
                    event.target.remove();			// onclick=<input type="file" name="fname0"> 삭제
                    updateDropAreaText();			
                };

                if (file.type.startsWith('image/')) {		// file이름이 image/로 시작하면(파일이 이미지면)
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        const image = document.createElement('img');		// <img src="이미지정보" class="thumbnail"> 생성
                        image.src = e.target.result;
                        image.className = 'thumbnail';

                        imageContainer.appendChild(image);				// <div class="tumbnail-container"></div> 태그 안에 <img src="이미지정보" class="thumbnail">
                        imageContainer.appendChild(deleteButton);		// <div class="tumbnail-container"> <img src="이미지정보" class="thumbnail"> <button class="delete-btn" onclick=""> X </button> </div>
                        dropArea.appendChild(imageContainer);			// 위의 태그를 dropArea태그안에 생성
                    };
                    reader.readAsDataURL(file);		// file(사진)을 url방식으로 읽기
                } else {
                    const fileIcon = document.createElement('div');			// 파일이 사진이 아니면
                    fileIcon.className = 'file-icon';						// blah blah
                    fileIcon.textContent = file.name;
                    fileIcon.style.width = '100px';
                    fileIcon.style.height = '100px';
                    fileIcon.style.display = 'flex';
                    fileIcon.style.alignItems = 'center';
                    fileIcon.style.justifyContent = 'center';
                    fileIcon.style.border = '1px solid #ccc';
                    fileIcon.style.borderRadius = '10px';					// 파일의 이름을 출력

                    imageContainer.appendChild(fileIcon);
                    imageContainer.appendChild(deleteButton);
                    dropArea.appendChild(imageContainer);
                }
            }
        }

        function updateDropAreaText() {
            const thumbnails = document.querySelectorAll('.thumbnail-container');
            if (thumbnails.length === 0) {				// thumbnail-container안의 태그요소가 0이라면
                dropAreaText.style.display = 'block';	// 글씨 출력
            } else {									// 아니라면,
                dropAreaText.style.display = 'none';	// display:none;
            }
        }
    });
</script>
</head>
<body>
    <section>
        <form method="post" action="writeOk" enctype="multipart/form-data">    
            <table>
                <tr>
                    <td>객실명</td>
                    <td><input type="text" name="title"></td>
                </tr>
                <tr>
                    <td>최소인원</td>
                    <td>
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
                    </td>
                </tr>
                <tr>            
                    <td>최대인원</td>
                    <td>
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
                    </td>
                </tr>
                <tr>
                    <td>객실가격</td>
                    <td><input type="text" name="price"></td>
                </tr>
                <tr>
                    <td>객실설명</td>
                    <td><textarea name="content"></textarea></td>
                </tr>
                <tr>
                    <td>객실사진</td>
                    <td id="aa">
                        <div id="drop-area">
                            <span id="drop-area-text">사진 추가</span>
                        </div>
                        <input type="file" id="fileElem" multiple style="display:none;">
                        <div id="imagePreviewContainer"></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="객실 추가"></td>
                </tr>
            </table>
        </form>
    </section>
</body>
</html>
