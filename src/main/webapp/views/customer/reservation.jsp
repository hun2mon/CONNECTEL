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
.hidden {
    display: none; /* 화면에서 보이지 않음 */
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
    background-color: #1862a6;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}
.reserve1 input[type="submit"]:hover {
    background-color: #0a4377;
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
    color: midnightblue; /* 테이블 머리글 배경색 */
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
        padding: 8px 16px; /* 버튼 내부 여백 조정 */
        font-size: 14px; /* 버튼 텍스트 사이즈 */
        border-radius: 5px; /* 버튼 모서리 둥글게 */
        background-color: #007BFF; /* 버튼 배경색 */
        color: white; /* 버튼 텍스트 색상 */
        border: none; /* 테두리 없음 */
        cursor: pointer; /* 포인터 형태 커서 설정 */
        transition: background-color 0.3s ease; /* 배경색 변화 시 부드러운 전환 효과 */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3); /* 그림자 효과 */
}

.reservation-button-cell button:hover {
        background-color: #0056b3; /* 호버 시 배경색 변경 */
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
            <td class="reservation-button-cell"><input type="submit" value="검색" id="btn" onclick="return reservationCheck()"/></td>
        </tr>
    </table>  
    <div class="card-body" style="text-align:center">
        <h3 id="selectDateMessage" style="font-size:20px;">예약을 원하시는 날짜를 선택해주세요.</h3>
        <table class="resTable" id="resTable"></table>                        
    </div>

                                        
<!-- 스탠다드 모달 -->
<div class="modal fade" id="standardmodal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
		<div class="modal-header">
			<h4 class="modal-title" id="myCenterModalLabel">Standard Room</h4>
			<button type="button" class="close" data-dismiss="modal"aria-hidden="true">×</button>
		</div>
		<div class="modal-body">
			<img id= "standard_img" style="width:100%; height:500px;">
			<p id="standard_info"></p>
			<p id="standard_extent"></p>
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
		<div class="modal-body">
			<img id= "superior_img" style="width:100%; height:500px;">
			<p id="superior_info"></p>
			<p id="superior_extent"></p>			
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
			<p id="delux_info"></p>
			<p id="delux_extent"></p>
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
			<p id="suite_info"></p>
			<p id="delux_extent"></p>
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
            $('#selectDateMessage').addClass('hidden');
            var checkInDate = document.getElementById('checkin').value;
            var checkOutDate = document.getElementById('checkout').value;

            // 체크인, 체크아웃 날짜가 유효한지 확인
            if (!checkInDate || !checkOutDate) {
                alert("체크인 및 체크아웃 날짜를 선택해주세요.");
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

        function drawList(data, checkin, checkout) {
            var roomContainer = $('#resTable');
            roomContainer.empty();
            
            $('#standard_img').attr('src','/photo/'+data.standard_image);
            $('#standard_info').html(data.standard_detail);
            $('#standard_extent').html(data.standard_extent);
            $('#superior_img').attr('src','/photo/'+data.superior_image);
            $('#superior_info').html(data.superior_detail);
            $('#superior_extent').html(data.superior_extent);
            $('#delux_img').attr('src','/photo/'+data.delux_image);
            $('#delux_info').html(data.delux_detail);
            $('#delux_extent').html(data.delux_extent);
            $('#suite_img').attr('src','/photo/'+data.suite_image);
            $('#suite_info').html(data.suite_detail);
            $('#suite_extent').html(data.suite_extent);
            
            
            var content = '';
            for (var item of data.resList) {
                var adults = parseInt(document.getElementsByName('r_adults')[0].value);
                var kids = parseInt(document.getElementsByName('r_kids')[0].value);
                var totalGuests = adults + kids;
                content += '<tr style="">';

                if (item.type_code === 1001){
                    content += '<th> <img src="/photo/'+data.standard_image+'"data-toggle="modal"data-target="#standardmodal" style="width:300px; height:200px; max-width:300px; max-height:200px; cursor:pointer"></th>'
                    content += '<th> :: Standard Room ::<br>(스탠다드룸)</th>';
                    content += '<td>' + item.room_view + ' | 최대인원 ' + item.room_capacity + '명 | ' + item.room_bed + '</td>';
                    content += '<td>' + formatNumber(data.minStandardPrice) + ' KRW 부터~</td>';

					
                    if (data.standard_num >= 40 || item.room_capacity < totalGuests) {
                        content += '<td style="color:gray;"> 현재 남은 객실이 없습니다.</td>';
                    } else {
                        content += '<td class="reservation-button-cell"><button onclick="reserve(\'스탠다드룸\', \'' + checkin + '\', \'' + checkout + '\', ' + data.standard + ')">예약</button></td>';
                    }
                } else if (item.type_code === 1002) {
                    content += '<th> <img src="/photo/'+data.superior_image+'" data-toggle="modal"data-target="#superiormodal" style="width:300px; height:200px; max-width:300px; max-height:200px;"></th>'
                	content += '<th> :: Superior Room ::<br>(슈페리얼룸)</th>';
                    content += '<td>' + item.room_view + ' | 최대인원 ' + item.room_capacity + '명 | ' + item.room_bed + '</td>';
                    content += '<td>' + formatNumber(data.minSuperiorPrice) + ' KRW 부터~</td>';

                    if (data.superior_num >= 20) {
                        content += '<td style="color:red;">현재 남은 객실이 없습니다</td>';
                    } else {
                        content += '<td class="reservation-button-cell"><button onclick="reserve(\'슈페리어룸\', \'' + checkin + '\', \'' + checkout + '\', ' + data.superior + ')">예약</button></td>';
                    }
                } else if (item.type_code === 1003) {
                    content += '<th> <img src="/photo/'+data.delux_image+'" data-toggle="modal"data-target="#deluxmodal" style="width:300px; height:200px; max-width:300px; max-height:200px;"></th>'
                	content += '<th> :: Delux Room ::<br>(디럭스룸)</th>';
                    content += '<td>' + item.room_view + ' | 최대인원 ' + item.room_capacity + '명 | ' + item.room_bed + '</td>';
                    content += '<td>' + formatNumber(data.minDeluxePrice) + ' KRW 부터~</td>';

                    if (data.delux_num >= 20) {
                        content += '<td style="color:red;">현재 남은 객실이 없습니다</td>';
                    } else {
                        content += '<td class="reservation-button-cell"><button onclick="reserve(\'디럭스룸\', \'' + checkin + '\', \'' + checkout + '\', ' + data.delux + ')">예약</button></td>';
                    }
                } else {
                    content += '<th> <img src="/photo/'+data.suite_image+'" data-toggle="modal"data-target="#suitemodal" style="width:300px; height:200px; max-width:300px; max-height:200px;"></th>'
                	content += '<th>:: Suite Room :: <br>(스위트룸)</th>';
                    content += '<td>' + item.room_view + ' | 최대인원 ' + item.room_capacity + '명 | ' + item.room_bed + '</td>';
                    content += '<td>' + formatNumber(data.minSuitePrice) + ' KRW 부터~</td>';

                    if (data.suite_num >= 20) {
                        content += '<td style="color:red;">현재 남은 객실이 없습니다</td>';
                    } else {
                        content += '<td class="reservation-button-cell"><button onclick="reserve(\'스위트룸\', \'' + checkin + '\', \'' + checkout + '\', ' + data.suite + ')">예약</button></td>';
                    }
                }

                content += '</tr>';
            }
            $('#resTable').html(content);
        }
</script>
</body>
</html>