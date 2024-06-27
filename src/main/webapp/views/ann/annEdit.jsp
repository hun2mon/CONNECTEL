<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ann 수정</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
body {
    display: flex;
    margin: 0;
    height: 100vh;
    font-family: 'Arial', sans-serif;
    background-color: #f8f9fa;
}

.sidebar-container {
    flex-shrink: 0;
    width: 250px;
    background-color: #f8f9fa;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    overflow-y: auto;
}

.edit-container {
    flex-grow: 1;
    overflow-y: auto;
    margin-top: 100px;
    text-align: right;
    padding: 20px;
}

form {
    width: 100%;
    margin: 0 auto;
    background-color: #ffffff;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

form .form-group {
    margin-bottom: 20px;
}

form .form-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
    text-align: left;
}

form .form-group input, form .form-group textarea, form .form-group select {
    width: calc(100% - 20px);
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    font-size: 16px;
}

form .form-group textarea {
    resize: vertical;
}

form .form-actions {
    display: flex;
    justify-content: space-between;
}

form .form-actions button {
    background-color: #6076E8;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s;
}

form .form-actions button:hover {
    background-color: #4056A1;
}

form .form-group img {
    max-width: 100%;
    height: auto;
    margin-bottom: 10px;
}

.form-group.img-left {
    text-align: left;
}
</style>
</head>
<body>

<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>

<div class="edit-container">
    <form action="/ann/annupdate.do" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="ann_no">번호</label>
            <input type="text" id="ann_no" name="ann_no" value="${dto.register}" readonly>
        </div>
        <div class="form-group">
            <label for="ann_subject">제목</label>
            <input type="text" id="ann_subject" name="ann_subject" value="${dto.ann_subject}">
        </div>
        <div class="form-group">
            <label for="ann_content">내용</label>
            <textarea id="ann_content" name="ann_content" rows="10">${dto.ann_content}</textarea>
        </div>
        <div class="form-group img-left">
            <label for="ann_photo">기존 사진</label>
            <img src="/photo/${photo}" alt="첨부 이미지" style= "max-width:800px;">
        </div>
        <div class="form-group">
            <label for="ann_photo">새 사진 업로드</label>
            <input type="file" id="ann_photo" name="ann_photo">
        </div>
        <div class="form-actions">
            <button type="submit">저장</button>
            <button type="button" onclick="location.href='/ann/annList.go'">취소</button>
        </div>
    </form>
</div>

</body>
</html>