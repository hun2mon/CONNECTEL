<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<style>
    body {
        margin: 0;
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        padding: 0;
    }
    .reserve1 {
        background-color: #CEE3F6;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        margin: 20px auto;
        width: 80%;
        max-width: 1000px;
    }
    .reserve1 td {
        padding: 10px;
        font-size: 16px;
        color: #333;
    }
    .reserve1 input[type="date"], .reserve1 input[type="number"] {
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
        width: 90%;
        box-sizing: border-box;
    }
    .reserve1 input[type="submit"] {
        padding: 10px 20px;
        font-size: 16px;
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    }
    .reserve1 input[type="submit"]:hover {
        background-color: #0056b3;
    }
    .reserve1 tr:first-child td {
        font-weight: bold;
        color: #666;
    }
    .reserve1 tr:last-child td {
        font-size: 14px;
        color: #666;
    }
    .booking-info {
     white-space: nowrap; /* 텍스트가 너무 길어지면 줄 바꿈 방지 */
        font-size: 14px;
        color: #666;
        text-align: center;
    }
</style>
</head>
<body>
    <!-- 상단 헤더 -->
    <%@ include file="topheader.jsp" %>
    <!-- 메인 -->
    <hr style="margin-top:20px; width:80%;">
    <table width="60%" align="center" class="reserve1">
        <tr align="center" style="color:#a0a0a0; font-weight:bold;">
            <td>체크인</td>
            <td>체크아웃</td>
            <td width="5%" class="booking-info">박</td>
            <td width="10%">성인</td>
            <td width="10%">어린이</td>
        </tr>
        <tr align="center">
            <td><input type="date" id="checkin" name="r_checkin" onchange="setMinCheckoutDate()" /></td>
            <td><input type="date" id="checkout" name="r_checkout" onchange="calculateNights()" /></td>
            <td id="nights" class="booking-info"></td>
            <td><input type="number" name="r_adults" min="1" value="1"/></td>
            <td><input type="number" name="r_kids" value="0" min="0" /></td>
            <td><input type="submit" value="검색" id="btn" onclick="return reservationCheck()"/></td>
        </tr>
        <tr align="center">
            <td colspan="6">예약을 원하는 날짜, 인원을 선택해주세요</td>
        </tr>
    </table>
</body>
<script>
	//체크인 날짜
    function setMinCheckinDate() {
        var today = new Date();
        var yyyy = today.getFullYear();
        var mm = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
        var dd = String(today.getDate()).padStart(2, '0');
        var todayStr = yyyy + '-' + mm + '-' + dd;

        document.getElementById('checkin').setAttribute('min', todayStr);
        document.getElementById('checkin').value = todayStr; // 오늘 날짜로 기본 설정

        setMinCheckoutDate(); // 체크인 날짜 설정 후 체크아웃 날짜도 설정
    }

	// 체크아웃날짜
    function setMinCheckoutDate() {
        var checkinDate = new Date(document.getElementById('checkin').value);
        var nextDay = new Date(checkinDate);
        nextDay.setDate(checkinDate.getDate() + 1);

        var yyyy = nextDay.getFullYear();
        var mm = String(nextDay.getMonth() + 1).padStart(2, '0');
        var dd = String(nextDay.getDate()).padStart(2, '0');
        var nextDayStr = yyyy + '-' + mm + '-' + dd;

        document.getElementById('checkout').setAttribute('min', nextDayStr);
        document.getElementById('checkout').value = nextDayStr; // 체크아웃 날짜를 체크인 다음 날짜로 설정

        calculateNights(); // 박수 계산
    }
	
	//박수계산
    function calculateNights() {
        var checkinDate = new Date(document.getElementById('checkin').value);
        var checkoutDate = new Date(document.getElementById('checkout').value);

        var timeDiff = checkoutDate.getTime() - checkinDate.getTime();
        var nights = Math.ceil(timeDiff / (1000 * 3600 * 24));

        document.getElementById('nights').innerHTML = nights + '박 '; // 박수 표시
    }

    function reservationCheck() {
      
        return true;
    }

    window.onload = setMinCheckinDate;
</script>
</html>