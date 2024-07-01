<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<style>
.header {
    background: linear-gradient(to right, #0B3861, #5E94B1);
    color: #fff;
    padding: 20px 50px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0px 5px 5px rgba(0, 0, 0, 0.5);
    white-space: nowrap; /* 줄 바꿈 방지 */
}

.nav-left, .nav-right {
    display: flex;
    gap: 30px; /* 링크 간격 설정 */
}

.nav-left a, .nav-right a {
    color: #fff;
    text-decoration: none;
    font-size: 16px;
    padding: 10px 15px;
    border-radius: 5px;
    transition: background-color 0.3s ease; /* 배경색 변화 효과 */
}

.nav-left a:hover, .nav-right a:hover {
    background-color: rgba(255, 255, 255, 0.2); /* 호버 시 배경색 */
}

.title-container {
    text-align: center;
}

.sub-heading {
	margin-left: 100px;
	margin-top: -25px;
    color: #eee;
    font-size: 14px;
}
</style>
</head>
<body>

<div class="header">
    <!-- 좌측 링크 -->
    <div class="nav-left">
        <a href="<c:url value='/customer/reservation.go'/>">예약</a>
        <a href="<c:url value='/customer/myreservation.go'/>">예약조회</a>
    </div>
    <!-- 타이틀 및 서브 타이틀 -->
    <div class="title-container">
        <h1><a href="/customer/customermain.go" style="color: inherit; text-decoration: none;">The Sheilla Hotel</a></h1>
        <div class="sub-heading">최고의 서비스, 안락한 휴식을 즐겨보세요.</div>
    </div>
    <!-- 우측 링크 -->
    <div class="nav-right">
        <a href="<c:url value='/customer/faq.go'/>">FAQ</a>
        <a href="<c:url value='/customer/notice.go'/>">공지사항</a>
    </div>
</div>

</body>
<script>

</script>
</html>