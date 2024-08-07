<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.11.3/main.min.css" rel="stylesheet" />
<style>
       body {
        margin: 0;
        padding: 0;
        display: flex;
        height: 100vh;
        overflow: hidden;
    }

    .sidebar-container {
        flex-shrink: 0; /* 변경: flex-grow를 0으로 설정 */
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
        margin-top: 50px; /* 상단 바의 높이에 맞춰 조정 */
    }

    .card {
        margin: 20px 0;
    }
 
    #calendar {
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 그림자 효과를 추가합니다. */
    padding: 10px;
	}
	
	.bar {
    height: 30px;
    margin-bottom: 2px; /* 막대 사이의 간격을 조정합니다. */ 
    color: black; /* 흰색 텍스트 */
    padding: 5px; /* 막대 안의 내용과의 간격 조정 */
    font-size: 12px; /* 글자 크기 조정 */
     border-radius: 15px;
	}
	
	.event-content{
	background-color: #fff; /* 이벤트 컨텐츠의 배경색을 흰색으로 설정합니다. */
    border-radius: 5px; /* 모서리를 둥글게 만듭니다. */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 그림자 효과를 추가합니다. */
    margin-bottom: 10px; /* 이벤트 사이의 간격을 조정합니다. */
	}
	

.fc-h-event {
    background-color: white;
}

.fc .fc-daygrid-day-top {
    display: block;
    /* flex-direction: row-reverse; */
}

.fc .fc-scroller-liquid-absolute {
     position: initial;
}

#standBar {
    background-color: lightgreen;
    color: black; /* 흰색 텍스트 */
}

#superBar {
    background-color: lightblue;
    color: black; /* 흰색 텍스트 */
}

#deluxBar {
    background-color: lightyellow;
    color: black; /* 흰색 텍스트 */
}

#suiteBar {
    background-color: lavender;
    color: black; /* 흰색 텍스트 */
}

 .modal-header {
        background-color: #17a2b8;
        color: white;
    }

    .modal-body h4 {
        margin-bottom: 20px;
    }

    .table {
        width: 100%;
        margin-bottom: 20px;
        background-color: #fff;
        text-align: center;
    }

    .table th,
    .table td {
        padding: 10px;
        vertical-align: middle;
        border-top: 1px solid #dee2e6;
    }

    .table th {
        background-color: #f2f2f2;
        text-align: center;
    }

    .form-control-plaintext {
        border: none;
        padding: 0;
        background-color: transparent;
        font-size: 16px;
        text-align: center;
    }

    .modal-footer {
        display: flex;
        justify-content: center;
        padding: 15px;
    }

    .modal-footer .btn-info {
        width: 100px;
    }
    
    .event-content{
    	cursor: pointer;
    }
    
    #eventDate{
    	text-align: center;
    }
    
    .past-date {
    cursor: default; /* 포인터가 아닌 기본 커서 */
    opacity: 0.5; /* 활성화되지 않은 것을 나타내기 위해 투명도를 낮춤 */
}

.future-date {
    cursor: pointer; /* 포인터 커서 */
    opacity: 1; /* 완전히 불투명한 상태 */
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
                        <div class="table-responsive">
                            <div id="calendar"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--  모달  -->
<div id="dayRoomPrice" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="info-header-modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header modal-colored-header bg-info">
                <h4 class="modal-title" id="info-header-modalLabel">일일 객실 가격</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <h4 id="eventDate"></h4>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>룸 타입</th>
                            <th>가격 (KRW)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>스탠다드룸</td>
                            <td><input type="text" id="modalStandardPrice" class="form-control-plaintext" /></td>
                        </tr>
                        <tr>
                            <td>슈페리어룸</td>
                            <td><input type="text" id="modalSuperiorPrice" class="form-control-plaintext" /></td>
                        </tr>
                        <tr>
                            <td>디럭스룸</td>
                            <td><input type="text" id="modalDeluxPrice" class="form-control-plaintext" /></td>
                        </tr>
                        <tr>
                            <td>스위트룸</td>
                            <td><input type="text" id="modalSuitePrice" class="form-control-plaintext" /></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" data-dismiss="modal" onclick="updateDayRoomPrice()">확인</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js'></script>
<script>
var selectedDate = '';
var currentYearMonth = '';

$(document).ready(function() {
    listCall(); 
    console.log("listCall 요청!!");
});

function listCall() {
    console.log("listCall 실행");
    var calendarEl = $('#calendar')[0];
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth', 
        events: function(fetchInfo, successCallback, failureCallback) {
        	 var yearMonth = new Date(fetchInfo.startStr);
             if (yearMonth.getDate() === 1  ) {
            	 yearMonth.setMonth(yearMonth.getMonth()); 	
			}else{
        	 yearMonth.setMonth(yearMonth.getMonth() + 1); 					
			}
			
             console.log(yearMonth.getFullYear() + '-' + ('0' + (yearMonth.getMonth() + 1)).slice(-2));
            console.log(fetchInfo);
            $.ajax({
                type: 'POST',
                url: '/room/roomPriceCalendarList.ajax', 
                data: {
                    year_month: yearMonth.getFullYear() + '-' + ('0' + (yearMonth.getMonth() + 1)).slice(-2) 
                },
                dataType: 'JSON', 
                success: function(data) {
                    console.log(data);
                    var events = data.list.map(function(event) {
                        return {
                             title: '', 
                             start: event.date, // 이벤트의 시작 날짜
                             end: event.date, // 이벤트의 종료 날짜
                             data: event, 
                             standard: event.standard, 
                             superior: event.superior,
                             delux: event.delux,
                             suite: event.suite 
                        };
                    });

                    successCallback(events); 
                },
                error: function(e) {
                    console.log(e); 
                    failureCallback('이벤트 데이터를 불러오는 중 오류가 발생했습니다.');
                }
            });
        },        
        eventDidMount: function(info) {
            var event = info.event;
            var $eventContent = $('<div class="event-content">');

            var $bar1 = $('<div class="bar" id="standBar">').text('스탠다드룸 ' + event.extendedProps.standard +'KRW');
            var $bar2 = $('<div class="bar" id="superBar">').text('슈페리어룸 ' + event.extendedProps.superior +'KRW');
            var $bar3 = $('<div class="bar" id="deluxBar">').text('디럭스룸 ' + event.extendedProps.delux +'KRW');
            var $bar4 = $('<div class="bar" id="suiteBar">').text('스위트룸 ' + event.extendedProps.suite +'KRW');

            $eventContent.append($bar1, $bar2, $bar3, $bar4);

            info.el.innerHTML = '';
            info.el.appendChild($eventContent[0]);

            // 이벤트 날짜와 오늘 날짜 비교
            var eventDate = new Date(event.start);
            var today = new Date();
            
            // 시간 부분을 제거하여 날짜만 비교
            eventDate.setHours(0, 0, 0, 0);
            today.setHours(0, 0, 0, 0);

            // 날짜가 오늘 이전인지 확인
            if (eventDate < today) {
                // 과거 날짜인 경우
                info.el.classList.add('past-date');
            } else {
                // 현재 및 미래 날짜인 경우
                info.el.classList.add('future-date');
                
                // 클릭 이벤트 핸들러 추가
                $bar1.on('click', function() {
                    openRoomPriceModal(event.extendedProps, event.startStr);
                });
                $bar2.on('click', function() {
                    openRoomPriceModal(event.extendedProps, event.startStr);
                });
                $bar3.on('click', function() {
                    openRoomPriceModal(event.extendedProps, event.startStr);
                });
                $bar4.on('click', function() {
                    openRoomPriceModal(event.extendedProps, event.startStr);
                });
            }
        }
    });
    calendar.render(); 
}

function openRoomPriceModal(data, date) {
	selectedDate = date;
    $('#eventDate').text(date); // 클릭한 날짜를 모달에 표시
    $('#modalStandardPrice').val(data.standard);
    $('#modalSuperiorPrice').val(data.superior);
    $('#modalDeluxPrice').val(data.delux);
    $('#modalSuitePrice').val(data.suite);
    $('#dayRoomPrice').modal('show'); // 부트스트랩 모달 열기
}

// 해달 날짜 객실 타입별 가격 업데이트 !
function updateDayRoomPrice() {
	var standard = $('#modalStandardPrice').val();
	var superior = $('#modalSuperiorPrice').val();
	var delux = $('#modalDeluxPrice').val();
	var suite = $('#modalSuitePrice').val();
	
	console.log("selectedDate : " + selectedDate);
	console.log("standard : " + standard);
	console.log("superior : " + superior);
	console.log("delux : " + delux);
	console.log("suite : " + suite);
	
	$.ajax({
		type: 'POST',
        url: '/room/updateDayRoomPrice.ajax', 
        data: {
        	standard:standard,
        	superior:superior,
        	delux:delux,
        	suite:suite,
        	date:selectedDate
        },
        dataType: 'JSON', 
        success: function(data) {
        	console.log(data);
        	listCall(); 
        },
        error:function(e){
        	console.log(e);
        }
	});
	

}
</script>
</body>
</html>