<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최고의 호텔 'Connectel' 호텔에 오신걸 환영합니다!</title>
<!-- Leaflet CSS 및 JavaScript CDN 추가 -->
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
     <div style="width: 15%;
        margin-left: 84%;
        padding-top: 10px;
        padding-bottom: 10px;
        text-align: center;
        margin-right: 40px;
        background-color: #ffe290;
        border: 2px solid #7d3e00;
        box-shadow: 2px 3px 1px rgb(130 130 130 / 50%);">
        <a href="/customer/reservation.go" style="color: #673d05; font-size: 20px;"> 예약서비스 바로가기.</a>
    </div>
    <div style="font-size: 30px; text-align:center; margin-top:10px; color: #5d1212; font-family: 'Noto Serif KR', serif;">'The Sheilla Hotel'에서 최고의 편안함을 누려보세요.</div>
    <div style="font-size: 18px; text-align:center; margin-top:-5px; color: #5d1212; font-family: 'Noto Serif KR', serif;">Enjoy the best comfort in 'The Sheila Hotel'</div>
    <div style="flex: 1; margin-left: 5%; margin-right: 5%; font-size: 20px;">
        <div class="image-container">
            <div class="image-item">
                <img src="/client_image/standard.jpg" alt="Standard Room">
                <p>&lt;Standard Room&gt;</p>
            </div>
            <div class="image-item">
                <img src="/client_image/superier.jpg" alt="Superier Room">
                <p>&lt;Superier Room&gt;</p>
            </div>
            <div class="image-item">
                <img src="/client_image/delux.jpg" alt="Delux Room">
                <p>&lt;Delux Room&gt;</p>
            </div>
            <div class="image-item">
                <img src="/client_image/suite.jpg" alt="Suite Room">
                <p>&lt;Suite Room&gt;</p>
            </div>
        </div>
    </div>
    <hr id="custom-hr" style="width: 60%">
    <div style="font-size: 30px; text-align:center; color: #5d1212; font-family: 'Noto Serif KR', serif;">호텔의 특별한 음식들을 즐겨보세요.</div>
    <div style="font-size: 18px; text-align:center; margin-top:-5px; color: #5d1212; font-family: 'Noto Serif KR', serif;">Enjoy the special food of the hotel.</div>

    <div style="display: flex; justify-content: center; padding: 20px;">
        <div style="flex: 1; text-align: center;">
            <img src="/client_image/food1.jpg" style="width: 600px; height: auto; box-shadow: 0px 5px 5px rgba(0, 0, 0, 0.5); margin-right:50px;" alt="The Sheila Hotel Food 1">
            <img src="/client_image/food2.jpg" style="width: 600px; height: auto; box-shadow: 0px 5px 5px rgba(0, 0, 0, 0.5); margin-top: 20px;" alt="The Sheila Hotel Food 2">
        </div>
    </div>
        <div style="text-align: center;">
        	<img src="/client_image/food3.jpg" style="width: 600px; height: auto; box-shadow: 0px 5px 5px rgba(0, 0, 0, 0.5); margin-top: 20px;">
        </div>
        
        <hr id="custom-hr" style="width: 60%;margin-top:50px;">
        <div style="font-size: 30px; text-align:center; color: #5d1212; font-family: 'Noto Serif KR', serif;">멤버쉽별 등급 혜택을 누려보세요.</div>
        <div style="font-size: 18px; text-align:center; margin-top:-5px; color: #5d1212; font-family: 'Noto Serif KR', serif;">Enjoy the rating benefits for each member.</div>
        <div onclick="showAlert()" style="cursor:pointer;">
            <img src="/client_image/membership.png" style="width:900px; height: auto; margin-left:23%;">
        </div>
        
        
        
        
        
    <hr id="custom-hr" style="margin-top: 80px; margin-bottom: 10px;">
	<div id ="customer-footer" style="padding-left:20px; text-align:center;">
	<p style="font-size:28px;font-family:Bodoni Moda SC, serif; color:#a45d1d; text-align:center;">The Sheilla Hotel</p>
	<div id="1page" style="padding: 10px; padding-left:0px; padding-top: 0px; color:#ba6b6b">
    <a href="/customer/hotelpreiview.go" style="padding: 10px; padding-left:0px; margin-right: 10px; color:#ba6b6b">호텔소개</a>
    <a href="#" style="margin-right: 20px; color:#ba6b6b">개인정보처리방침</a>
    <a href="#" style="margin-right: 20px;color:#ba6b6b">이용약관</a>
    <a href="#" style="margin-right: 20px;color:#ba6b6b">SNS</a>
     <a href="#" style="margin-right: 20px;color:#ba6b6b">고객지원센터</a>
      <a href="#" style="margin-right: 20px;color:#ba6b6b">1:1문의</a>
</div>
	</div>
	<div style="margin-left:20px; font-size:14px; color:#ccc; text-align:center;">(주)The Sheilla Hotel 경상북도 포항시 남구 호미곶면 나보리 177길 대표이사: 김정훈 사업자등록번호:000-00-12312<br>
	서버호스팅제공:AWS The Sheilla 본사위치 서울특별시 관악구 관천로 292-21신라빌딩 99층 102호 전화번호:010-2424-9594<br>
	copyright&copy; 2024 The Sheilla Hotel.  All Rights Reserved. By_ParkJunmo@
	 </div>

</body>
<script>
var msg = "${msg}"; // JSP에서 가져온 변수 msg

//msg 변수가 true이면 알림창 표시
if (msg) {
 alert(msg); // 알림창에 메시지 표시
}



    var slideIndex = 1;
    var slideInterval;
   

        
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
    
    function showAlert() {
        alert("준비 중입니다.");
    }
</script>
</html>