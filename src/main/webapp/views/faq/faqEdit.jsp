<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 수정</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
/* 기존 스타일 유지 */
body {
    display: flex;
    margin: 0;
    height: 100vh;
    font-family: Arial, sans-serif;
    background-color: #f8f9fa;
}

.sidebar-container {
    flex-shrink: 0;
    width: 250px;
    background-color: #f8f9fa;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    overflow-y: auto;
}

.container {
    flex-grow: 1;
    padding: 20px;
    overflow-y: auto;
    margin-top: 100px;
    text-align: left;
}

form {
    width: 70%; /* 폼 너비 지정 */
    max-width: 800px; /* 최대 너비 지정 */
    margin: 0 auto; /* 가운데 정렬 */
    background-color: #ffffff;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    border-radius: 8px; /* 모서리 둥글게 */
}

form .form-group {
    margin-bottom: 20px;
}

form .form-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}

form .form-group input, form .form-group textarea, form .form-group select {
    width: calc(100% - 20px); /* 너비 100%로 채우기 */
    padding: 10px; /* 내부 여백 */
    border: 1px solid #ccc; /* 테두리 */
    border-radius: 4px; /* 모서리 둥글게 */
    box-sizing: border-box; /* 테두리와 안쪽 여백 포함 */
    font-size: 16px; /* 글자 크기 */
}

form .form-group textarea {
    resize: vertical; /* 세로 리사이즈 */
}

form .form-actions {
    display: flex;
    justify-content: space-between;
}

form .form-actions button {
    background-color: #6076E8; /* 배경색 */
    color: white; /* 글자색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 4px; /* 모서리 둥글게 */
    cursor: pointer; /* 커서 포인터 */
    font-size: 16px; /* 글자 크기 */
    transition: background-color 0.3s; /* 배경색 변경 애니메이션 */
}

form .form-actions button:hover {
    background-color: #4056A1; /* 마우스 호버 시 배경색 변경 */
}
</style>
</head>
<body>

<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>

<div class="container">
    <form action="/faq/update.do" method="post">
        <div class="form-group">
            <label for="FAQ_no">번호</label>
            <input type="text" id="FAQ_no" name="FAQ_no" value="${dto.FAQ_no}" readonly>
        </div>
        <div class="form-group">
            <label for="FAQ_subject">제목</label>
            <input type="text" id="FAQ_subject" name="FAQ_subject" value="${dto.FAQ_subject}">
        </div>
        <div class="form-group">
            <label for="FAQ_category">카테고리</label>
            <select id="FAQ_category" name="FAQ_category">
                <option value="객실" ${dto.FAQ_category eq '객실' ? 'selected' : ''}>객실</option>
                <option value="예약 및 환불" ${dto.FAQ_category eq '예약 및 환불' ? 'selected' : ''}>예약 및 환불</option>
                <option value="부대시설" ${dto.FAQ_category eq '부대시설' ? 'selected' : ''}>부대시설</option>
                <option value="기타" ${dto.FAQ_category eq '기타' ? 'selected' : ''}>기타</option>
            </select>
        </div>
        <div class="form-group">
            <label for="FAQ_content">내용</label>
            <textarea id="FAQ_content" name="FAQ_content" rows="10">${dto.FAQ_content}</textarea>
        </div>
        <input type="hidden" name="updater" value="${sessionScope.loginInfo.emp_no}">
        <div class="form-actions">
            <button type="submit">저장</button>
            <button type="button" onclick="location.href='/faq/faqList.go'">취소</button>
        </div>
    </form>
</div>

</body>
</html>