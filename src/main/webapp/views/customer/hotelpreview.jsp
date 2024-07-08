<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최고의 호텔 'Connectel' 호텔에 오신걸 환영합니다!</title>
<!-- Leaflet CSS 및 JavaScript CDN 추가 -->
<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bodoni+Moda+SC:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">

<style>
    
    #custom-body {
        margin: 0;
        background-color: #fffdf7;
        padding: 0;
        width: 100%;
    }

    #custom-h1 {
        font-size: 32px;
        margin: 0;
        display: inline-block;
        white-space: nowrap; /* 줄 바꿈 방지 */
    }

    #custom-main1 h2 {
        text-align: center;
         color: #5d1212;
        margin-top: 0px;
        margin-bottom: 15px;
        white-space: nowrap;
    }

    #custom-hr {
        margin-top: -5px;
        width: 100%;
    }

    #custom-main1 h3 {    
        text-align: center;
        margin-top: 30px;
        margin-bottom: -5px;
        font-size: 13px;
        margin-left: -200px;
         color: #5d1212;
        white-space: nowrap;
    }

    #custom-slideshow-container {
        position: relative;
        max-width: 100%; /* 부모 요소 너비에 맞추기 */
        margin: auto;
    }

    .custom-slideshow-image {
        width: 100%;
        height: 550px; /* 이미지 높이 조정 */
        object-fit: cover;
    }

    .custom-mySlides {
        height: 550px; /* 슬라이드 높이 설정 */
        display: none;
        max-width: 100%;
        justify-content: center;
        align-items: center;
        box-shadow: 0px 5px 5px rgba(0, 0, 0, 0.5);
    }

    #custom-prev, #custom-next {
        cursor: pointer;
        position: absolute;
        top: 50%;
        width: auto;
        padding: 16px;
        margin-top: -22px;
        color: white;
        font-weight: bold;
        font-size: 18px;
        transition: 0.6s ease;
        border-radius: 3px;
        user-select: none;
        background-color: rgba(0, 0, 0, 0.5);
    }

    #custom-prev {
        left: 0; /* 슬라이드쇼 컨테이너 바깥으로 버튼 배치 */
    }

    #custom-next {
        right: 0; /* 슬라이드쇼 컨테이너 바깥으로 버튼 배치 */
    }

    #custom-prev:hover, #custom-next:hover {
        background-color: rgba(0, 0, 0, 0.8);
    }

    .custom-fade {
        animation-name: fade;
        animation-duration: 1.5s;
    }

    @keyframes fade {
        from { opacity: .4 }
        to { opacity: 1 }
    }   

    #custom-p {
        margin-bottom: 20px;
        line-height: 1.6;
        font-size: 18px;
        color: #333;
        letter-spacing: 0.5px;
        white-space: nowrap;
    }

    #custom-map {
        height: 300px;
        margin: 20px;
        margin-left: 77%;
        margin-right: 3%;
        text-align: center;
    }
    
    .image-container {
        display: flex;
        justify-content: center;
        gap: 30px; /* 사진 사이 간격 */
        padding: 20px;
        margin-top: 20px; /* 위쪽 여백 추가 */
    }

    .image-item {
        text-align: center;
    }

    .image-item img {
        border-radius: 10px;
        width: 400px; /* 이미지 너비 */
        height: auto; /* 높이 자동 조정 */
    }

    .image-item p {
        margin-top: 10px;
        font-size: 18px;
        color: #333;
    }
</style>
</head>
<body id="custom-body">
    <!-- 상단 헤더 -->
    <%@ include file="topheader.jsp" %>  
    <!-- 이미지 부분 -->
    <div id="custom-slideshow-container">
        <div class="Slidesbackground">
            <div class="custom-mySlides custom-fade">
                <img src="/client_image/view.jpg" class="custom-slideshow-image">
            </div>
            <div class="custom-mySlides custom-fade">
                <img src="/client_image/maininfo.jpg" class="custom-slideshow-image">
            </div>
            <div class="custom-mySlides custom-fade">
                <img src="/client_image/plash2.jpg" class="custom-slideshow-image">
            </div>
            <div class="custom-mySlides custom-fade">
                <img src="/client_image/delux.jpg" class="custom-slideshow-image">
            </div>
            <div class="custom-mySlides custom-fade">
                <img src="/client_image/superier.jpg" class="custom-slideshow-image">
            </div>
            <div class="custom-mySlides custom-fade">
                <img src="/client_image/food1.jpg" class="custom-slideshow-image">
            </div>
        </div>
        <!-- 좌우 버튼 -->
        <a id="custom-prev" onclick="plusSlides(-1)">&#10094;</a>
        <a id="custom-next" onclick="plusSlides(1)">&#10095;</a>
    </div>

    <!-- 메인부분 -->
    <div id="custom-main1">
        <h3>최고의 서비스, 안락한 휴식</h3>
        <h2 style="font-family:Bodoni Moda SC, serif;">The Sheilla Hotel</h2>
    </div>
    
    <hr id="custom-hr">	
    <!-- 지도를 표시할 div -->
    <div id="hotelmap">
        <p style="font-size: 15px; color: #5d1212;text-align: right; font-family: 'Noto Serif KR', serif; padding-right:330px">오시는 길</p>
        <div id="custom-map" style="text-align: left;"></div>
    </div>
    <hr id="custom-hr" style="margin-top:40px;">


</body>
<script>
    var slideIndex = 1;
    var slideInterval;
    var map = L.map('custom-map').setView([36.072720680387306, 129.54110971926934], 16); //위도 / 경도 / 줌상태

    //지도 
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);
    
    var beachMarker = L.marker([36.072720680387306, 129.54110971926934]).addTo(map); 
    beachMarker.bindPopup("<b>The SheillaHotel</b><br>");
        
    showSlides(slideIndex);
    startSlideShow();

    function startSlideShow() {
        slideInterval = setInterval(function() {
            showSlides(slideIndex += 1);
        }, 5000); //페이지 인터벌 5초
    }

    function showSlides(n) {
        var i;
        var slides = document.getElementsByClassName("custom-mySlides");
        if (n > slides.length) { slideIndex = 1 }
        if (n < 1) { slideIndex = slides.length }
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slides[slideIndex - 1].style.display = "block";
    }

    function plusSlides(n) {
        clearInterval(slideInterval);
        showSlides(slideIndex += n);
        startSlideShow();
    }
</script>
</html>