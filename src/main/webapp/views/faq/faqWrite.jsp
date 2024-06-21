<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 글쓰기</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
body {
    display: flex;
    margin: 0;
    height: 100vh;
}

.sidebar-container {
    flex-shrink: 0;
    width: 250px;
    background-color: #f8f9fa;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    overflow-y: auto;
}

table {
    flex-grow: 1;
    padding: 20px;
    overflow-y: auto;
    margin-top: 100px; 
    text-align: center;
    white-space: nowrap;
}

</style>
</head>
<body>

<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>


<form id="faqForm" action="/faqwrite.do" method="post">
<table>
    <tr>
        <td><a href="faq/faqList.go">뒤로가기</a></td>
    </tr>
    <tr>
        <th>
            <input type="text" class="subject" id="subject" name="subject" placeholder="제목을 입력해주세요." required>
        </th>
        <td>
            <select id="category" name="category">
                <option value="객실">객실</option>   
                <option value="예약 및 환불">예약 및 환불</option>   
                <option value="부대시설">부대시설</option>   
                <option value="기타">기타</option>   
            </select>
        </td>
    </tr>
    <tr>
        <td>
            <textarea class="content" id="content" name="content" placeholder="내용을 입력해 주세요" required></textarea>
        </td>
    </tr>
    <tr>
        <td>
            <input type="submit" value="등록"> 
        </td>
    </tr>
</table>
</form>

</body>
<script>
</script>
</html>