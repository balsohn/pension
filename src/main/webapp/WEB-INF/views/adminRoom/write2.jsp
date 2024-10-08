<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    section {
        width: 600px;
        margin: 0 auto;
        padding: 20px;
        background-color: #f9f9f9;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    section h3 {
        text-align: center;
    }
    .grid-container {
        display: grid;
        grid-template-columns: 1fr;
        gap: 10px;
    }
    .file-container {
        display: grid;
        grid-template-columns: 1fr auto;
        gap: 10px;
        align-items: center;
    }
    .file-label {
        cursor: pointer;
        color: #007bff;
        text-decoration: underline;
    }
    .file-container img {
        max-width: 100px;
        max-height: 100px;
    }
    .button-group {
        text-align: center;
    }
</style>
<script>
    function add() {
        var n = document.getElementsByClassName("file").length;

        var fileContainer = document.createElement("div");
        fileContainer.className = "file-container";

        var fileDiv = document.createElement("div");
        var add = document.createElement("input");
        add.type = "file";
        add.name = "fname" + n;
        add.className = "file";
        add.id = "file" + n;
        add.onchange = function() { myniView(this, n); };

        var fileLabel = document.createElement("label");
        fileLabel.className = "file-label";
        fileLabel.appendChild(document.createTextNode("파일선택"));
        fileLabel.htmlFor = add.id;

        fileDiv.appendChild(fileLabel);
        fileDiv.appendChild(add);

        var previewDiv = document.createElement("div");
        previewDiv.id = "preview" + n;
        previewDiv.className = "preview";

        var delDiv = document.createElement("div");
        var del = document.createElement("input");
        del.type = "button";
        del.value = "삭제";
        del.onclick = function() { delFile(fileContainer); };
        delDiv.appendChild(del);

        fileContainer.appendChild(fileDiv);
        fileContainer.appendChild(previewDiv);
        fileContainer.appendChild(delDiv);

        document.getElementById("aa").appendChild(fileContainer);
    }

    function delFile(element) {
        document.getElementById("aa").removeChild(element);
    }

    function myniView(my, imgIndex) {
        var reader = new FileReader();
        reader.onload = function(event) {
            var img = document.createElement("img");
            img.src = event.target.result;
            document.getElementById("preview" + imgIndex).innerHTML = "";
            document.getElementById("preview" + imgIndex).appendChild(img);
        };
        reader.readAsDataURL(my.files[0]);
    }
</script>
</head>
<body>
    <section>
        <h3>여행 후기 등록</h3>
        <div class="grid-container">
        	<div> 제 목 </div>
            <div> <input type="text" name="title" placeholder="제 목"> </div>
            <div> 내 용 </div>
            <div> <textarea name="content" placeholder="후기 내용"></textarea> </div>
            <div id="aa">
                <div><input type="button" onclick="add()" value="사진 추가"><hr></div>
            </div>
            <div class="button-group">
                <input type="submit" value="후기등록">
            </div>
        </div>
    </section>
</body>
</html>
