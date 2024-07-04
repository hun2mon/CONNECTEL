<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f9f9f9;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        h2 {
            color: #007BFF;
        }
        .info-item {
            margin-bottom: 10px;
        }
        .info-label {
            font-weight: bold;
            color: #333;
        }
        .info-value {
            margin-left: 10px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>예약 정보</h2>
        <div class="info-item">
            <span class="info-label">객실 종류:</span>
            <span class="info-value" id="roomType"></span>
        </div>
        <div class="info-item">
            <span class="info-label">체크인 날짜:</span>
            <span class="info-value" id="checkinDate"></span>
        </div>
        <div class="info-item">
            <span class="info-label">체크아웃 날짜:</span>
            <span class="info-value" id="checkoutDate"></span>
        </div>
        <div class="info-item">
            <span class="info-label">총 가격:</span>
            <span class="info-value" id="price"></span>
        </div>
        <!-- 여기에 추가적인 결제 처리 폼이나 로직을 추가할 수 있습니다 -->
    </div>

    <script>
        // sessionStorage에서 예약 정보를 가져옵니다
        var roomType = sessionStorage.getItem('roomType');
        var checkinDate = sessionStorage.getItem('checkinDate');
        var checkoutDate = sessionStorage.getItem('checkoutDate');
        var price = sessionStorage.getItem('price');

        
        // 페이지에 예약 정보를 표시합니다
        document.getElementById('roomType').innerText = roomType;
        document.getElementById('checkinDate').innerText = checkinDate;
        document.getElementById('checkoutDate').innerText = checkoutDate;
        document.getElementById('price').innerText = price
        ;
    </script>
</body>
</html>