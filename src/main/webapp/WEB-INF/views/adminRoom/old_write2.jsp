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
                <div><input type="button" onclick="add()" value="사진 추가"><hr></div>
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
