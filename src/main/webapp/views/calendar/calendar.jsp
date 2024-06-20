<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>호텔 일정</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.4.0/fullcalendar.css" />
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
    .shareBtn {
        text-align: left;
        margin-left: 1400px;
        margin-bottom: 10px; 
        margin-top: 10px;
    }
</style>
</head>
<body>
<div id="wrapper">
    <div id="sidebar">
        <jsp:include page="../sideBar.jsp"></jsp:include>
    </div>

    <div id="content">
        <button type="button" class="shareBtn">일정 공유</button>
        <br><br>
        <div class="container">
            <div id="calendar"></div>
        </div>
        <br>

        <!-- 일정 공유 모달 -->
        <div class="modal fade" id="shareModal" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">일정 공유</h4>
                    </div>
                    <div class="modal-body">
                        <input type="text" id="shareTitle" class="form-control" placeholder="공유할 일정 제목">
                        <select id="shareDepartment" class="form-control">
                            <option value="인사팀">인사팀</option>
                            <option value="시설팀">시설팀</option>
                            <option value="고객팀">고객팀</option>
                        </select>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="sendShare" class="btn btn-primary" data-dismiss="modal">공유</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 일정 생성 모달 -->
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">일정 생성</h4>
                    </div>
                    <div class="modal-body">
                        <input type="text" name="${sessionScope.emp_no}">
                        <input type="text" id="eventTitle" class="form-control" placeholder="Event Title">
                        <input type="datetime-local" id="eventStart" class="form-control" placeholder="Event Title">
                        <input type="datetime-local" id="eventEnd" class="form-control" placeholder="Event Title">
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="saveEvent" class="btn btn-primary" data-dismiss="modal">저장</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 일정 삭제 모달 -->
        <div class="modal fade" id="deleteModal" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">일정 삭제</h4>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="deleteEventId">
                        <p>일정을 삭제하시겠습니까?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="confirmDelete" class="btn btn-danger" data-dismiss="modal">삭제</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.4.0/fullcalendar.min.js"></script>
<script>
    var jq = jQuery.noConflict();

    jq(document).ready(function() {
        jq('#calendar').fullCalendar({
            header: {
                left: 'month,agendaWeek,agendaDay,list',
                center: 'title',
                right: 'prev,next,today'
            },
            timeZone: 'Asia/Seoul',
            selectable: true,
            selectHelper: true,
            select: function(start, end) {
                jq('#eventStart').val(moment(start).format('YYYY-MM-DDTHH:mm'));
                jq('#eventEnd').val(moment(end).format('YYYY-MM-DDTHH:mm'));
                jq('#myModal').modal('show');
            },
            events: '/events',
            eventClick: function(calEvent, jsEvent, view) {
                jq('#deleteEventId').val(calEvent.cal_no);
                jq('#deleteModal').modal('show');
            }
        });

        jq('#saveEvent').on('click', function() {
            var cal_content = jq('#eventTitle').val();
            var cal_start = jq('#eventStart').val();
            var cal_end = jq('#eventEnd').val();

            if (cal_content && cal_start && cal_end) {
                jq.ajax({
                    url: '/events',
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ cal_content: cal_content, cal_start: cal_start, cal_end: cal_end }),
                    success: function() {
                        jq('#calendar').fullCalendar('refetchEvents');
                        jq('#myModal').modal('hide');
                    },
                    error: function() {
                        alert('일정을 저장하는 중에 오류가 발생했습니다.');
                    }
                });
            }
        });

        jq('#confirmDelete').on('click', function() {
            var id = jq('#deleteEventId').val();

            jq.ajax({
                url: '/events/' + cal_no,
                method: 'DELETE',
                success: function() {
                    jq('#calendar').fullCalendar('refetchEvents');
                    jq('#deleteModal').modal('hide');
                },
                error: function() {
                    alert('일정 삭제 중에 오류가 발생했습니다.');
                }
            });
        });

        jq('.shareBtn').on('click', function() {
            jq('#shareModal').modal('show');
        });

        jq('#sendShare').on('click', function() {
            var cal_content = jq('#shareTitle').val();
            var emp_no = jq('#shareDepartment').val();

            if (cal_content && emp_no) {
                jq.ajax({
                    url: '/share',
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ cal_content: cal_content, emp_no: emp_no }),
                    success: function() {
                        alert('일정이 ' + emp_no + ' 부서에 공유되었습니다: ' + cal_content);
                        jq('#shareModal').modal('hide');
                    },
                    error: function() {
                        alert('일정 공유 중에 오류가 발생했습니다.');
                    }
                });
            }
        });
    });
</script>

</body>
</html>
