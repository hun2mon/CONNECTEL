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
<style>
    /* 커스텀 CSS를 별도의 id로 적용하여 Bootstrap과 충돌을 방지합니다 */
    #custom-body {
        margin: 0;
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        padding: 0;
    }

    #custom-h1 {
        font-size: 32px;
        margin: 0;
        display: inline-block;
        white-space: nowrap; /* 줄 바꿈 방지 */
    }

    #custom-main1 h2 {
        text-align: center;
        color: gray;
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
    font-size: 15px;
    margin-left: -480px;
    color: gray;
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
    	width: 400px;
        height: 300px;
        margin: 20px;
    }
    .custom-map{
    	text-align:right;
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
    <h2>The Sheilla Hotel에 오신 것을 환영합니다.</h2>
    </div>
    <hr id="custom-hr">
    <div style="display: flex; padding: 20px; text-align: right;">
        <a href="/customer/reservation.go">예약하러가기.</a>
        
        
        <div style="flex: 1;">
            <p id="custom-p">
                저희 'The Sheilla Hotel'은 편안함과 우아함이 만나는 곳입니다.<br>
                도심의 중심에 위치하고 있어 최고의 편의 시설과 서비스를 제공합니다.<br> 
                비즈니스 또는 레저 여행에 따라 여러분의 체류를 더욱 특별하고 즐거운<br>
                경험으로 만들어 드립니다.
            </p>
            <p id="custom-p">
                저희 호텔에서는 고객님의 다양한 요구를 충족시킬 수 있는 다양한 객실 옵션을<br>
                제공하고 있습니다. 또한, 레스토랑과 바에서의 다채로운 식사 메뉴와 음료를 즐길 수 있는<br>
                기회를 제공합니다. 편안한 휴식을 즐기고 싶은 고객님들께 최고의 서비스를 약속드립니다.
            </p>
        </div>
        <div style="flex: 1; padding-left: 20px;">
            <img src="/client_image/food1.jpg" style="width: 802px; height: 400px; box-shadow: 0px 5px 5px rgba(0, 0, 0, 0.5);" alt="The Seilla Hotel">
        </div>
    </div>
    
    <div style="display: flex; padding: 20px; text-align: left;">
        <div style="flex: 1; padding-left: 20px;">
            <img src="/client_image/foodzone.jpg" style="width: 700px; height: auto;" alt="The Seilla Hotel">
        </div>
        <div style="flex: 1;">
            <p id="custom-p">
               저희 'The Sheilla' 호텔은 편안함과 우아함이 만나는 곳입니다.<br>
               도심의 중심에 위치하고 있어 최고의 편의 시설과 서비스를 제공합니다.<br> 
               비즈니스 또는 레저 여행에 따라 여러분의 체류를 더욱 특별하고 즐거운<br>
               경험으로 만들어 드립니다.
            </p>
            <p id="custom-p">
               저희 호텔에서는 고객님의 다양한 요구를 충족시킬 수 있는 다양한 객실 옵션을<br>
               제공하고 있습니다. 또한, 레스토랑과 바에서의 다채로운 식사 메뉴와 음료를<br>
               즐길 수 있는 기회를 제공합니다. 편안한 휴식을 즐기고 싶은 고객님들께<br>
               최고의 서비스를 약속드립니다.
            </p>
        </div>
    </div>  
    
    <!-- 지도를 표시할 div -->
    <div id="custom-map"></div>
    
    <hr id="custom-hr">

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