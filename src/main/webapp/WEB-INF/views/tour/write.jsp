<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
  section {width:600px; text-align: center; margin:20px auto;}
  section h3{text-align: left; margin:10px auto;}
  section input[type=text] {width:100%; height:35px;}
  section textarea {width:100%; resize: vertical; margin:15px auto; height:400px;}
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
    border: 4px solid gray;
    border-radius: 5px;
    width: 100%;
    min-height:100px;
    height: auto;
    margin: 5px auto;
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    cursor: pointer;
    flex-wrap: wrap; /* 추가: 미리보기 이미지가 영역 내에 표시되도록 */
    padding: 20px;
    position: relative; /* 추가: 텍스트와 이미지의 위치 관계를 설정하기 위해 */
  }
  
  #drop-area:hover {background:#ccc;}
  
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
		
  input[type=submit] {
    margin-top: 10px;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
  }
  .btn{text-align: right;}
  
  input[type=submit] {
  	font-family: 'GmarketSansMedium';
    background-color: black;
    color: white;
    border: none;
    border-radius: 3px;
  }
  
  input[type=submit]:hover {
    background-color: #0056b3;
  }
	
</style>
</head>
<body>
  <section>
    <h3>여행 후기 등록</h3>
    <form id="reviewForm" action="writeOk" method="post" enctype="multipart/form-data">
      <div>
        <input type="text" name="title" placeholder="제목">
      </div>
      <div>
        <textarea name="content" placeholder="후기 내용"></textarea>
      </div>
      <div id="drop-area">
        <span id="drop-area-text">사진 추가</span>
      </div>
      <input type="file" id="fileElem" multiple style="display:none;" onchange="handleFiles(this.files)">
      <div id="imagePreviewContainer"></div>
      <div class="btn">
        <input type="submit" value="등록">
      </div>
    </form>
  </section>

  <script>
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
      dropArea.addEventListener(eventName, preventDefaults, false)
    });

    function preventDefaults(e) {
      e.preventDefault();
      e.stopPropagation();
    }

    ['dragenter', 'dragover'].forEach(eventName => {
      dropArea.addEventListener(eventName, () => dropArea.classList.add('highlight'), false)
    });

    ['dragleave', 'drop'].forEach(eventName => {
      dropArea.addEventListener(eventName, () => dropArea.classList.remove('highlight'), false)
    });

    dropArea.addEventListener('drop', handleDrop, false);

    function handleDrop(e) {
      const dt = e.dataTransfer;
      const files = dt.files;
      handleFiles(files);
    }

    function handleFiles(files) {
      ([...files]).forEach(file => {
        addFileInputForDroppedFile(file);
      });
      updateDropAreaText(); // 드래그 앤 드롭 영역의 텍스트 업데이트
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

        const deleteButton = document.createElement('button');
        deleteButton.innerHTML = 'X';
        deleteButton.className = 'delete-btn';
        deleteButton.onclick = function() {
          imageContainer.remove();
          event.target.remove();
          updateDropAreaText(); // 드래그 앤 드롭 영역의 텍스트 업데이트
        };

        if (file.type.startsWith('image/')) {
          const reader = new FileReader();
          reader.onload = function(e) {
            const image = document.createElement('img');
            image.src = e.target.result;
            image.className = 'thumbnail';

            imageContainer.appendChild(image);
            imageContainer.appendChild(deleteButton);
            dropArea.appendChild(imageContainer); // 수정: 드래그 앤 드롭 영역에 추가
          };
          reader.readAsDataURL(file);
        } else {
          const fileIcon = document.createElement('div');
          fileIcon.className = 'file-icon';
          fileIcon.textContent = file.name;
          fileIcon.style.width = '100px';
          fileIcon.style.height = '100px';
          fileIcon.style.display = 'flex';
          fileIcon.style.alignItems = 'center';
          fileIcon.style.justifyContent = 'center';
          fileIcon.style.border = '1px solid #ccc';
          fileIcon.style.borderRadius = '10px';

          imageContainer.appendChild(fileIcon);
          imageContainer.appendChild(deleteButton);
          dropArea.appendChild(imageContainer); // 수정: 드래그 앤 드롭 영역에 추가
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
  </script>
</body>
</html>
