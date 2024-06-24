<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 상세 보기</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
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

table {
    margin: 0 auto; /* 가운데 정렬 */
    border-collapse: collapse; /* 테이블 간격 없애기 */
    width: 70%; /* 테이블 너비 지정 */
    max-width: 800px; /* 최대 너비 지정 */
    background-color: #ffffff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    border-radius: 8px; /* 모서리 둥글게 */
}

table th, table td {
    padding: 15px; /* 셀 안 여백 */
    text-align: left; /* 텍스트 왼쪽 정렬 */
    border-bottom: 1px solid #f0f0f0; /* 셀 아래 테두리 */
}

table th {
    background-color: #6076E8; /* 헤더 배경색 */
    color: white; /* 헤더 글자색 */
}

.subject, .content {
    width: calc(100% - 30px); /* 너비 100%로 채우기 */
    padding: 10px; /* 내부 여백 */
    border: 1px solid #ccc; /* 테두리 */
    border-radius: 4px; /* 모서리 둥글게 */
    box-sizing: border-box; /* 테두리와 안쪽 여백 포함 */
    font-size: 16px; /* 글자 크기 */
    resize: vertical; /* 세로 리사이즈 */
}

select {
    width: calc(100% - 30px); /* 너비 100%로 채우기 */
    padding: 10px; /* 내부 여백 */
    border: 1px solid #ccc; /* 테두리 */
    border-radius: 4px; /* 모서리 둥글게 */
    box-sizing: border-box; /* 테두리와 안쪽 여백 포함 */
    font-size: 16px; /* 글자 크기 */
}

input[type="submit"] {
    background-color: #6076E8; /* 배경색 */
    color: white; /* 글자색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 4px; /* 모서리 둥글게 */
    cursor: pointer; /* 커서 포인터 */
    font-size: 16px; /* 글자 크기 */
    transition: background-color 0.3s; /* 배경색 변경 애니메이션 */
}

input[type="submit"]:hover {
    background-color: #4056A1; /* 마우스 호버 시 배경색 변경 */
}

a {
    text-decoration: none; /* 링크 밑줄 제거 */
    color: #6076E8; /* 링크 색상 */
    font-size: 16px; /* 글자 크기 */
    transition: color 0.3s; /* 색상 변경 애니메이션 */
}

a:hover {
    color: #4056A1; /* 마우스 호버 시 링크 색상 변경 */
}

.buttons {
    display: flex;
    justify-content: space-between; /* 좌우로 공간 배분 */
    margin-top: 20px;
}

.buttons .exit a, .buttons .update button {
    background-color: #f8f9fa;
    padding: 10px 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    color: #6076E8;
    transition: background-color 0.3s, color 0.3s;
    cursor: pointer;
    font-size: 16px; /* 글자 크기 */
}

.buttons .exit a:hover, .buttons .update button:hover {
    background-color: #6076E8;
    color: white;
}

</style>
</head>
<body>

<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>

<div class="container">
    <table>
        <tr>
            <th colspan="2">
                FAQ 상세 내용 보기
            </th>
        </tr>
        <tr>
            <td>번호</td>
            <td>${dto.FAQ_no}</td>
        </tr>
        <tr>
            <td>제목</td>
            <td>${dto.FAQ_subject}</td>
        </tr>
        <tr>
            <td>카테고리</td>
            <td>${dto.FAQ_category}</td>
        </tr>
        <tr>
            <td>내용</td>
            <td>${dto.FAQ_content}</td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="buttons">
                    <div class="exit">
                        <a href="/faq/faqList.go"><i class="fas fa-arrow-left"></i> 뒤로가기</a>
                    </div>
                    <div class="update">
                        <button onclick="location.href='/faqupdate.go?faq_no=${dto.FAQ_no}'">수정</button>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</div>

</body>
</html>