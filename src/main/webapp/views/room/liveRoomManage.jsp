<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

    .text-right {
        text-align: right;
    }

    .read-content-body {
        word-wrap: break-word;
    }

    .read-content-body p {
        margin-bottom: 10px;
    }

    .floor {
        margin-bottom: 20px;
    }

    .room-row {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        margin-bottom: 10px;
    }

    .room {
        flex: 1 1 calc(10% - 4px);
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        width: calc(10% - 4px);
        height: 100px;
        border: 1px solid black;
        margin: 2px;
        text-align: center;
        cursor: pointer;
    }

    .room-number {
        font-size: 14px;
        margin-bottom: 5px;
    }

    .room-status {
        font-size: 12px;
    }

    .occupied {
        background-color: #01caf1;
        color: white;
    }

    .available {
        background-color: #22ca80;
        color: white;
    }

    .checkout {
        background-color: #e93a26;
        color: white;
    }

    .unavailable {
        background-color: gray;
        color: white;
    }
    
    #reservationNumber{
    	width: 90%;
    }
    
    .search{
    		text-align: right; /* 컨테이너 내의 내용을 오른쪽 정렬 */
            height: 40px; /* 필요에 따라 높이를 조정 */
            display: flex;
            justify-content: flex-end;
            align-items: center; /* 필요에 따라 수직 정렬 */
    }

	.res-row:hover {
    background-color: #9eefcc;
    cursor: pointer;
	}
	
	#availableRooms{
		width: 70%;
		margin: auto;
		text-align: center;
	}
	
	
	.table-striped{
		text-align: center;
	}
	
	#btn-container{
		 text-align: right;
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
                    	<div id="btn-container">
                    		<button class="btn btn-sm btn-info btn-sl-sm" id="change_check_in" onclick="change_check_in_modal()">체크인 준비 완료</button>
                        </div>
                        <div class="read-content" id="roomContainer">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--체크인 모달-->
<div id="success-header-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="success-header-modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header modal-colored-header bg-success">
                <h4 class="modal-title" id="success-header-modalLabel">Room Check-In</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <h5 id="roomNumberHeader" class="mt-0"></h5>
                <input type="text" id="reservationNumber" placeholder="예약번호 입력" readonly="readonly">
                <button type="button" class="btn btn-success" onclick="openReservationModal()"><i class="fas fa-caret-down"></i></button>
                <div id="modal-room-info">
                    <!-- Room details will be displayed here -->
                </div>
            </div>
            <div class="modal-footer">
            	<button type="button" class="btn btn-sm btn-success" onclick="checkIn()">
				    <i class="fas fa-check"></i> 체크인
				</button>				
            </div>
        </div>
    </div>
</div>

<!-- 예약검색 모달 -->
<div class="modal fade" id="scrollable-modal" tabindex="-1" role="dialog"
    aria-labelledby="scrollableModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="scrollableModalTitle">예약 검색</h5>
                 
                <button type="button" class="close" data-dismiss="modal"
                    aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="reservationList">
                <div class="card">                            
                      <div class="table-responsive">
	                      	<div class="search">
	                        	<input type="text"  placeholder="예약자명 검색" id="searchInput">
	                        	<button type="button" class="btn waves-effect waves-light btn-primary" onclick="handleSearch()"><i class=" icon-magnifier">검색</i></button>
	                        </div>
	                          <table class="table">
	                              <thead class="thead-light">
	                                  <tr>
	                                      <th scope="col">예약번호</th>
	                                      <th scope="col">예약자명</th>
	                                      <th scope="col">전화번호</th>
	                                      <th scope="col">체크인날짜</th>
	                                  </tr>
	                              </thead>
	                              <tbody id="resList">
	                            
	                              </tbody>
	                          </table>
                      </div>
                  </div>
            </div>           
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 체크인 alert 모달 -->
<div class="modal fade" id="centermodal" tabindex="-1" role="dialog" aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered">
       <div class="modal-content">
           <div class="modal-header modal-colored-header bg-primary">
               <h4 class="modal-title" id="myCenterModalLabel">해당 객실에 체크인 하시겠습니까?</h4>
               <button type="button" class="close" data-dismiss="modal"
                   aria-hidden="true">×</button>
           </div>
           <div class="modal-body">
 
                     <p id="currentTime"></p>
                     <p id="reservationNumberInfo"></p>
             
           </div>
           <div class="modal-footer">
            	<button type="button" class="btn btn-sm waves-effect waves-light btn-primary" onclick="lastCheck()">
				    <i class="fas fa-check"></i> 체크인
				</button>
            </div>
       </div><!-- /.modal-content -->
   </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 체크아웃 모달 -->
<div id="danger-header-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="danger-header-modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header modal-colored-header bg-danger">
                <h4 class="modal-title" id="danger-header-modalLabel">Room Check-Out</h4>
                <button type="button" class="close" data-dismiss="modal"
                    aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
            
                <h4 id="checkOutHeader" class="mt-0"></h4>
				<h5 id="res_no" class="mt-0"></h5>
				<h5 id="check_in_date" class="mt-0"></h5>
                
            </div>
            <div class="modal-footer">
          	    <button type="button" style="color: white;" class="btn btn-sm waves-effect waves-light btn-warning" onclick="changeCheckInModalOpen()"><i class="fas fa-exchange-alt"></i> 객실변경</button>
                <button type="button" class="btn btn-sm btn-danger" onclick="checkOut()"><i class="fas fa-sign-in-alt"></i> 체크아웃</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>

<!-- 체크인 객실 변경 모달 -->
<div id="changeCheckIn" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">체크인 객실 변경</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <div class="current-room">
                    <strong>현재 체크인 객실:</strong> <span id="currentRoomNo"></span>
                </div>
                <div class="available-rooms">
                    <strong>변경 가능한 객실:</strong>
                    <select id="availableRooms" class="form-control" size="5">
                        
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-dismiss="modal">닫기</button>
                <button type="button" onclick="changeCheckIn()" class="btn btn-primary">객실변경</button>
            </div>
        </div>
    </div>
</div>

<!-- 체크아웃 -> 체크인 가능 모달 -->
<div id="change_check_in_Modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="warning-header-modalLabel" aria-hidden="true">
   <div class="modal-dialog">
       <div class="modal-content">
           <div class="modal-header modal-colored-header bg-warning">
               <h4 class="modal-title" id="warning-header-modalLabel">체크아웃  -->  체크인
               </h4>
               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
           </div>
           <div class="modal-body">
               <div class="table-responsive" style="max-height: 300px; overflow-y: auto;">
                   <table class="table table-striped">
                       <thead>
                           <tr>
                               <th><input type="checkbox" id="select-all-checkouts"></th>
                               <th>객실 번호</th>
                           </tr>
                       </thead>
                       <tbody id="checkout-room-list">
                           <!-- 체크아웃 상태인 객실 목록이 여기에 표시됩니다 -->
                       </tbody>
                   </table>
               </div>
           </div>
           <div class="modal-footer">
               <button type="button" class="btn btn-warning" onclick="setRoomsToAvailable()">체크인 가능으로 변경</button>
           </div>
       </div><!-- /.modal-content -->
   </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script>
$(document).ready(function(){
    listCall();   
});

function listCall() {
    $.ajax({
        type: 'GET',
        url: '/room/liveRoomManage.ajax',
        dataType: 'json',
        success: function(data) {
            console.log(data.list);
            drawList(data.list);
        },
        error: function(e) {
            console.log(e);
        }
    });
}

function drawList(roomList) {
    var roomContainer = $('#roomContainer');
    roomContainer.empty(); // 기존 내용을 지웁니다
    $('#availableRooms').empty();
    
    var floors = {};
    for (let i = 0; i < roomList.length; i++) {
        var room = roomList[i];
        var floor = Math.floor(room.room_no / 100);
        if (!floors[floor]) {
            floors[floor] = [];
        }
        floors[floor].push(room);
    }

    for (var floor in floors) {
        var floorElement = $('<div></div>').addClass('floor');
        var floorHeader = $('<h2></h2>').text(floor + '층 - ');

        // 각 층의 방 유형 설정 (예시로 설정)
        var roomType = "";
        if (floor == 3 || floor == 4) {
            roomType = '스탠다드룸';
        } else if (floor == 5) {
            roomType = '슈페리어룸';
        } else if (floor == 6) {
            roomType = '디럭스룸';
        } else if (floor == 7) {
            roomType = '스위트룸';
        }
        floorHeader.append(roomType);
        floorElement.append(floorHeader);

        var roomRow = $('<div></div>').addClass('room-row');

        // 각 층의 방 번호를 고정된 순서로 생성
        for (var i = 1; i <= 20; i++) { // 예: 각 층에 20개의 방이 있다고 가정
            var roomNumber = floor * 100 + i;
            var roomElement = $('<div></div>').addClass('room');
            roomElement.attr('id', 'room-' + roomNumber);

            var roomNumberDiv = $('<div></div>').addClass('room-number').text(roomNumber);
            var roomStatusDiv = $('<div></div>').addClass('room-status');
            
            var room = floors[floor].find(room => room.room_no === roomNumber);
            if (room) {
                var roomStatus = room.room_status;
                
                // 방 상태에 따라 클래스 및 텍스트 설정
                if (roomStatus === 'I') {
                    roomElement.addClass('occupied');
                    roomStatusDiv.text('체크인');
                    
                    (function(num) {
                        roomElement.on('click', function() {
                            openCheckOutModal(num); // 모달 열기 함수 호출
                        });
                    })(roomNumber);
                    
                    
                } else if (roomStatus === 'A') {
                    roomElement.addClass('available');
                    roomStatusDiv.text('체크인가능');
                    
                   
                    
                    var $availableRoomsSelect = $('#availableRooms');
                                      
                    var option = $('<option value="'+room.room_no+'">').val(room.room_no).text(room.room_no);
                    $availableRoomsSelect.append(option);
                    
                    (function(num) {
                        roomElement.on('click', function() {
                            openCheckInModal(num); // 모달 열기 함수 호출
                        });
                    })(roomNumber, roomStatus);
                    
                    
                    
                } else if (roomStatus === 'O') {
                    roomElement.addClass('checkout');
                    roomStatusDiv.text('체크아웃');

                    
                    
                } else if (roomStatus === 'N') {
                    roomElement.addClass('unavailable');
                    roomStatusDiv.text('이용 불가');
                }
            }

            roomElement.append(roomNumberDiv);
            roomElement.append(roomStatusDiv);

            roomRow.append(roomElement);
        }

        floorElement.append(roomRow);
        roomContainer.append(floorElement);
    }
}

function change_check_in_modal(){
	$('#change_check_in_Modal').modal('show');
	 loadCheckoutRooms();		
}

function loadCheckoutRooms() {
    $.ajax({
        type: 'POST',
        url: '/room/getCheckoutRooms.ajax', // 체크아웃 상태인 객실 목록을 가져오는 URL
        dataType: 'json',
        success: function(data) {
        	console.log(data);
            drawCheckoutRooms(data.list);
        },
        error: function(e) {
            console.log(e);
        }
    });
}

function drawCheckoutRooms(roomList) {
	console.log('roomList:', roomList);  // 서버에서 반환된 데이터 구조 확인
    var checkoutRoomList = $('#checkout-room-list');
    checkoutRoomList.empty();

    for (var i = 0; i < roomList.length; i++) {
        var room = roomList[i];
        console.log('room:', room);  // 각 room 객체의 구조 확인
        var row = $('<tr></tr>');
        row.append('<td><input type="checkbox" class="checkout-room-checkbox" value="' + room + '"></td>');
        row.append('<td>' + room + '</td>');
        checkoutRoomList.append(row);
    }

    // Select all 체크박스 클릭 이벤트 핸들러 추가
    $('#select-all-checkouts').click(function() {
        $('.checkout-room-checkbox').prop('checked', this.checked);
    });
}

function setRoomsToAvailable() {
    var selectedRooms = $('.checkout-room-checkbox:checked').map(function() {
        return $(this).val();
    }).get();

    if (selectedRooms.length === 0) {
        alert('체크인 가능으로 변경할 객실을 선택해주세요.');
        return;
    }
	
    console.log("selectedRooms : {}",selectedRooms );
    
    $.ajax({
        type: 'POST',
        url: '/room/setRoomsToAvailable.ajax', // 객실 상태를 체크인 가능으로 변경하는 URL
        contentType: 'application/json', // JSON 형식으로 보낼 것을 명시
        data: JSON.stringify({ rooms: selectedRooms }), // JSON 문자열로 데이터 변환
        dataType: 'json',
        success: function(data) {
                alert('선택한 객실들이 체크인 가능 상태로 변경되었습니다.');
                $('#change_check_in_Modal').modal('hide');
                listCall(); // 객실 목록을 다시 로드           
        },
        error: function(e) {
            console.log(e);
        }
    });
}
function openCheckInModal(roomNumber) {
	 	$('#success-header-modal').modal('show');
	    $('#roomNumberHeader').text('Room ' + roomNumber);
	    $('#modal-room-info').empty();
	    $('#reservationNumber').val('');
}

function openCheckOutModal(roomNumber) {
	 	$('#danger-header-modal').modal('show');
	    $('#checkOutHeader').text('Room ' + roomNumber);
    
    $.ajax({
    	type:'POST',
    	url:'/room/checkInInfo.ajax',
    	data:{
    		room_no:roomNumber
    	},
    	dataType:'JSON',
    	success:function(data){
    		console.log(data);
    		$('#res_no').text('예약번호 : ' + data.res_no);
    		
    		var formattedCheckInDate = formatDate(data.stay_check_in);
    		$('#check_in_date').text('체크인 : ' + formattedCheckInDate);
    	},
    	error:function(e){
    		console.log(e);
    	}
    })
    
    
}


function formatDate(dateString) {

    var date = new Date(dateString);

    var year = date.getUTCFullYear();
    var month = String(date.getUTCMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더함
    var day = String(date.getUTCDate()).padStart(2, '0');
    var hours = String(date.getUTCHours()).padStart(2, '0');
    var minutes = String(date.getUTCMinutes()).padStart(2, '0');
    var seconds = String(date.getUTCSeconds()).padStart(2, '0');


    return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
}




function openReservationModal() {
	$('#scrollable-modal').modal('show');
	$('#searchInput').val('');
	reservationList();
		
}

function reservationList(searchTerm = ''){
	
	var name = searchTerm ? searchTerm :'';
	console.log('name = '+name);
	
	 $.ajax({
		type: 'POST',
	    url: '/room/reservationList.ajax',	
	    data:{
	    	name : name
	    },
	    dataType: 'json',
	    success: function(data) {
	        console.log(data.list);
	        drawReservationList(data.list);
	        
	    },
	    error: function(e) {
	        console.log(e);
	    }
	}); 
}



function drawReservationList(list){
	var content = '';
	if (list.length === 0) {
		content +='<tr>';
		content += '<td colspan="4">예약내역이 없습니다.</td>';
        content += '</tr>'; 
	}else{
		for (var item of list) {
			content += '<tr  class="res-row" data-reservation-no="'+ item.res_no +'">';
			content += '<th scope="row">' + item.res_no + '</th>';
			content += '<td>'+item.cos_name+'</td>';
			content += '<td>'+item.cos_phone+'</td>';
			content += '<td>'+item.in_date+'</td>';
			content += '</tr>';
		}
	}
	$('#resList').html(content);
	
	$('.res-row').on('dblclick', function() {
	    var reservationNumber = $(this).data('reservation-no');
	    $('#reservationNumber').val(reservationNumber);
	    $('#scrollable-modal').modal('hide'); // 예약 검색 모달 닫기
	  });
}

function handleSearch() {
    var searchTerm = document.getElementById('searchInput').value;
    reservationList(searchTerm);
}

function checkIn() {
		var res_number = $('#reservationNumber').val();	
	
		if (!res_number) {
			alert('예약번호를 입력해주세요!');
			return;
		}
	
		$('#centermodal').modal('show');

        var resNum = $('#reservationNumber').val();
        console.log('체크인 예약번호:', resNum);
        
        var now = new Date();
        var currentTime = now.toLocaleString();
        
        $('#currentTime').text('현재 시간: ' + currentTime);
        $('#reservationNumberInfo').text('예약번호: ' + resNum);

}

function lastCheck() {
	
	 var check_in = $('#currentTime').text().replace('현재 시간: ', '');
	 
	 var res_no = $('#reservationNumberInfo').text().replace('예약번호: ', '');
	 
	 var room_no = $('#roomNumberHeader').text().replace('Room ', '');
	 
	 
	$.ajax({
		type:'post',
		url:'/room/checkIn.ajax',
		data:{
			check_in : check_in,
			res_no : res_no,
			room_no : room_no
		},
		dataType:'json',
		success:function(data){
			console.log(data.state);
			if (data.state === 'success') {
				listCall();
				$('#success-header-modal').modal('hide');
				$('#centermodal').modal('hide');
			}else {
				alert('이미 체크인 되었거나, 사용불가인 객실입니다. 다시 시도 해 주세요');
				listCall();
				$('#success-header-modal').modal('hide');
				$('#centermodal').modal('hide');
			}
						
			
		},
		error:function(e){
			console.log(e)
		}
	});
	 	
}

function checkOut() {
	var room_no = $('#checkOutHeader').text().replace('Room ','');
	var res_no = $('#res_no').text().replace('예약번호 : ','');
	
	console.log('room_no : '+ room_no);
	console.log('res_no : '+ res_no);
	
	$.ajax({
		type:'post',
		url:'/room/checkOut.ajax',
		data:{
			room_no : room_no,
			res_no : res_no,
		},
		dataType:'json',
		success:function(data){				
			listCall();
			$('#danger-header-modal').modal('hide');	
		},
		error:function(e){
			console.log(e)
		}
	})
		
}

function changeCheckInModalOpen() {  
	var room_no = $('#checkOutHeader').text().replace('Room ', '');
	
	$('#changeCheckIn').modal('show');
    $('#currentRoomNo').text(room_no);
}

function changeCheckIn(){
		
	    var room_no = $('#checkOutHeader').text().replace('Room ', '');
	    var res_no = $('#res_no').text().replace('예약번호 : ', '');
		var changeRoom_no = $('#availableRooms').val();

		
		if (!changeRoom_no) {
			alert('변경할 객실을 선택해주세요!!');
			return
		}
		
		
		console.log(room_no);
		console.log(res_no);
		console.log(changeRoom_no);
		
		var curr_no = room_no.toString().substring(0,1);
		var after_no = changeRoom_no.toString().substring(0,1);
		
		console.log('curr_no',curr_no);
		console.log('after_no',after_no);
		
		if (((curr_no === '3' || curr_no === '4') && (after_no === '3' || after_no === '4')) || after_no === curr_no) {
		    // 같은 스탠다드 룸인 경우
			$.ajax({
		           type: 'POST',
		           url: '/room/changeCheckIn.ajax',
		           data: {
		               room_no: room_no,
		               res_no: res_no,
		               changeRoom_no:changeRoom_no
		           },
		           dataType: 'JSON',
		           success: function(data) {
			               console.log(data);
			               if (data.status === 'success') {
			                  $('#changeCheckIn').modal('hide');
			                  $('#danger-header-modal').modal('hide');
			                  listCall();
		               
			            }else{
			               alert('이미 체크인 되었거나, 사용불가인 객실입니다. 다시 시도 해 주세요');
			               $('#changeCheckIn').modal('hide');
			                  $('#danger-header-modal').modal('hide');
			                  listCall();
			            }
		               
		               
		           },
		           error: function(e) {
		               console.log(e);
		           }
		       });
		} else if (parseInt(curr_no) < parseInt(after_no)) {
			console.log('업그레이드');	

			var currentDate = getCurrentDateFormatted();
			
			
			 $.ajax({
			    	type:'POST',
			    	url:'/common/ready',
			    	data:{
			    		item_name: 'Hotel The Sheilla',
			    		quantity: 1, 
			    		tax_free_amount: 0,
			    		current_date: currentDate,
			    		room_no:room_no,
			    		res_no: res_no,
			            changeRoom_no:changeRoom_no,
			            curr_no:curr_no,
			            after_no:after_no
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
			
		    
		   
		} else {
		    alert("다운그레이드는 결제 전액 환불 후 다시 예약!!");
		}
			
}

function getCurrentDateFormatted() {
    var date = new Date();
    var year = date.getFullYear();
    var month = ('0' + (date.getMonth() + 1)).slice(-2); // 월을 2자리로 포맷
    var day = ('0' + date.getDate()).slice(-2); // 일을 2자리로 포맷
    return year + '-' + month + '-' + day;
}


</script>
</html>