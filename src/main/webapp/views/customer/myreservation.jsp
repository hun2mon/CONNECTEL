<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최고의 호텔 'The Shilla' 호텔에 오신걸 환영합니다!</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }

    h2 {
        margin-bottom: -1px;
        color: gray;
        text-align: center;
        white-space: nowrap; /* 줄 바꿈 방지 */
    }
    hr {
        white-space: nowrap; /* 줄 바꿈 방지 */
    }
    .search {
        border: 1px solid black;
        padding-top: 10px;
        padding-bottom: 10px;
        margin-left: 30%;
        margin-right: 30%;
        background-color: gray;
        text-align: center;
    }
    button {
        background-color: steelblue;
        border: solid 1px black;
        color: white;
        padding: 5px 10px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 12px;
        cursor: pointer;
        border-radius: 5px;
        /* border: none; */
        transition: background-color 0.3s ease;
    }

    button:hover {
        background-color: #45a049; /* 마우스 오버 시 배경색 변화 */
    }
    
    #searchInput {
        width: 300px; /* input 요소의 길이를 300px로 설정 */
        padding-top: 2px;
        padding-bottom: 2px;
        margin-right: 10px;
    }
    
    
    #main-body{
    	margin-top:50px;
    	margin-left:35%;
    	margin-right:35%;
    	text-align:left;
    	font-size:20px;
    	color:gray;
    	border:1px solid black;
    	padding: 20px;
    	
    }
    
    
    #checkingdo{
     background-color: #813b0f;
    Color: white;
    padding: 8px 20px;
    border: 1px solid #ccc;
    transition: background-color 0.5s ease;
    
    }
</style>
</head>
<body>
     <%@ include file="topheader.jsp" %>
     <h2 style="margin-top:40px;">예약조회</h2>
     <hr style="width:50%;">
     
     <div id= main-body>
     <div id="info-1" style="margin-bottom:20px; width: 100%;">
         예약자 성명 <br><input style=" padding-left:5px; width:100%;"type="text" id="name"/>
     </div>
     <div id="info-2" style="margin-bottom:20px;">
         전화번호<br> <input style="padding-left:5px; width:100%;" type="text" id="phone"/>
     </div> 
  	 <div id="info-3" style="margin-bottom:20px;">
         예약번호<br> <input style="padding-left:5px; width:100%;" type="text" id="reservationNo"/>  	
  	 </div>
     </div>
     <div style="text-align:center; margin-top:30px;">
     <input type="button" value="확인" id ="checkingdo" onclick="sendReservationData()"/>
     </div>

    <script>
        function sendReservationData() {
            // 입력된 데이터 가져오기
            var name = $('#name').val();
            var phone = $('#phone').val();
            var reservationNo = $('#reservationNo').val();

            // AJAX 요청 보내기
            $.ajax({
                url: '/customer/reservationcheck.ajax',  // 서버의 엔드포인트 URL로 변경
                type: 'POST',
                dataType: 'json',
                data: {
                    name: name,
                    phone: phone,
                    reservationNo: reservationNo
                },
                success: function(response) {
                	if(response.success){
                    window.location.href = '/customer/myreservationdetail.go';
                	}else{  alert('예약 정보를 찾을 수 없습니다.');   
               	 window.location.href = '/customer/myreservation.go';}
                	
                },
                error: function(response) {
                	 alert('오류 두두등장');   
                	 window.location.href = '/customer/myreservation.go';
                }
            });
        }
    </script>
</body>
</html>