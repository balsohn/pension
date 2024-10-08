<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
  section {
    width: 1000px;
    margin: 30px auto;
    text-align: center;
  }
  section input[type=text] {
    width: 700px;
    height: 50px;
    border: 1px solid green;
    outline: none;
    font-family: 'GmarketSansMedium';
    font-size: 16px;
  }
  section textarea {
    width: 700px;
    height: 300px;
    border: 1px solid green;
    outline: none;
    font-family: 'GmarketSansMedium';
    font-size: 16px;
  }
  section input[type=submit] {
    width: 708px;
    height: 54px;
    border: 1px solid green;
    outline: none;
    background: green;
    color: white;
    font-family: 'GmarketSansMedium';
    font-size: 17px;
  }
  section input[type="button"] {
    width: 200px;
    height: 30px;
    border: 1px solid green;
    outline: none;
    background: green;
    color: white;
    font-family: 'GmarketSansMedium';
    font-size: 14px;
  }
  section div {
    margin-top: 8px;
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
</style>
</head>
<body>
  <section>
    <h3 align="center">여행 후기 등록</h3>
    <form id="reviewForm" action="writeOk" method="post" enctype="multipart/form-data">
      <div>
        <input type="text" name="title" placeholder="제목">
      </div>
      <div>
        <textarea name="content" placeholder="후기 내용"></textarea>
      </div>
      <div>
        <input type="button" value="추가" onclick="addFileInput();">
        <input type="file" id="fileInputTemplate" style="display:none;" onchange="previewImage(event)">
      </div>
      <div id="imagePreviewContainer"></div>
      <div>
        <input type="submit" value="등록">
      </div>
    </form>
  </section>

  <script>
    let fileInputCounter = 0;

    function addFileInput() {
      const newFileInput = document.createElement('input');
      newFileInput.type = 'file';
      newFileInput.name = 'fname' + (fileInputCounter + 1);
      newFileInput.style.display = 'none';
      newFileInput.onchange = previewImage;
      document.getElementById('imagePreviewContainer').appendChild(newFileInput);
      newFileInput.click();
    }

    function previewImage(event) {
      const file = event.target.files[0];
      if (file) {
        fileInputCounter++;
        const reader = new FileReader();
        reader.onload = function(e) {
          const imageContainer = document.createElement('div');
          imageContainer.className = 'thumbnail-container';
          
          const image = document.createElement('img');
          image.src = e.target.result;
          image.className = 'thumbnail';
          
          const deleteButton = document.createElement('button');
          deleteButton.innerHTML = 'X';
          deleteButton.className = 'delete-btn';
          deleteButton.onclick = function() {
            imageContainer.remove();
          };
          
          imageContainer.appendChild(image);
          imageContainer.appendChild(deleteButton);

          // Append the image container to the preview area
          document.getElementById('imagePreviewContainer').appendChild(imageContainer);
        };
        reader.readAsDataURL(file);
      }
    }
  </script>
</body>
</html>
