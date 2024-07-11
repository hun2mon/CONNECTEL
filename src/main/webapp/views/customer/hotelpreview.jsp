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
    
    #about-us {
        padding: 40px 20px;
        background-color: #f8f9fa;
        font-family: 'Noto Serif KR', serif;
        color: #333;
    }

    #about-us h2 {
        text-align: center;
        color: #5d1212;
        font-family: 'Bodoni Moda SC', serif;
        margin-bottom: 20px;
    }

    #about-us p {
        font-size: 16px;
        line-height: 1.8;
        text-align: justify;
        margin-bottom: 20px;
    }

    #directions {
        padding: 40px 20px;
        font-family: 'Noto Serif KR', serif;
    }

    #directions h2 {
        text-align: center;
        color: #5d1212;
        font-family: 'Bodoni Moda SC', serif;
        margin-bottom: 20px;
    }

    #directions p {
        font-size: 16px;
        line-height: 1.8;
        text-align: justify;
        margin-bottom: 20px;
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
    
    <!-- 호텔 소개 -->
    <div style="width:80%; margin-left:10%; margin-right:10%;">
    
    <section id="about-us">
        <h2>호텔 소개</h2>
        <p>
            The Sheilla Hotel은 바다에서 주는 맑은공기를 느낄수 있고 넓게 펼쳐진 뷰로 정말 멋진 환경에서 휴식을 즐길 수 있는 최적의 장소입니다. 
            저희 호텔은 최고급 서비스와 현대적인 편의시설을 갖추고 있으며, 고객님들의 편안한 휴식을 위해 최선을 다하고 있습니다. 
            넓고 쾌적한 객실, 다양한 미식 요리를 즐길 수 있는 레스토랑, 최신 시설을 갖춘 피트니스 센터와 스파까지, 
            모든 면에서 최상의 만족을 드리고자 합니다. 비즈니스 여행객을 위한 고속 인터넷과 비즈니스 센터도 준비되어 있으며, 
            가족 여행객을 위한 다양한 프로그램과 키즈 클럽도 운영하고 있습니다. The Sheilla Hotel에서 특별한 경험을 만들어보세요.
        </p>
        <p>
            또한, 저희 호텔은 자연경관을 즐길 수 있는 최적의 위치에 있습니다. 여러분께 최고의 서비스와 함께, 
            한적한 공간에서 편안한 휴식을 경험할 수 있도록 최선을 다하겠습니다.
        </p>
    </section>
    
    <hr id="custom-hr">
    
    <!-- 오시는 길 -->
    <section id="directions">
        <h2>오시는 길</h2>
        <p>
            The Sheilla Hotel은 바다를 바라보는 곳에 위치하며  셔틀 버스가 운행중이기에 이동수단이 매우 편리합니다. 
           	주변에는 다양한 시설과 지역 특산물 맛집들이 있어 
            관광객들에게 최적의 위치에 있습니다. 자동차로 오시는 경우, 주변에 주차장이 마련되어 있으며 
            간단한 차량 지원도 가능합니다. The Sheilla Hotel을 찾으시는 길에 대해 궁금하신 점이나 
            추가적인 정보가 필요하시면 언제든지 저희에게 문의해 주세요. 
        </p>
        <p>
            호텔의 정확한 위치와 관련된 지도는 아래에서 확인하실 수 있습니다.
        </p>
        <!-- 지도 삽입 -->
        <div id="custom-map"></div>
        
        </div>
        
        <script>
            // Leaflet 지도 라이브러리를 이용한 호텔 위치 표시
            var map = L.map('custom-map').setView([36.072720680387306, 129.54110971926934], 16); //위도 / 경도 / 줌상태

    //지도 
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);
    
    var beachMarker = L.marker([36.072720680387306, 129.54110971926934]).addTo(map); 
    beachMarker.bindPopup("<b>The SheillaHotel</b><br>");
        </script>
    </section>
    
    <!-- 슬라이드 쇼 자바스크립트 -->
    <script>
        var slideIndex = 1;
        showSlides(slideIndex);

        function plusSlides(n) {
            showSlides(slideIndex += n);
        }

        function currentSlide(n) {
            showSlides(slideIndex = n);
        }

        function showSlides(n) {
            var i;
            var slides = document.getElementsByClassName("custom-mySlides");
            if (n > slides.length) {slideIndex = 1}    
            if (n < 1) {slideIndex = slides.length}
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";  
            }
            slides[slideIndex-1].style.display = "block";  
        }
    </script>

</body>
</html>