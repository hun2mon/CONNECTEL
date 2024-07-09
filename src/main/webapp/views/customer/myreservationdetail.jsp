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
</style>
</head>
<body>
     <%@ include file="topheader.jsp" %>
     <h2 style="margin-top:10px;">예약정보</h2>
     <hr style="width:50%;">
     <div id="reservationview">
         예약자 성명: ${dto.cos_name}
         전화번호: ${dto.cos_phone}
         예약번호: ${dto.res_no}
         예약 날짜: ${dto.res_date}
     </div>
	
	<div>
		<button type="button" class="btn btn-secondary" data-toggle="modal"
		data-target="#centermodal" onclick="openCancelModal('${dto.cos_name}', '${dto.res_no}', '${dto.in_date}', ${dto.res_price})">예약 취소</button>                                                        
	</div>	
	
	<div class="modal fade" id="centermodal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myCenterModalLabel">예약취소</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>
                <div class="modal-body">
                    취소일 :<div id="cancel_date"></div>
                    <div id="current_date"></div>
                    <div id="minus_date"></div>
                    <div id="cancel_content"></div>
                    <div id="refund_price"></div>
                                            
                    <h5>예약을 정말 취소하시겠습니까?</h5>
                    <input type="button" onclick="reserveDelete()" value="예약 취소"/>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    
<script>
var cancelPrice = '';
var today = new Date();
today.setHours(today.getHours() + 9); 
var todayKST = today.toISOString().split('T')[0]; 

function openCancelModal(name, res_no, in_date, price) {
    console.log('예약 취소 모달 열기');
    console.log('예약자 이름: ' + name);
    console.log('예약 번호: ' + res_no);
    console.log('예약 날짜: ' + in_date);
    console.log('취소 금액: ' + price);

    $('#cancel_date').empty();
    $('#current_date').empty();
    $('#minus_date').empty();
    $('#cancel_content').empty();
    $('#refund_price').empty();

    var today = new Date();
    today.setHours(0, 0, 0, 0); // 자정으로 설정

    // 예약 날짜와 오늘 날짜를 Date 객체로 변환
    var reservationDate = new Date(in_date + 'T00:00:00');
    reservationDate.setHours(0, 0, 0, 0); // 예약 날짜를 자정으로 설정

    // Local date string을 사용하여 형식 지정
    var formattedReservationDate = reservationDate.toLocaleDateString('ko-KR', { 
        year: 'numeric', 
        month: '2-digit', 
        day: '2-digit' 
    });

    // 예약 날짜와 오늘 날짜 간의 차이 계산
    var timeDifference = reservationDate - today;
    var dayDifference = Math.floor(timeDifference / (1000 * 60 * 60 * 24));
    console.log(reservationDate + ' - ' + today);

    console.log(dayDifference);

    // 서버로 예약 날짜 차이를 전송하여 환불 퍼센트를 받아옴
    $.ajax({
        type: 'POST',
        url: '/guest/resCancelDate.ajax',
        data: {
            date: dayDifference  // 예약 취소 날짜 차이를 서버에 전송
        },
        dataType: 'json',
        success: function(data) {
            console.log(data.percent);
            $('#cancel_date').text(formattedReservationDate); // 올바른 형식의 예약 날짜를 설정
            $('#current_date').text(today.toLocaleDateString('ko-KR', { 
                year: 'numeric', 
                month: '2-digit', 
                day: '2-digit' 
            }));
            $('#minus_date').text(dayDifference + '일 전');
            $('#cancel_content').text('환불정책에 의거하여 결제 요금의 ' + data.percent + '%가 환불됩니다.');
            cancelPrice = price * (data.percent / 100);
            $('#refund_price').text(cancelPrice + '원');   
        },
        error: function(e) {
            console.log(e);
        }
    });

    // 예약 번호를 sessionStorage에 저장
    sessionStorage.setItem('reservationNo', res_no);
}

// 예약 취소 요청 처리
function reserveDelete() {
    var res_no = sessionStorage.getItem('reservationNo');
    console.log('취소할 예약 번호: ' + res_no);
    console.log('환불할 금액: ' + cancelPrice);
    
    $.ajax({
        type: 'POST',
        url: '/guest/reserveCancel.ajax',
        data: {
            res_no: res_no,
            cancelPrice: cancelPrice 
        },
        dataType: 'json',
        success: function(res) {            	      
            console.log(res);
            alert("취소하였습니다.");
        },
        error: function(e) {
            console.log(e);
            alert("오류");
        }
    });  
}
</script>
</body>
</html>