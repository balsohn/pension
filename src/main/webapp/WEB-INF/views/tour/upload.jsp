<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Drag and Drop Upload</title>
<style>
  .dropzone {
    width: 100%;
    height: 100%;
    border: 2px dashed #ccc;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Arial';
    font-size: 18px;
    color: #ccc;
  }
  .dropzone.dragover {
    border-color: green;
    color: green;
  }
</style>
</head>
<body>
  <div class="dropzone" id="dropzone">
    Drag and drop images here
  </div>

  <script>
    const dropzone = document.getElementById('dropzone');

    dropzone.addEventListener('dragover', (event) => {
      event.preventDefault();
      event.stopPropagation();
      dropzone.classList.add('dragover');
    });

    dropzone.addEventListener('dragleave', (event) => {
      event.preventDefault();
      event.stopPropagation();
      dropzone.classList.remove('dragover');
    });

    dropzone.addEventListener('drop', (event) => {
      event.preventDefault();
      event.stopPropagation();
      dropzone.classList.remove('dragover');

      const files = event.dataTransfer.files;

      if (files.length > 0) {
        Array.from(files).forEach(file => {
          const reader = new FileReader();

          reader.onload = function() {
            // 추가된 파일을 부모 창에 전달
            window.opener.addFileInput(file);
          };

          reader.readAsDataURL(file);
        });

        window.close(); // 업로드 창 닫기
      }
    });
  </script>
</body>
</html>

