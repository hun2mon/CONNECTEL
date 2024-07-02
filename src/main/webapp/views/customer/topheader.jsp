<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<style>
/* custom-header 섹션 내의 스타일 */
.custom-header .client-header {
    background: linear-gradient(to right, #0B3861, #5E94B1) !important;
    color: #fff !important;
    padding: 20px 50px !important;
    display: flex !important;
    justify-content: space-between !important;
    align-items: center !important;
    box-shadow: 0px 5px 5px rgba(0, 0, 0, 0.5) !important;
    white-space: nowrap !important; /* 줄 바꿈 방지 */
    height: 100px;
}

.custom-header .client-nav-left, .custom-header .client-nav-right {
    display: flex !important;
    gap: 30px !important; /* 링크 간격 설정 */
}

.custom-header .client-nav-left a, .custom-header .client-nav-right a {
    color: #fff !important;
    text-decoration: none !important;
    font-size: 16px !important;
    padding: 10px 15px !important;
    border-radius: 5px !important;
    transition: background-color 0.3s ease !important; /* 배경색 변화 효과 */
}

.custom-header .client-nav-left a:hover, .custom-header .client-nav-right a:hover {
    background-color: rgba(255, 255, 255, 0.2) !important; /* 호버 시 배경색 */
}

.custom-header .client-title-container {
    text-align: center !important;
}

.custom-header .client-title-container h1 a {
    color: inherit;
    text-decoration: none;
    font-size: 26px;
}

.custom-header .client-sub-heading {
    margin-left: 120px !important;
    margin-top: -20px !important;
    color: #eee !important;
    font-size: 13px !important;
}
</style>
</head>
<body>
<section class="custom-header">
    <div class="client-header">
        <!-- 좌측 링크 -->
        <div class="client-nav-left">
            <a href="<c:url value='/customer/reservation.go'/>">예약</a>
            <a href="<c:url value='/customer/myreservation.go'/>">예약조회</a>
        </div>
        <!-- 타이틀 및 서브 타이틀 -->
        <div class="client-title-container">
            <h1><a href="/customer/customermain.go">The Sheilla Hotel</a></h1>
            <div class="client-sub-heading">최고의 서비스, 안락한 휴식을 즐겨보세요.</div>
        </div>
        <!-- 우측 링크 -->
        <div class="client-nav-right">
            <a href="<c:url value='/customer/faq.go'/>">FAQ</a>
            <a href="<c:url value='/customer/notice.go'/>">공지사항</a>
        </div>
    </div>
</section>
</body>
</html>