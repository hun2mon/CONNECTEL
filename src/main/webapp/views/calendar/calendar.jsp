<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>호텔 일정</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.11.3/main.min.css" rel="stylesheet" />
    <style>
        #sidebar {
            width: 250px;
            background-color: #f0f0f0;
            position: fixed;
            top: 0;
            left: 0;
            bottom: 0;
            overflow-y: auto;
            z-index: 100;
        }
        #content {
            width: 100%;
            height: 100%;
            margin-left: 300px;
            margin-right: 150px;
            margin-top: 102px;
            margin-bottom: 250px;
        }
    </style>
</head>
<body>
<div id="wrapper">
    <div id="sidebar">
        <jsp:include page="../sideBar.jsp"></jsp:include>
    </div>
    <div id="content">
        <div class="container">
            <div id='calendar'></div>
        </div>
        <div class="modal fade" id="addEventModal" tabindex="-1" aria-labelledby="addEventModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addEventModalLabel">일정 추가</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="addEventForm">
                            <div class="form-group">
                                <label for="eventTitle">제목</label>
                                <input type="text" class="form-control" id="eventTitle" placeholder="일정 제목 입력">
                            </div>
                            <div class="form-group">
                                <label for="eventStart">시작 시간</label>
                                <input type="datetime-local" class="form-control" id="eventStart">
                            </div>
                            <div class="form-group">
                                <label for="eventEnd">종료 시간</label>
                                <input type="datetime-local" class="form-control" id="eventEnd">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" id="saveEventBtn">저장</button>
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

        // 일정 추가 버튼 클릭 시 모달 띄우기
        $('#addEventBtn').on('click', function() {
            $('#addEventModal').modal('show');
        });

        // 저장 버튼 클릭 시 일정 추가
        $('#saveEventBtn').on('click', function() {
            var eventTitle = $('#eventTitle').val();
            var eventStart = $('#eventStart').val();
            var eventEnd = $('#eventEnd').val();

            if (eventTitle && eventStart && eventEnd) {
                $.ajax({
                    type: 'POST',
                    url: '/addEvent',
                    data: {
                        title: eventTitle,
                        start: eventStart,
                        end: eventEnd
                    },
                    success: function(data) {
                        if (data.success) {
                            // FullCalendar에 이벤트 추가
                            calendar.addEvent({
                                title: eventTitle,
                                start: eventStart,
                                end: eventEnd
                            });

                            // 모달 닫기
                            $('#addEventModal').modal('hide');
                        } else {
                            alert('일정 추가에 실패했습니다.');
                        }
                    },
                    error: function(e) {
                        console.log(e);
                        alert('일정 추가 중 오류가 발생했습니다.');
                    }
                });
            } else {
                alert('일정 제목, 시작 시간, 종료 시간을 모두 입력해주세요.');
            }
        });

        function listCall() {
            var calendarEl = $('#calendar')[0];
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                events: function(fetchInfo, successCallback, failureCallback) {
                    $.ajax({
                        type: 'GET',
                        url: '/getEvents',
                        data: {
                            start: fetchInfo.startStr,
                            end: fetchInfo.endStr
                        },
                        dataType: 'JSON',
                        success: function(data) {
                            var events = data.map(function(event) {
                                return {
                                    title: event.title,
                                    start: event.start,
                                    end: event.end,
                                    id: event.id
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
                eventClick: function(info) {
                    // 이벤트 클릭 시 삭제 기능 추가
                    if (confirm('이 일정을 삭제하시겠습니까?')) {
                        $.ajax({
                            type: 'POST',
                            url: '/deleteEvent',
                            data: {
                                id: info.event.id
                            },
                            success: function(data) {
                                if (data.success) {
                                    info.event.remove();
                                } else {
                                    alert('일정 삭제에 실패했습니다.');
                                }
                            },
                            error: function(e) {
                                console.log(e);
                                alert('일정 삭제 중 오류가 발생했습니다.');
                            }
                        });
                    }
                }
            });
            calendar.render();
        }
    });
</script>
</body>
</html>
