<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reservation System</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>

.modal-title {
    margin-bottom: -2px;
    line-height: 1.5;
    color:  #8f5307;
    font-family: math;
}
.hidden {
    display: none; /* 화면에서 보이지 않음 */
}


.modal-header{
    background: linear-gradient(to left, #fae0ad, #fff6db);
    border-bottom:0px;
}

@media (min-width: 576px) {
    .modal-dialog {
        max-width: 900px;
        margin: 1.75rem auto;
    }
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    padding: 0;
}
.reserve1 {
    background-color: #ffefbe;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin: 20px auto;
    width: 80%;
    max-width: 1000px;
}
.reserve1 td {
    padding: 10px;
    font-size: 16px;
    color: #a37009;
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
   background-color: #813b0f;
    Color: white;
    padding: 8px 20px;
    border: 1px solid #ccc;
    cursor: pointer;
    transition: background-color 0.5s ease;
    border-radius: 5px;
}
.reserve1 input[type="submit"]:hover {
    background-color: #56190a;
}
.booking-info {
    white-space: nowrap; /* 텍스트가 너무 길어지면 줄 바꿈 방지 */
    font-size: 14px;
    color: #666;
    text-align: center;
}
.resTable {
    width: 100%; /* 테이블 너비 조정 */
    margin: 20px auto; /* 가운데 정렬 */
    background-color: #f9f9f9; /* 테이블 배경색 */
    border-radius: 10px; /* 테이블 모서리 둥글게 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
}
.resTable th, .resTable td {
    padding: 10px;
    font-size: 16px;
    color: #333;
    border-bottom: 1px solid #ddd; /* 테이블 선 추가 */
}
.resTable th {
    color: #813b0f; /* 테이블 머리글 배경색 */
    font-weight: bold;

}
.resTable td {
    text-align: center; /* 셀 가운데 정렬 */
}
.reserve1 td.reservation-button-cell {
    min-width: 250px; /* 예약 버튼이나 텍스트를 포함하는 <td>의 최소 너비 */
    width: 250px; /* 예약 버튼이나 텍스트를 포함하는 <td>의 너비 */
    white-space: nowrap; /* 텍스트가 너무 길어지면 줄 바꿈 방지 */
    text-align:center;

}
.reservation-button-cell{
	width:300px;

}

.reservation-button-cell button {
    background-color: #813b0f;
    Color: white;
    padding: 8px 20px;
    border: 1px solid #ccc;
    box-shadow: 0 0 2px rgba(0, 0, 0, 1);
    transition: background-color 0.5s ease;
}

.reservation-button-cell button:hover {
        background-color: #56190a; /* 호버 시 배경색 변경 */
}

.modal-body{
	padding:0px;
}


</style>
</head>
<body>
    <!-- 상단 헤더 -->
    <%@ include file="topheader.jsp" %>
    <!-- 메인 -->
    <hr style="margin-top:20px; width:80%;">
    <table width="80%" align="center" class="reserve1">
        <tr align="center" style="color:#ccc; font-weight:bold;">
            <td>체크인</td>
            <td>체크아웃</td>
            <td width="5%" class="booking-info">박</td>
            <td width="10%">성인</td>
            <td width="10%">어린이</td>
        </tr>
        <tr align="center">
            <td><input type="date" id="checkin" name="r_checkin" onchange="setMinCheckoutDate()" /></td>
            <td><input type="date" id="checkout" name="r_checkout" onchange="calculateNights()"/></td>
            <td id="nights" class="booking-info"></td>
            <td><input type="number" name="r_adults" min="1" value="1"/></td>
            <td><input type="number" name="r_kids" value="0" min="0" /></td>
            <td class="reservation-button-cell"><input type="submit" value="검색" id="btn" onclick="return reservationCheck()"/></td>
        </tr>
    </table>  
    <div class="card-body" style="text-align:center">
        <h3 id="selectDateMessage" style="color:#727070">예약을 원하시는 날짜를 선택해주세요.</h3>
        <table class="resTable" id="resTable"></table>                        
    </div>

                                        
<!-- 스탠다드 모달 -->
<div class="modal fade" id="standardmodal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myCenterModalLabel">Standard Room</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body" style="overflow-y: auto; max-height: 70vh;">
                <img id="standard_img" style="width:100%; height:500px;">
                <div id = supe-bor style="    border: 1px solid #ffc107;
    border-radius: 3px;
    margin: 5px;
    margin-top: 10px;
    margin-bottom: 10px;
    padding: 4px;
    color: #b26d0a;
}">
                [상세정보]<br><span id="standard_info"></span><br><br>
                [평수]<br><span id="standard_extent"></span><br><br>
                [기본제공용품]<br><span id="standard_amenity"></span>을 제공하고 있습니다.<br><br>
              	[뷰]<br><span id="standard_roomview"></span>가 보이는 곳입니다.
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
    
   
<!-- 슈페리얼 모달 -->    
<div class="modal fade" id="superiormodal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
		<div class="modal-header">
			<h4 class="modal-title" id="myCenterModalLabel">Superior Room</h4>
			<button type="button" class="close" data-dismiss="modal"aria-hidden="true">×</button>
		</div>
		<div class="modal-body" style="overflow-y: auto; max-height: 70vh;">
			<img id= "superior_img" style="width:100%; height:500px;">
			<div id = supe-bor style="    border: 1px solid #ffc107;
    border-radius: 3px;
    margin: 5px;
    margin-top: 10px;
    margin-bottom: 10px;
    padding: 4px;
    color: #b26d0a;
}">
			[상세정보]<br><span id="superior_info"></span><br><br>
			[평수]<br><span id="superior_extent"></span><br><br>
			[기본제공용품]<br><span id="superior_amenity"></span>을 제공하고 있습니다.<br><br>			
			[뷰]<br><span id="superior_roomview"></span>가 보이는 곳입니다.
			</div>
		</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->



<!-- 디럭스 모달 -->
<div class="modal fade" id="deluxmodal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
		<div class="modal-header">
			<h4 class="modal-title" id="myCenterModalLabel">Delux Room</h4>
			<button type="button" class="close" data-dismiss="modal"aria-hidden="true">×</button>
		</div>
		<div class="modal-body">
			<img id= "delux_img" style="width:100%; height:500px;">
			<div id = supe-bor style="    border: 1px solid #ffc107;
    border-radius: 3px;
    margin: 5px;
    margin-top: 10px;
    margin-bottom: 10px;
    padding: 4px;
    color: #b26d0a;
}">
			[상세정보]<br><span id="delux_info"></span><br><br>
			[평수]<br><span id="delux_extent"></span><br><br>
			[기본제공용품]<br><span id="delux_amenity"></span>을 제공하고 있습니다.<br><br>
			[뷰]<br><span id="delux_roomview"></span>가 보이는 곳입니다.
			</div>
		</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->



<!-- 스위트 모달 -->
<div class="modal fade" id="suitemodal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
		<div class="modal-header">
			<h4 class="modal-title" id="myCenterModalLabel">Suite Room</h4>
			<button type="button" class="close" data-dismiss="modal"aria-hidden="true">×</button>
		</div>
		<div class="modal-body">
			<img id= "suite_img" style="width:100%; height:500px;">
			<div id = supe-bor style="    border: 1px solid #ffc107;
    border-radius: 3px;
    margin: 5px;
    margin-top: 10px;
    margin-bottom: 10px;
    padding: 4px;
    color: #b26d0a;
}">
			[상세정보]<br><span id="suite_info"></span><br><br>
			[평수]<br><span id="suite_extent"></span><br><br>
			[기본제공용품]<br><span id="suite_amenity"></span>을 제공하고 있습니다.<br><br>
			[뷰]<br><span id="suite_roomview"></span>가 보이는 곳입니다.
			</div>
		</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->











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

function setMinCheckoutDate() {
    var checkinDate = new Date(document.getElementById('checkin').value);
    var nextDay = new Date(checkinDate);
    nextDay.setDate(checkinDate.getDate() + 1);

    var yyyy = nextDay.getFullYear();
    var mm = String(nextDay.getMonth() + 1).padStart(2, '0');
    var dd = String(nextDay.getDate()).padStart(2, '0');
    var nextDayStr = yyyy + '-' + mm + '-' + dd;
    console.log(nextDayStr);
    
    document.getElementById('checkout').setAttribute('min', nextDayStr);
    document.getElementById('checkout').value = nextDayStr; // 체크아웃 날짜를 체크인 다음 날짜로 설정

    calculateNights(); // 박수 계산
}

function calculateNights() {
    var checkinDate = new Date(document.getElementById('checkin').value);
    var checkoutDate = new Date(document.getElementById('checkout').value);

    var timeDiff = checkoutDate.getTime() - checkinDate.getTime();
    var nights = Math.ceil(timeDiff / (1000 * 3600 * 24));

    document.getElementById('nights').innerHTML = nights + '박 '; // 박수 표시
}

function reservationCheck() {
    $('#selectDateMessage').addClass('hidden');
    var checkInDate = document.getElementById('checkin').value;
    var checkOutDate = document.getElementById('checkout').value;

    // 체크인, 체크아웃 날짜가 유효한지 확인
    if (!checkInDate || !checkOutDate) {
        alert("체크인 및 체크아웃 날짜를 선택해주세요.");
        return false;
    }

    // 체크아웃 날짜가 체크인 날짜보다 이전인지 확인
    var checkinDateObj = new Date(checkInDate);
    var checkoutDateObj = new Date(checkOutDate);

    if (checkoutDateObj <= checkinDateObj) {
        alert("체크아웃 날짜는 체크인 날짜보다 늦어야 합니다.");
        return false;
    }
    
    listCall(checkInDate, checkOutDate);
    return false; // 폼 제출 방지
}

window.onload = setMinCheckinDate;


        function listCall(checkInDate, checkOutDate) {
            $.ajax({
                type: 'POST',
                url: '/customer/reserveListCall.ajax',
                data: {
                    in_date: checkInDate,
                    out_date: checkOutDate,
                    
                },
                dataType: 'JSON',
                success: function(data) {
                    console.log(data);
                    drawList(data, checkInDate, checkOutDate);
                    document.getElementById('selectDateMessage').classList.add('hidden'); // 검색 성공 시 메시지 숨기기
                },
                error: function(e) {
                    console.log(e);
                }
            });
        }

        function formatNumber(number) {
            return number.toLocaleString();
        }
        
        
        function forNumber(number) {
            return number.toLocaleString();
        }
        
        

        function drawList(data, checkin, checkout) {
            var roomContainer = $('#resTable');
            roomContainer.empty();
            
            $('#standard_img').attr('src', '/photo/' + data.standard_image);
            $('#standard_info').html(data.standard_detail);
            $('#standard_extent').html(data.standard_extent);
            $('#standard_amenity').html(data.standard_amenity);
            $('#standard_roomview').html(data.standard_roomview); 
            
            
            $('#superior_img').attr('src', '/photo/' + data.superior_image);
            $('#superior_info').html(data.superior_detail);
            $('#superior_extent').html(data.superior_extent);
            $('#superior_amenity').html(data.superior_amenity);
            $('#superior_roomview').html(data.superior_roomview);
            
            
            $('#delux_img').attr('src', '/photo/' + data.delux_image);
            $('#delux_info').html(data.delux_detail);
            $('#delux_extent').html(data.delux_extent);
            $('#delux_amenity').html(data.delux_amenity);
            $('#delux_roomview').html(data.delux_roomview);
            
            $('#suite_img').attr('src', '/photo/' + data.suite_image);
            $('#suite_info').html(data.suite_detail);
            $('#suite_extent').html(data.suite_extent);
            $('#suite_amenity').html(data.suite_amenity);
            $('#suite_roomview').html(data.suite_roomview);            
            
            var content = '';
            for (var item of data.resList) {
                var adults = parseInt(document.getElementsByName('r_adults')[0].value);
                var kids = parseInt(document.getElementsByName('r_kids')[0].value);
                var totalGuests = adults + kids;
                content += '<tr style="">';

                if (item.type_code === 1001) {
                    content += '<th> <img src="/photo/' + data.standard_image + '" data-toggle="modal" data-target="#standardmodal" style="width:300px; height:200px; max-width:300px; max-height:200px; cursor:pointer"></th>';
                    content += '<th style="white-space: nowrap;"> :: Standard Room ::<br>(스탠다드룸)</th>';
                    content += '<td style="white-space: nowrap;">' + item.room_view + ' | 최대인원 ' + item.room_capacity + '명 | ' + item.room_bed + '</td>';
                    content += '<td>' + formatNumber(data.minStandardPrice) + ' KRW 부터~</td>';
                    content += forNumber(data.standard);
                    
                    if (data.standard_num >= 40 || item.room_capacity < totalGuests) {
                        content += '<td style="color:gray;"> 현재 남은 객실이 없습니다.</td>';
                    } else {
                        content += '<td class="reservation-button-cell"><button onclick="reserve(\'스탠다드룸\', \'' + checkin + '\', \'' + checkout + '\', ' + data.standard + ', \'' + item.room_view + '\', \'' + data.standard_image + '\', ' + item.room_capacity + ', \'' + item.room_bed + '\')">예약</button></td>';
                    }
                } else if (item.type_code === 1002) {
                    content += '<th> <img src="/photo/' + data.superior_image + '" data-toggle="modal" data-target="#superiormodal" style="width:300px; height:200px; max-width:300px; max-height:200px;"></th>';
                    content += '<th style="white-space: nowrap;"> :: Superior Room ::<br>(슈페리얼룸)</th>';
                    content += '<td style="white-space: nowrap;">' + item.room_view + ' | 최대인원 ' + item.room_capacity + '명 | ' + item.room_bed + '</td>';
                    content += '<td>' + formatNumber(data.minSuperiorPrice) + ' KRW 부터~</td>';
                    
                    if (data.superior_num >= 20) {
                        content += '<td style="color:red;">현재 남은 객실이 없습니다</td>';
                    } else {
                        content += '<td class="reservation-button-cell"><button onclick="reserve(\'슈페리어룸\', \'' + checkin + '\', \'' + checkout + '\', ' + data.superior + ', \'' + item.room_view + '\', \'' + data.superior_image + '\', ' + item.room_capacity + ', \'' + item.room_bed + '\')">예약</button></td>';
                    }
                } else if (item.type_code === 1003) {
                    content += '<th> <img src="/photo/' + data.delux_image + '" data-toggle="modal" data-target="#deluxmodal" style="width:300px; height:200px; max-width:300px; max-height:200px;"></th>';
                    content += '<th style="white-space: nowrap;"> :: Delux Room ::<br>(디럭스룸)</th>';
                    content += '<td style="white-space: nowrap;">' + item.room_view + ' | 최대인원 ' + item.room_capacity + '명 | ' + item.room_bed + '</td>';
                    content += '<td>' + formatNumber(data.minDeluxePrice) + ' KRW 부터~</td>';
                    
                    if (data.delux_num >= 20) {
                        content += '<td style="color:red;">현재 남은 객실이 없습니다</td>';
                    } else {
                        content += '<td class="reservation-button-cell"><button onclick="reserve(\'디럭스룸\', \'' + checkin + '\', \'' + checkout + '\', ' + data.delux + ', \'' + item.room_view + '\', \'' + data.delux_image + '\', ' + item.room_capacity + ', \'' + item.room_bed + '\')">예약</button></td>';
                    }
                } else {
                    content += '<th> <img src="/photo/' + data.suite_image + '" data-toggle="modal" data-target="#suitemodal" style="width:300px; height:200px; max-width:300px; max-height:200px;"></th>';
                    content += '<th style="white-space: nowrap;">:: Suite Room :: <br>(스위트룸)</th>';
                    content += '<td style="white-space: nowrap;">' + item.room_view + ' | 최대인원 ' + item.room_capacity + '명 | ' + item.room_bed + '</td>';
                    content += '<td>' + formatNumber(data.minSuitePrice) + ' KRW 부터~</td>';
                    
                    if (data.suite_num >= 20) {
                        content += '<td style="color:red;">현재 남은 객실이 없습니다</td>';
                    } else {
                        content += '<td class="reservation-button-cell"><button onclick="reserve(\'스위트룸\', \'' + checkin + '\', \'' + checkout + '\', ' + data.suite + ', \'' + item.room_view + '\', \'' + data.suite_image + '\', ' + item.room_capacity + ', \'' + item.room_bed + '\')">예약</button></td>';
                    }
                }

                content += '</tr>';
            }
            $('#resTable').html(content);
        }
        
        
        function getKoreanDate() {
            let now = new Date();
            now.setHours(now.getHours() + 9); // UTC+9 시간대 반영
            return now.toISOString().split('T')[0];
        }

        function addDays(date, days) {
            let result = new Date(date);
            result.setDate(result.getDate() + days);
            return result.toISOString().split('T')[0];
        }


        getDate();
        function getDate() {
        	var today = getKoreanDate();
        	
            $.ajax({
                type: 'POST',
                url: "/guest/getDate.ajax",
                data: {
                	today:today      	
                },
                dataType: 'JSON',
                success: function(response) {
                    console.log(response); // 날짜 배열 확인

                    if (response.list && response.list.length > 1) {
                        let availableDates = response.list;

                

                        // 사용자가 선택할 수 있는 날짜 범위 설정
                        $('#checkin').attr('min', availableDates[0]);
                        $('#checkin').attr('max', availableDates[availableDates.length - 1]);
                       
                        // 체크아웃 날짜의 최대값을 하루 뒤로 설정
                        let checkOutMaxDate = addDays(availableDates[availableDates.length - 1], 1);
                        $('#checkout').attr('min', availableDates[0]);
                        $('#checkout').attr('max', checkOutMaxDate);
                    } else {
                        console.error("유효한 날짜 데이터가 없습니다.");
                    }
                },
                error: function(e) {
                    console.log(e);
                }
            });
        }
        
        
        function reserve(roomType, checkin, checkout, price, roomview, image, capacity, room_bed) {
        	console.log('click');
            // 세션 저장소에 방의 유형과 날짜를 저장하는 예제
            sessionStorage.setItem('roomType', roomType);
            sessionStorage.setItem('checkinDate', checkin);
            sessionStorage.setItem('checkoutDate', checkout);
            sessionStorage.setItem('price', price);
            sessionStorage.setItem('roomview', roomview);
            sessionStorage.setItem('capacity', capacity);
            sessionStorage.setItem('image', image);
            sessionStorage.setItem('room_bed', room_bed);

            // 예약 정보를 처리하는 추가적인 로직을 추가할 수 있습니다.

            // 예약 후 결제 페이지로 이동하는 예제
            window.location.href = '/customer/payment.go';
        }
        
        
        
        
</script>
</body>
</html>