<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>예약 페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
    body {
        margin: 0;
        padding: 0;
        display: flex;
        height: 100vh;
        overflow: hidden;
    }

    .sidebar-container {
        flex-shrink: 0;
        width: 250px;
        background-color: #f8f9fa;
        box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        overflow-y: auto;
    }

    .sidebar {
        padding: 20px;
    }

    .content-body {
        flex-grow: 1;
        padding: 20px;
        overflow-y: auto;
        margin-top: 50px;
    }

    .card {
        margin: 20px 0;
    }
    
    .customize-input {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        position: relative;
    }

    .customize-input label {
        display: block;
        text-align: center;
        font-size: 16px;
        color: #6c757d;
    }
    
    .customize-input input {
        margin-top: 10px;
        text-align: center;
    }

    #checkInDate, #checkOutDate {
        width: 200px;
        border: 2px;
    }

     #iconContainer {
        display: flex;
        align-items: center;
        font-size: 24px; /* 아이콘과 텍스트의 크기를 조정 */
    }

    #iconContainer i {
        margin-right: 8px; /* 아이콘과 텍스트 사이의 간격 */
    }

    #nightCount {
        font-size: 24px; /* 텍스트의 크기를 조정 */
    }

   
    
    .btn-primary{
    	margin-left: 45px;
    }
    
    
    h3{
    	text-align: center;
    }

    /* 테이블 스타일 */
   #resTable {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px; /* 추가적인 마진 설정 */
    }

    #resTable th, #resTable td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }
    
     #resTable button:hover {
        background-color: #0056b3;
    }

    #resTable th {
        background-color: #f2f2f2;
    }
    
     #resTable button {
        padding: 5px 10px;
        background-color: #007bff;
        color: white;
        border: none;
        cursor: pointer;
        border-radius: 20%;
        
    }

    /* 숨기기 스타일 */
    .hidden {
        display: none;
    }
</style>
</head>
<body>
<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>

<div class="content-body">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <div class="customize-input">
                            <div>
                                <label for="checkInDate">체크인</label>
                                <input type="date" class="form-control custom-shadow custom-radius bg-white" id="checkInDate">
                            </div>
                           
						   <div id="iconContainer">
						       <i class="fas fa-moon"></i>
						       <div id="nightCount">1박</div>
						   </div>

                            <div>
                                <label for="checkOutDate">체크아웃</label>
                                <input type="date" class="form-control custom-shadow custom-radius bg-white" id="checkOutDate">
                            </div>
                            <button id="searchButton" class="btn btn-primary">검색</button>
                        </div>
                        <hr>
                        <div class="card-body">
                        	<h3 id="selectDateMessage">예약을 원하시는 날짜를 선택해주세요.</h3>
                        	<table id="resTable">
                        		
                        	</table>                        	
                        </div>
                    </div>   
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="centermodal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myCenterModalLabel">현장 예약/결제</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered">
                    <tbody>
                        <tr>
                            <th>체크인 날짜</th>
                            <td><input id="checkIn" class="form-control" readonly></td>
                        </tr>
                        <tr>
                            <th>체크아웃 날짜</th>
                            <td><input id="checkOut" class="form-control" readonly></td>
                        </tr>
                        <tr>
                            <th>총 결제 금액</th>
                            <td><input id="totalPrice" class="form-control" readonly></td>
                        </tr>
                        <tr>
                            <th>객실 타입</th>
                            <td><input id="itemName" class="form-control" readonly></td>
                        </tr>
                        <tr>
                            <th>예약자 성함</th>
                            <td><input id="cos_name" class="form-control"></td>
                        </tr>
                        <tr>
                            <th>예약자 전화번호</th>
                            <td><input id="cos_phone" class="form-control"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" onclick="submitReservation()">결제 요청</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


</body>
<script>
var msg = "${msg}"; // JSP에서 가져온 변수 msg

// msg 변수가 true이면 알림창 표시
if (msg) {
    alert(msg); // 알림창에 메시지 표시
}

$(document).ready(() => {
    setInitialDates();
    getDate();
    
    $('#checkInDate').on('change', () => {
        var checkInDate = $('#checkInDate').val();
        $('#checkOutDate').attr('min', new Date(new Date(checkInDate).getTime() + 24 * 60 * 60 * 1000).toISOString().split('T')[0]);
        handleSearch();
        if (new Date($('#checkOutDate').val()) <= new Date(checkInDate)) {
            $('#checkOutDate').val('');
            $('#nightCount').text('1박');
        } else {
            updateNightCount();
        }
    });

    $('#checkOutDate').on('change', function() {
        updateNightCount();
    });

    $('#searchButton').on('click', handleSearch);
});

function updateNightCount() {
    var checkInDate = new Date($('#checkInDate').val());
    var checkOutDate = new Date($('#checkOutDate').val());

    if (checkInDate && checkOutDate && checkInDate < checkOutDate) {
        var timeDiff = checkOutDate.getTime() - checkInDate.getTime();
        var nightCount = Math.ceil(timeDiff / (1000 * 3600 * 24));
        $('#nightCount').text(nightCount + '박');
    } else {
        $('#nightCount').text('1박');
    }
}

$('#checkOutDate').on('change', () => {
	handleSearch();
});


function submitReservation() {
    var cos_name = document.getElementById('cos_name').value;
    var cos_phone = document.getElementById('cos_phone').value;
	var checkIn = $('#checkIn').val();
	var checkOut = $('#checkOut').val();
	var total_amount = $('#totalPrice').val();
	var item_name = $('#itemName').val();

	console.log('결제요청 : ' +cos_name,cos_phone,checkIn,checkOut,total_amount,item_name);
	
    // 예약자 이름과 전화번호가 비어있는지 확인
   if (!cos_name || !cos_phone) {
	    alert("예약자 이름과 전화번호를 모두 입력해주세요.");
	    return;
	}
	
	// 전화번호 유효성 검사 정규식
	var phoneRegex = /^(010-\d{4}-\d{4})$/;
	
	if (!phoneRegex.test(cos_phone)) {
	    alert("유효한 전화번호를 입력해주세요. 예: 010-1234-5678");
	    return;
	}

    // 예약 정보를 서버로 전송하는 AJAX 요청 등 추가 구현
    $.ajax({
    	type:'POST',
    	url:'/common/ready',
    	data:{
    		item_name: item_name,
    		total_amount: total_amount,
    		checkIn: checkIn,
    		checkOut: checkOut,
    		cos_name:cos_name,
    		cos_phone:cos_phone,
    		quantity: 1, 
    		tax_free_amount: 0
    	},
    	dataType:'JSON',
    	success:function(res) {
    		location.href = res.next_redirect_pc_url;      
    	},
    	error: function(e) {
            console.error("Error occurred:", e);
            alert("결제 준비 중 오류가 발생했습니다. 다시 시도해주세요.");
        }
    })

    $('#centermodal').modal('hide'); 
}
	
function setInitialDates() {
    const today = new Date();
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    const formatDate = (date) => date.toISOString().split('T')[0];

    const checkInInput = document.getElementById('checkInDate');
    const checkOutInput = document.getElementById('checkOutDate');

    checkInInput.value = formatDate(today);
    checkInInput.min = formatDate(today);

    checkOutInput.value = formatDate(tomorrow);
    checkOutInput.min = formatDate(tomorrow);
}

function validateDates() {
    const checkInDate = document.getElementById('checkInDate').value;
    const checkOutDate = document.getElementById('checkOutDate').value;

    if (!checkInDate) {
        alert("체크인 날짜를 선택하세요.");

        return false;
    }

    if (!checkOutDate) {
        alert("체크아웃 날짜를 선택하세요.");

        return false;
    }

    if (new Date(checkOutDate) <= new Date(checkInDate)) {
        alert("체크아웃 날짜는 체크인 날짜보다 이후여야 합니다.");

        return false;
    }
	   
    
    return true;
}

function handleSearch() {
    if (validateDates()) {
        var checkInDate = document.getElementById('checkInDate').value;
        var checkOutDate = document.getElementById('checkOutDate').value;
        console.log("체크인 날짜: ", checkInDate);
        console.log("체크아웃 날짜: ", checkOutDate);
        
        listCall(checkInDate, checkOutDate);
    }
}

function listCall(checkInDate, checkOutDate) {
	
    $.ajax({
        type: 'POST',
        url: '/guest/reserveListCall.ajax',
        data: {
            in_date: checkInDate,
            out_date: checkOutDate
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

function drawList(data, checkInDate, checkOutDate) {
    var roomContainer = $('#resTable');
    roomContainer.empty();

    var content = '';
    for (var item of data.resList) {
        content += '<tr>';

        if (item.type_code === 1001) {
            content += '<th>스탠다드룸</th>';
            content += '<td>' + item.room_view + ' | 최대인원 ' + item.room_capacity + '명 | ' + item.room_bed + '</td>';
            content += '<td>총 ' + formatNumber(data.standard) + ' KRW</td>';
            content += '<td>예약가능 객실 ' + (40 - data.standard_num) + '개</td>';
            if (data.standard_num >= 40) {
                content += '<td style="color:red;">예약불가</td>';
            } else {
                content += '<td><button onclick="reserve(\'스탠다드룸\', \'' + checkInDate + '\', \'' + checkOutDate + '\', ' + data.standard + ')">예약</button></td>';
            }
        } else if (item.type_code === 1002) {
            content += '<th>슈페리어룸</th>';
            content += '<td>' + item.room_view + ' | 최대인원 ' + item.room_capacity + '명 | ' + item.room_bed + '</td>';
            content += '<td>총 ' + formatNumber(data.superior) + ' KRW</td>';
            content += '<td>예약가능 객실 ' + (20 - data.superior_num) + '개</td>';
            if (data.superior_num >= 20) {
                content += '<td style="color:red;">예약불가</td>';
            } else {
                content += '<td><button onclick="reserve(\'슈페리어룸\', \'' + checkInDate + '\', \'' + checkOutDate + '\', ' + data.superior + ')">예약</button></td>';
            }
        } else if (item.type_code === 1003) {
            content += '<th>디럭스룸</th>';
            content += '<td>' + item.room_view + ' | 최대인원 ' + item.room_capacity + '명 | ' + item.room_bed + '</td>';
            content += '<td>총 ' + formatNumber(data.delux) + ' KRW</td>';
            content += '<td>예약가능 객실 ' + (20 - data.delux_num) + '개</td>';
            if (data.delux_num >= 20) {
                content += '<td style="color:red;">예약불가</td>';
            } else {
                content += '<td><button onclick="reserve(\'디럭스룸\', \'' + checkInDate + '\', \'' + checkOutDate + '\', ' + data.delux + ')">예약</button></td>';
            }
        } else {
            content += '<th>스위트룸</th>';
            content += '<td>' + item.room_view + ' | 최대인원 ' + item.room_capacity + '명 | ' + item.room_bed + '</td>';
            content += '<td>총 ' + formatNumber(data.suite) + ' KRW</td>';
            content += '<td>예약가능 객실 ' + (20 - data.suite_num) + '개</td>';
            if (data.suite_num >= 20) {
                content += '<td style="color:red;">예약불가</td>';
            } else {
                content += '<td><button onclick="reserve(\'스위트룸\', \'' + checkInDate + '\', \'' + checkOutDate + '\', ' + data.suite + ')">예약</button></td>';
            }
        }

        content += '</tr>';
    }
    $('#resTable').html(content);
}

// 숫자 포맷팅 함수
function formatNumber(number) {
    return number.toLocaleString();
}

function reserve(roomName, checkIn, checkOut, price) {
    $('#checkIn').val(''); 
    $('#checkOut').val(''); 
    $('#totalPrice').val(''); 
    $('#itemName').val(''); 
    $('#cos_name').val('');  
    $('#cos_phone').val(''); 
    
    console.log(roomName, checkIn, checkOut, price);

    $('#checkIn').val(checkIn);
    $('#checkOut').val(checkOut);
    $('#totalPrice').val(price);
    $('#itemName').val(roomName);
    $('#centermodal').modal('show');
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

                // 첫 번째 날짜를 체크인 날짜로 설정
                $('#checkInDate').val(availableDates[0]);

                // 두 번째 날짜를 체크아웃 날짜로 설정
                $('#checkOutDate').val(availableDates[1]);

                // 사용자가 선택할 수 있는 날짜 범위 설정
                $('#checkInDate').attr('min', availableDates[0]);
                $('#checkInDate').attr('max', availableDates[availableDates.length - 1]);
               
                // 체크아웃 날짜의 최대값을 하루 뒤로 설정
                let checkOutMaxDate = addDays(availableDates[availableDates.length - 1], 1);
                $('#checkOutDate').attr('min', availableDates[0]);
                $('#checkOutDate').attr('max', checkOutMaxDate);
            } else {
                console.error("유효한 날짜 데이터가 없습니다.");
            }
        },
        error: function(e) {
            console.log(e);
        }
    });
}

</script>

</html>
