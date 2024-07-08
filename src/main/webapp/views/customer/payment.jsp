<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 시스템</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    padding: 0;
}
.pay-container {
    display: flex;
    justify-content: space-between;
    padding: 20px;
    width: 90%;
    margin-left:3.5%;
}
.info-section {
    flex: 1;
    padding: 20px;
    box-sizing: border-box;
}
.info-section:not(:last-child) {
    margin-right: 20px;
}
</style>
</head>
<body>
    <!-- 상단 헤더 -->
    <%@ include file="topheader.jsp" %>
    <!-- 메인 -->
    <h2 style="margin-top:40px; text-align:center; color:midnightblue;">결제 요청</h2>
    <hr style="margin-top:20px; width:80%;">

    <div class="pay-container">
        <!-- 왼쪽 섹션 -->
        <div class="info-section" >
            <div style="text-align:center; font-size:20px;">방 예약 정보</div>
            <hr>
            <div class="info-value"><img id="image" style="width:100%; height: auto;" alt="객실 이미지"></div>
            <hr>            
            <div class="info-value" id="roomType" style= "text-align:center; font-size:20px; color: midnightblue "></div><br>
            <div class="info-label" style="text-align:center;"><span class="info-value" id="room_view"></span> | <span class="info-value" id="room_bed"></span> | 최대인원: <span class="info-value" id="capacity"></span></div><br>
            
        </div>

        <!-- 중앙 섹션 -->
        <div class="info-section text-center">
            <div style="text-align:center">결제 예약 정보</div>
            <hr>
            <div class="info-label">체크인 날짜: <span class="info-value" id="checkinDate"></span></div>
            <div class="info-label">체크아웃 날짜: <span class="info-value" id="checkoutDate"></span></div>
            <div class="info-label" style="text-align:right;">총 결제가격: <span class="info-value" id="price"></span></div>
            <br><br><br><br><br>
            <div style="text-align:center;">체크인 고객정보</div>
            <hr>
            <form id="reservationForm">
                <div style="text-align:left;">
                    예약자 성명<br><input style="width:250px;" type="text" id="reserve_name"><br>
                    전화번호<br><input type="text" style="width:250px;" id="reserve_phone"><br>
                    이메일<br><input type="text" style="width:250px;" id="reserve_email"> <button type="button" onclick="requestEmail()">이메일 인증</button><br>
                    인증코드<br><input type="text" style="width:250px;" id="reserve_confirm"> <button type="button" onclick="confirmEmail()">확인</button>
                </div>
            </form>
        </div>

        <!-- 오른쪽 섹션 -->
        <div class="info-section text-right">
            <div class="info-label" style="text-align:center;">개인정보 이용약관</div>
            <hr>
            <div id="check" style="text-align:left;"><span id="currentDateTime"></span>(숙박시설의 현지시간을 기준)후에 취소 또는 예약을 변경하거 노쇼의 경 첫 1박 요금과 세금 및 수수료에 해당하는 숙박 시설 수수료가 부과됩니다.</div>
            <br>
            <div id="agreecheck" style="text-align:left;">
                <input type="checkbox" id="allcheck" onclick="checkAllAgreements()">  모든 약관에 동의합니다. <br><br><br>
                <input type="checkbox" id="1check" onclick="updateSubmitButtonStatus()" disabled> 예약하는 본인은 만 18세 이상이며 이용약관, 규정 및 제한사항 등의 모든 권고사항을 읽었으며, 모든부분에 동의합니다.<br><br><br>
                <input type="checkbox" id="2check" onclick="updateSubmitButtonStatus()" disabled> 개인정보수집은 개인정보 보호정책에 따라 사용됨을 동의합니다.<br><br><br>
                <input type="checkbox" id="3check" onclick="updateSubmitButtonStatus()" disabled> 당사는 개인정보 수집 및 이용 목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 관련 법령에 따라 보관해야 하는 경우는 예외로 합니다.<br><br>
                
                <button type="button" class="btn btn-primary" onclick="submitReservation()" disabled>최종결제</button>
            </div>
        </div>
    </div>

    <script>
    // 페이지 로드 시 예약 정보와 현재 날짜 및 시간 표시
    window.onload = function() {
        // 예약 정보 표시
        var roomType = sessionStorage.getItem('roomType');
        var checkinDate = sessionStorage.getItem('checkinDate');
        var checkoutDate = sessionStorage.getItem('checkoutDate');
        var price = sessionStorage.getItem('price');
        var room_view = sessionStorage.getItem('roomview');
        var image = sessionStorage.getItem('image');
        var capacity = sessionStorage.getItem('capacity');
        var room_bed = sessionStorage.getItem('room_bed');

		
        document.getElementById('roomType').innerText = roomType;
        document.getElementById('checkinDate').innerText = checkinDate;
        document.getElementById('checkoutDate').innerText = checkoutDate;
        document.getElementById('price').innerText = price + ' KRW';
        document.getElementById('room_view').innerText = room_view;
        document.getElementById('image').src = '/photo/' + image; // 이미지 경로 설정
        document.getElementById('capacity').innerText = capacity + '명';
        document.getElementById('room_bed').innerText = room_bed;

        // 현재 날짜 및 시간 표시
        displayCurrentDateTime();
    }

    // 현재 날짜 및 시간 표시 함수
    function displayCurrentDateTime() {
        var now = new Date();
        var year = now.getFullYear();
        var month = now.getMonth() + 1; // 월은 0부터 시작하므로 +1 필요
        var day = now.getDate();
        var hours = now.getHours();
        var minutes = now.getMinutes();
        var seconds = now.getSeconds();

        // 두 자릿수로 만들기 위해 padStart 사용
        var formattedDate = year + '년' + String(month).padStart(2, '0') + ' 월 ' + String(day).padStart(2, '0')+' 일 ';
        var formattedTime = String(hours).padStart(2, '0') + '시' + String(minutes).padStart(2, '0')+'분';
        var formattedDateTime = formattedDate + ' ' + formattedTime;

        document.getElementById('currentDateTime').innerText = formattedDateTime;
    }

    // 이메일 인증 요청
    function requestEmail() {
        var email = document.getElementById('reserve_email').value;

        if (email.trim() === '') {
            alert('이메일을 입력하세요.');
            return;
        }
        // 서버로 이메일을 전송하여 인증코드 요청
        $.ajax({
            url: '/customer/emailsend.ajax',
            method: 'POST',
            data: { 
                email: email,          	
            },
            dataType:'text',
            success: function(data) {
                alert(data);
                console.log('email +', email);
            },
            error: function(e) {
                alert('인증코드 요청 중 오류가 발생했습니다.');
                console.log('email +', email);
            }
        });
    }

    // 이메일 인증 확인
    function confirmEmail() {
        var confirm = document.getElementById('reserve_confirm').value;
        console.log(confirm);
        if (confirm.trim() === '') {
            alert('인증코드를 입력하세요.');
            return;
        }

        $.ajax({
            url: '/customer/codeconfirm.ajax',
            method: 'POST',
            data: { confirm : confirm },
            dataType:'text',
            success: function(data) {
                alert(data);
                if (data === "이메일 인증이 완료되었습니다.") {
                    // 이메일 인증 성공 시 체크박스 활성화
                    var checkboxes = document.querySelectorAll('#agreecheck input[type="checkbox"]');
                    for (var i = 1; i < checkboxes.length; i++) {
                        checkboxes[i].disabled = false;
                    }
                    updateSubmitButtonStatus();
                }
            },
            error: function(e) {
                alert('인증코드 확인 중 오류가 발생했습니다.');
            }
        });
    }
    
    // 모든 약관에 동의 체크박스 클릭 시 하위 체크박스 전체 선택
    function checkAllAgreements() {
        var allCheck = document.getElementById('allcheck');
        var checkboxes = document.querySelectorAll('#agreecheck input[type="checkbox"]');
        
        for (var i = 0; i < checkboxes.length; i++) {
            if (!checkboxes[i].disabled) {
                checkboxes[i].checked = allCheck.checked;
            }
        }

        // 전체 선택 후에도 버튼 상태 업데이트
        updateSubmitButtonStatus();
    }

    // 하위 체크박스들이 모두 체크되었는지 확인하고, 필요 시 allcheck 체크
    function updateAllCheck() {
        var allCheck = document.getElementById('allcheck'); 
        var checkboxes = document.querySelectorAll('#agreecheck input[type="checkbox"]');
        var allChecked = true;
        
        for (var i = 1; i < checkboxes.length; i++) {
            if (!checkboxes[i].checked) {
                allChecked = false;
                break;
            }
        }
        
        allCheck.checked = allChecked;
        
        // 전체 선택 후에도 버튼 상태 업데이트
        updateSubmitButtonStatus();
    }

    // 최종결제 버튼 상태 업데이트 함수
    function updateSubmitButtonStatus() {
        var allCheck = document.getElementById('allcheck');
        var checkboxes = document.querySelectorAll('#agreecheck input[type="checkbox"]');
        var submitButton = document.querySelector('.btn-primary');

        // 모든 약관에 동의 체크박스도 체크된 경우에만 버튼 활성화
        if (allCheck.checked && checkboxes[1].checked && checkboxes[2].checked && checkboxes[3].checked) {
            submitButton.disabled = false;
        } else {
            submitButton.disabled = true;
        }
    }

    // 예약 정보 유효성 검사 및 결제 요청
    function submitReservation() {
        var cos_name = document.getElementById('reserve_name').value;
        var cos_phone = document.getElementById('reserve_phone').value;
        var cos_email = document.getElementById('reserve_email').value;
        var item_name = sessionStorage.getItem('roomType');
        var checkIn = sessionStorage.getItem('checkinDate');
        var checkOut = sessionStorage.getItem('checkoutDate');
        var total_amount = sessionStorage.getItem('price');
        var submitButton = document.querySelector('.btn-primary');
        var email = document.getElementById('reserve_email').value;
        var confirm = document.getElementById('reserve_confirm').value;
        
        // 예약자 성명 유효성 검사 (빈 값인 경우)
        if (cos_name.trim() === '') {
            alert('예약자 성명을 입력하세요.');
            submitButton.disabled = true;
            return;
        }

        // 전화번호 유효성 검사 (정규 표현식 사용)
        var phonePattern = /^\d{3}-\d{3,4}-\d{4}$/; // 예시: 010-1234-5678
		 if(cos_phone.trim() ===''){
        	alert('전화번호를 입력해주세요.(예시: 010-1234-5678) ');
        	return;        
		 }else if (!phonePattern.test(cos_phone)) {
            alert('전화번호 형식이 올바르지 않습니다. (예시: 010-1234-5678)');
            return;
        }      
        
		 if (email.trim() === '') {
	            alert('이메일을 입력하세요.');
	            return;
	        }
		 
		 if(confirm.trim() ===''){
			alert('인증코드를 입력해주세요.');	
			return;
		 }
		
        if (!document.getElementById('allcheck').checked) {
            alert('모든 약관에 동의해야 합니다.');
            return;
        }

        $.ajax({
            type: 'POST',
            url: '/common/ready',
            data: {
                item_name: item_name,
                total_amount: total_amount,
                checkIn: checkIn,
                checkOut: checkOut,
                cos_email: cos_email,
                cos_name: cos_name,
                cos_phone: cos_phone,
                quantity: 1,
                tax_free_amount: 0
            },
            dataType: 'JSON',
            success: function(res) {
                console.log('결제 :' + cos_name, cos_phone, checkIn, checkOut, total_amount, item_name);
                location.href = res.next_redirect_pc_url;
            },
            error: function(e) {
                console.error("Error occurred:", e);
                alert("결제 준비 중 오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    }
    </script>
</body>
</html>