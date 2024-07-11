<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최고의 호텔 'Connectel' 호텔에 오신걸 환영합니다!</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- Leaflet CSS 및 JavaScript CDN 추가 -->
<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bodoni+Moda+SC:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">

<style>

#successButton{
	align-items:center;
	margin-left:40%;
	margin-right:40%;
	display:flex;
	justify-content: space-between;

	white-space: nowrap;
	margin-top:50px;
}

#maingo{
	background-color:#813b0f;
	Color:white;
	padding:10px 20px;
	border:1px solid #ccc;
	box-shadow: 0 0 2px rgba(0, 0, 0, 1);
}

#reservecheck{
	background-color:#813b0f;
	Color:white;
	padding:10px 20px;
	border:1px solid #ccc;
	box-shadow: 0 0 2px rgba(0, 0, 0, 1);	
}

</style>

</head>
<body id="custom-body">
    <!-- 상단 헤더 -->
    <%@ include file="topheader.jsp" %>  
    <!-- 이미지 부분 -->
    
    <!-- 메인부분 -->
    <div id="custom-main1" style="text-align:center; font-family: 'Noto Serif KR', serif; font-size:30px; margin-left:35%; margin-right:35%; margin-top:100px; white-space: nowrap;">
       호텔 예약이 완료되었습니다.
    </div>
    <div style="text-align:left; margin-top:20px; font-family: 'Noto Serif KR', serif; margin-left:33%; margin-right:33%; white-space: nowrap; font-size:18px;">
                <hr style="width:100%;">
        <div id = "text" style="margin-bottom:15px; width:100%; white-space:normal;">
        저희 The Sheilla Hotel 의 예약을 진심으로 감사드립니다!<br>
        고객님의 편안한 숙박을 위해 최선을 다하겠습니다.<br>고객님의 예약정보는 아래 예약조회를 통해 조회 하실수 있으며, 고객님의 편안한 숙박을 위해 최선을 다할 것을 약속드리겠습니다.<br>문의가 필요하신 경우는 FAQ 및 공지사항을 통하여 정보를 얻으실 수 있으며 그 외 다른 문의사항의 경우 고객센터로 전화를 주시면 신속히 처리해드리겠습니다.<br>저희 호텔에서 즐거운 시간 되시길 바랍니다.
        </div>
        <div style="text-align:right;font-family: Bodoni Moda SC, serif; ">- The Sheilla Hotel -</div>
        <hr style="width:100%;">
    </div>
   
   <div id="successButton">
       <input type="button" id="maingo" onclick="main()" value="메인페이지">
       <input type="button" id="reservecheck" onclick="myreservation()" value="예약조회">
   </div>
   
</body>
<script>
function main(){
    window.location.href = '/customer/clientmain.go';	   
}

function myreservation(){
    window.location.href = '/customer/myreservation.go';
}
</script>
</html>