<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bodoni+Moda+SC:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&display=swap" rel="stylesheet">
<style>
/* #custom-header 섹션 내의 스타일 */
#custom-header {
    background: linear-gradient(to right,  #ffe8bb, #fee28c) !important;
    color: #7d3e00 !important;
    padding: 20px 50px !important;
    display: flex !important;
    justify-content: space-between !important;
    align-items: center !important;
    box-shadow: 0px 5px 5px rgba(0, 0, 0, 0.5) !important;
    white-space: nowrap !important; /* 줄 바꿈 방지 */
    height: 150px;
}

.bodoni-moda-sc-<uniquifier> {
  font-family: "Bodoni Moda SC", serif;
  font-optical-sizing: auto;
  font-weight: <weight>;
  font-style: normal;
}

#custom-nav-left, #custom-nav-right {
    display: flex !important;
    gap: 50px !important; /* 링크 간격 설정 */
}

#custom-nav-left a, #custom-nav-right a {
    color: ##7d3e00 !important;
    text-decoration: none !important;
    font-size: 16px !important;
    padding: 10px 15px !important;
    border-radius: 5px !important;
    transition: background-color 0.3s ease !important; /* 배경색 변화 효과 */
}

#custom-nav-left a:hover, #custom-nav-right a:hover {
    background-color: rgba(255, 255, 255, 0.2) !important; /* 호버 시 배경색 */
}

#custom-title-container {
    text-align: center !important;
}

#custom-title-container h1 a {
    color: #7d3e00;
    text-decoration: none;
    font-size: 26px;
    font-family: "Bodoni Moda SC", serif;
  font-optical-sizing: auto;
  font-weight: <weight>;
  font-style: normal;
}

#custom-sub-heading {
    margin-top: -17px !important;
    color: #7d3e00 !important;
    font-size: 13px !important;
   	margin-left: 150px;
   	font-style: bold;
}
</style>
</head>
<body>
<section id="custom-header">
    <div id="custom-nav-left" style="margin-left:10%;">
        <a href="<c:url value='/customer/reservation.go'/>" style="color:#7d3e00;">예약</a>
        <a href="<c:url value='/customer/myreservation.go'/>"style="color:#7d3e00;">예약조회</a>
    </div>
    <div id="custom-title-container">
        <h1><a href="/customer/customermain.go">The Sheilla Hotel</a></h1>
        <div id="custom-sub-heading">최고의 서비스, 안락한 휴식을 즐겨보세요.</div>
    </div>
    <div id="custom-nav-right"style="margin-right:10%;">
        <a href="<c:url value='/customer/faq.go'/>"style="color:#7d3e00;">FAQ</a>
        <a href="<c:url value='/customer/notice.go'/>"style="color:#7d3e00;">공지사항</a>
    </div>
</section>
</body>
</html>