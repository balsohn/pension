<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>드래그 앤 드롭 파일 업로드</title>
    <style>
    	/* styles.css */
body {
    font-family: Arial, sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

#drop-area {
    border: 4px dashed #ccc;
    border-radius: 20px;
    width: 400px;
    height: 200px;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    text-align: center;
    padding: 20px;
}

#drop-area.highlight {
    border-color: purple;
}

.button {
    margin-top: 10px;
    padding: 10px 20px;
    background-color: purple;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    text-decoration: none;
}

.button:hover {
    background-color: darkmagenta;
}

#gallery {
    margin-top: 20px;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
}

#gallery img {
    width: 100px;
    height: 100px;
    margin: 5px;
    object-fit: cover;
    border: 2px solid #ddd;
    border-radius: 10px;
}
    	
    </style>
    <script>
 // script.js
    const dropArea = document.getElementById('drop-area');
    const fileInput = document.getElementById('fileElem');
    const gallery = document.getElementById('gallery');

    // 드래그 이벤트
    ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
        dropArea.addEventListener(eventName, preventDefaults, false);
    });

    function preventDefaults(e) {
        e.preventDefault();
        e.stopPropagation();
    }

    // 드래그 엔터와 오버 이벤트에서 하이라이트 클래스 추가
    ['dragenter', 'dragover'].forEach(eventName => {
        dropArea.addEventListener(eventName, () => {
            dropArea.classList.add('highlight');
        }, false);
    });

    // 드래그 리브와 드롭 이벤트에서 하이라이트 클래스 제거
    ['dragleave', 'drop'].forEach(eventName => {
        dropArea.addEventListener(eventName, () => {
            dropArea.classList.remove('highlight');
        }, false);
    });

    // 드롭 이벤트 처리
    dropArea.addEventListener('drop', handleDrop, false);

    function handleDrop(e) {
        const dt = e.dataTransfer;
        const files = dt.files;
        handleFiles(files);
    }

    fileInput.addEventListener('change', (e) => {
        const files = e.target.files;
        handleFiles(files);
    });

    function handleFiles(files) {
        ([...files]).forEach(uploadFile);
        ([...files]).forEach(previewFile);
    }

    function uploadFile(file) {
        const url = 'YOUR_UPLOAD_URL'; // 파일을 업로드할 서버의 URL로 변경하세요.
        const formData = new FormData();
        formData.append('file', file);

        fetch(url, {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            console.log(data);
        })
        .catch(error => {
            console.error(error);
        });
    }

    function previewFile(file) {
        let reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onloadend = function() {
            let img = document.createElement('img');
            img.src = reader.result;
            gallery.appendChild(img);
        }
    }

    </script>
</head>
<body>
    <div id="drop-area">
        <h2>여기로 파일을 드래그 앤 드롭하세요</h2>
        <input type="file" id="fileElem" multiple accept="image/*" style="display:none">
        <label class="button" for="fileElem">파일 선택</label>
        <div id="gallery"></div>
    </div>
    <script src="script.js"></script>
</body>
</html>
