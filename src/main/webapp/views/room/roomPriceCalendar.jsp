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
	
	event-content{
	background-color: #fff; /* 이벤트 컨텐츠의 배경색을 흰색으로 설정합니다. */
    border-radius: 5px; /* 모서리를 둥글게 만듭니다. */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 그림자 효과를 추가합니다. */
    margin-bottom: 10px; /* 이벤트 사이의 간격을 조정합니다. */
	}
	

.fc-h-event {
    background-color: white;
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

<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js'></script>
<script>
$(document).ready(function() {
    listCall(); 
});

function listCall() {
    var calendarEl = $('#calendar')[0];
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth', 
        events: function(fetchInfo, successCallback, failureCallback) {
            
        	var yearMonth = new Date(fetchInfo.startStr);
            yearMonth.setMonth(yearMonth.getMonth() + 1);
        	
        	$.ajax({
                type: 'POST',
                url: '/room/roomPriceCalendarList.ajax', 
                data: {
                	year_month: yearMonth.getFullYear() + '-' + ('0' + (yearMonth.getMonth() + 1)).slice(-2) 
                },
                dataType: 'json', 
                success: function(data) {

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
.
            $eventContent.append($bar1, $bar2, $bar3, $bar4);

            info.el.innerHTML = '';
            info.el.appendChild($eventContent[0]);
        }
    });
    calendar.render(); 
}
</script>
</body>
</html>
