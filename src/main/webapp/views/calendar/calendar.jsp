<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>호텔 일정</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.11.3/main.min.css" rel="stylesheet" />
<link href="/css/jquery-explr-1.4.css" rel="stylesheet" type="text/css">
<style>
.container{
	margin-left:300px;
	width: 100%;
}

#calendar{
	width: 100%;
}

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
.circle-test {
  width: 17px;
  height: 17px;
  border-radius: 50%;
  background-color: blue;
}
.circle-test1 {
  width: 17px;
  height: 17px;
  border-radius: 50%;
  background-color: skyblue;
}
.sssss{
  display : flex;
  width : 500px;
}


</style>
</head>
<body>
	<div id="wrapper">
		<div id="sidebar">
			<jsp:include page="../sideBar.jsp"></jsp:include>
		</div>
		<div id="content">
			<div class = "sssss">
			<div class = "circle-test">
			</div>
			<span>내 일정</span>
			&nbsp;&nbsp;
			<div class = "circle-test1">
			</div>
			<span>공유 일정</span>			
			</div>
			
			<div class="container" style = "margin-left : 300px;">
				<div id='calendar'></div>
			</div>
				<input type="hidden" id="emp_no" name="emp_no" value="${sessionScope.loginInfo.emp_no}">
			
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
								<input type="hidden" id="emp_no" name="emp_no" value="${sessionScope.loginInfo.emp_no}">
								<div class="form-group">
									<label for="eventTitle">제목</label> <input type="text" class="form-control" id="eventTitle" placeholder="일정 제목 입력">
								</div>
								<div class="form-group">
									<label for="eventStart">시작 시간</label> <input type="datetime-local" class="form-control" id="eventStart">
								</div>
								<div class="form-group">
									<label for="eventEnd">종료 시간</label> <input type="datetime-local" class="form-control" id="eventEnd">
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

			<!-- 일정 상세 보기 모달 -->
			<div class="modal fade" id="viewEventModal" tabindex="-1" aria-labelledby="viewEventModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<!-- modal-lg: 큰 사이즈 모달 -->
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="viewEventModalLabel">일정 상세 보기</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<div id="eventDetails">
								<h5 id="eventDetailsTitle"></h5>
								<p>
									<strong>시작 시간:</strong> <span id="eventDetailsStart"></span>
								</p>
								<p>
									<strong>종료 시간:</strong> <span id="eventDetailsEnd"></span>
								</p>
								<hr>
			                    <h5>일정 공유된 인원</h5>
			                    <ul id="sharedParticipantsList"></ul> <!-- 인원 목록을 표시할 ul 요소 -->
							</div>
							<!-- 일정 공유 버튼 -->
							<button type="button" class="btn btn-primary mt-3 mb-3" id="shareEventBtn">인원추가</button>
							<!-- 선택된 인원 표시할 영역 -->
							<ul id="selectedParticipantsList"></ul>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger" id="deleteEventBtn">삭제</button>
							<button type="button" class="btn btn-success" id="editParticipantsBtn" style = "display : none;">일정 공유 수정</button>
			                <button type="button" class="btn btn-success" id="addParticipantsBtn">일정 공유</button>
							<button type="button" class="btn btn-success" id="editParties">일정 공유 수정</button>
			                
							<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
			
						
			
	<!-- 일정 수정 모달 -->
	<div class="modal fade" id="editEventModal" tabindex="-1" aria-labelledby="editEventModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="editEventModalLabel">일정 수정</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            
	            <div class="modal-body">
	                <form id="editEventForm">
	                    <input type="hidden" id="editEventId">
	                    <div class="form-group">
	                        <label for="editEventTitle">제목</label>
	                        <input type="text" class="form-control" id="editEventTitle" placeholder="일정 제목 입력">
	                    </div>
	                    <div class="form-group">
	                        <label for="editEventStart">시작 시간</label>
	                        <input type="datetime-local" class="form-control" id="editEventStart">
	                    </div>
	                    <div class="form-group">
	                        <label for="editEventEnd">종료 시간</label>
	                        <input type="datetime-local" class="form-control" id="editEventEnd">
	                    </div>
	                </form>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" id="deleteParties">일정 참여자 삭제</button>	                
	                <button type="button" class="btn btn-primary" id="updateEventBtn">저장</button>
	            </div>
	        </div>
	    </div>
	</div>

			<!-- 일정 공유 모달 -->
			<div class="modal fade" id="shareEventModal" tabindex="-1" aria-labelledby="shareEventModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="shareEventModalLabel">일정 공유</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
						    <button type="button" class="btn btn-primary" id="shareHR">인사팀</button>
						    <button type="button" class="btn btn-primary" id="shareCustomer">고객팀</button>
						    <button type="button" class="btn btn-primary" id="shareFacility">시설팀</button>
							<ul id="tree">
								<li class="card2">
									<!-- card2 데이터 여기에 추가 -->
								</li>
								<li class="customers">
									<!-- customers 데이터 여기에 추가 -->
								</li>
								<li class="config">
									<!-- config 데이터 여기에 추가 -->
								</li>
							</ul>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>			
	<!-- 삭제 확인 모달 -->
	<div class="modal fade" id="confirmDeleteModal" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="confirmDeleteModalLabel">일정 삭제 확인</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <div class="modal-body">
	                <p>일정을 삭제하시겠습니까?</p>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	                <button type="button" id="confirmDeleteBtn" class="btn btn-danger">삭제</button>
	            </div>
	        </div>
	    </div>
	</div>
	
	<!-- 수정 확인 모달 -->
	<div class="modal fade" id="editEventModal" tabindex="-1" role="dialog" aria-labelledby="editEventModalLabel" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="editEventModalLabel">일정 수정</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <div class="modal-body">
	                <form id="editEventForm">
	                    <div class="form-group">
	                        <label for="editEventTitle">제목</label>
	                        <input type="text" class="form-control" id="editEventTitle" placeholder="일정 제목">
	                    </div>
	                    <div class="form-group">
	                        <label for="editEventStart">시작 시간</label>
	                        <input type="datetime-local" class="form-control" id="editEventStart">
	                    </div>
	                    <div class="form-group">
	                        <label for="editEventEnd">종료 시간</label>
	                        <input type="datetime-local" class="form-control" id="editEventEnd">
	                    </div>
	                    <input type="hidden" id="editEventId">
	                </form>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	                <button type="button" class="btn btn-primary" id="updateEventBtn">수정하기</button>
	            </div>
	        </div>
	    </div>
	</div>
	
	<!-- 공유 확인 모달 -->
	<div class="modal fade" id="confirmShareModal" tabindex="-1" role="dialog" aria-labelledby="confirmShareModalLabel" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="confirmShareModalLabel">일정 공유 확인</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <div class="modal-body">
	                이 팀과 일정을 공유하시겠습니까?
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	                <button type="button" class="btn btn-primary" id="confirmShareBtn">확인</button>
	            </div>
	        </div>
	    </div>
	</div>
	
	<!-- 선택된 인원 알림 모달 -->
<div id="alreadySelectedModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">알림</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>이미 선택된 인원입니다!</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>
	
		</div>
	</div>

	<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js'></script>
	<script src="/js/jquery-explr-1.4.js"></script>
	<script>
		var selectedParticipants = [];

		// 조직도 불러오기 및 부서별 일정공유 버튼 클릭
		$(document).ready(function(){
		    $('#eventStart').on('change', function() {
		        // 시작 시간을 가져옴 (로컬 시간대)
		        var startDateTime = new Date($('#eventStart').val());

		        // 시작 시간에서 1시간을 더한 후 끝나는 시간을 계산 (로컬 시간대)
		        var endDateTime = new Date(startDateTime.getTime() + (10 * 60 * 60 * 1000));

		        // 끝나는 시간을 ISO 포맷으로 문자열로 변환 (로컬 시간대)
		        var endDateTimeISOString = endDateTime.toISOString().slice(0, 16); // YYYY-MM-DDTHH:mm

		        // 끝나는 시간 입력 필드에 자동으로 설정 (로컬 시간대)
		        $('#eventEnd').val(endDateTimeISOString);
		    });
		    var eventId;
		    var departmentId;
		    var isShared;
			treeCall();
		    $('#shareHR').on('click', function() {
		        eventId = $('#viewEventModal').data('eventId');
		        departmentId = '11';
		        $('#confirmShareModal').modal('show');
		    });

		    // 고객팀 버튼 클릭 시
		    $('#shareCustomer').on('click', function() {
		        eventId = $('#viewEventModal').data('eventId');
		        departmentId = '22';
		        $('#confirmShareModal').modal('show');
		    });

		    // 시설팀 버튼 클릭 시
		    $('#shareFacility').on('click', function() {
		        eventId = $('#viewEventModal').data('eventId');
		        departmentId = '33';
		        $('#confirmShareModal').modal('show');
		    });
		    $('#confirmShareBtn').on('click', function() {
		        shareEmployeesByDepartment(eventId, departmentId);
		        $('#confirmShareModal').modal('hide');
		    });

		});

		$('#shareEventModal').on('hidden.bs.modal', function () {

		});
		
		$('#viewEventModal').on('show.bs.modal', function() {
		    $('#selectedParticipantsList').empty(); // 선택된 인원 목록 비우기
		});
		
		// 조직도에서 선택된 사람들 인원추가하기!
		$('#addParticipantsBtn').on('click', function() {
		    var eventId = $('#viewEventModal').data('eventId');
		   

		    if (eventId && selectedParticipants.length > 0) {
		        // 중복 체크
		        if (hasDuplicates(selectedParticipants)) {
		            // 중복된 인원이 있을 경우 모달 띄우기
		            $('#alreadySelectedModal').modal('show');
		            return; // 중복이 있으면 더 이상 진행하지 않음
		        }
		
		        // 중복이 없으면 서버로 데이터 전송
		        $.ajax({
		            type: 'POST',
		            url: '/updateParticipants.ajax',
		            contentType: 'application/json; charset=UTF-8',
		            data: JSON.stringify({
		                id: eventId,
		                participants: selectedParticipants
		            }),
		            success: function(data) {
		                if (data.success) {
		                    alert('선택된 인원이 일정에 추가되었습니다.');
		                } else {
		                    $('#viewEventModal').modal('hide');
		                }
		            },
		            error: function(e) {
		                console.log(e);
		                alert('일정 추가 중 오류가 발생했습니다.');
		            }
		        });
		    } else {
		        alert('선택된 인원이 없습니다.');
		    }
		});
		
		
		// 중복 체크 함수
			function hasDuplicates(array) {
			    var empNoSet = new Set();
			    for (var i = 0; i < array.length; i++) {
			        var participant = array[i];
			        var empNo = participant.emp_no;
			        if (empNoSet.has(empNo)) {
			            return true; // 중복이 있으면 true 반환
			        }
			        empNoSet.add(empNo);
			    }
			    return false; // 중복이 없으면 false 반환
			}

		

		// 일정 수정 모달 키기
		$('#editParties').on('click', function() {
			$('#editEventModal').modal('show');
		});
		
		
		$('#updateEventBtn').on('click', function() {
		    // Retrieve values from modal inputs
		    var eventTitle = $('#editEventTitle').val();
		    var eventStart = $('#editEventStart').val();
		    var eventEnd = $('#editEventEnd').val();
		    var eventId = $('#editEventId').val();

			//유효성 검사
		    if (eventTitle && eventStart && eventEnd && eventId) {
		        // 데이터 준비후 제이슨 형식으로 보내기
		        var eventData = {
		            cal_content: eventTitle,
		            cal_start: eventStart,
		            cal_end: eventEnd,
		            cal_no: eventId
		        };

		        $.ajax({
		            type: 'POST',
		            url: '/editEvent',  
		            contentType: 'application/json', 
		            data: JSON.stringify(eventData),
		            success: function(data) {
		                if (data.success) {
		                    // 업데이트 되었다면 캘린더에 반영하기
		                    var event = calendar.getEventById(eventId);
		                    if (event) {
		                        event.setProp('title', eventTitle);
		                        event.setStart(eventStart);
		                        event.setEnd(eventEnd);
		                    }
		                    $('#editEventModal').modal('hide'); // 성공하면 모달 숨기기
		                    alert('일정이 성공적으로 수정되었습니다.');
		                } else {
		                    alert('일정 수정에 실패했습니다.');
		                }
		            },
		            error: function(e) {
		                console.log(e);
		                alert('일정 수정 중 오류가 발생했습니다.');
		            }
		        });
		    } else {
		        alert('일정 제목, 시작 시간, 종료 시간을 모두 입력해주세요.');
		    }
		});

		// Function to open edit event modal with event details
		function openEditEventModal(eventId, eventTitle, eventStart, eventEnd) {
		    $('#editEventId').val(eventId);
		    $('#editEventTitle').val(eventTitle);
		    $('#editEventStart').val(eventStart);
		    $('#editEventEnd').val(eventEnd);
		    $('#editEventModal').modal('show');
		}
		
		
		// 일정공유 모달 띄우기
		$('#shareEventBtn').on('click', function() {
		    $('#shareEventModal').modal('show');
		});
		
		
		// 부서 공유 버튼
		function shareEmployeesByDepartment(cal_no, department) {
		    // Ajax를 통해 해당 부서에 속한 사원 목록을 가져오는 요청을 보냅니다.
		    console.log(cal_no,department);
		    $.ajax({
		        url: '/insertEmployeesByDepartment',
		        method: 'POST',
		        contentType: 'application/json', // JSON 형식으로 데이터를 전송할 것임을 명시
		        data: JSON.stringify({ cal_no: cal_no, dept_code: department }), // JSON 문자열로 변환하여 데이터 전송
		        success: function(response) {
		            alert('사원들이 일정에 성공적으로 추가되었습니다.');
		        },
		        error: function(xhr, status, error) {
		            console.error('일정 공유 중 오류 발생:', error);
		            alert('일정 공유 중 오류가 발생했습니다.');
		        }
		    });
		}
		
		
		// 일정 공유 인원 추가하기
		function addUser(event) {
			event.preventDefault();
			var participantName = event.target.innerText;
			var empNo = $(event.target).data('emp_no');
			if (!isSelected(empNo)) {
				selectedParticipants.push({ emp_no: empNo, name: participantName });
				var listItem = '<li>' + participantName + '</li>';
				$('#selectedParticipantsList').append(listItem);
			}
		}


		// 선택된 멤버들
		function isSelected(empNo) {
		    var selected = selectedParticipants.some(function(participant) {
		        return participant.emp_no === empNo;
		    });
		    if (selected) {
		        $('#alreadySelectedModal').modal('show');
		    }
		    return selected;
		}

		// 조직도 리스트 불러오기
		function treeCall() {
			$.ajax({
				url:'/treeCall.ajax',
				method:'get',
				data:{},
				dataType:'JSON',
				success:function(data){
					drawTree(data.list);
					$("#tree").explr();
				},
				error:function(e){
					console.log(e);
				}
			})
		}

		// 조직도 불러오기
		function drawTree(list) {
			var card = '<a href="#">인사팀</a><ul>';
			var customer = '<a href="#">고객팀</a><ul>';
			var config = '<a href="#">시설팀</a><ul>';

			for (item of list) {
				if (item.dept_name == '인사팀') {
					card += '<li class="user"><a href="#" data-emp_no="' + item.emp_no + '" onclick="addUser(event);">' + item.name + '</a></li>';
				}

				if (item.dept_name == '고객팀') {
					customer += '<li class="user"><a href="#" data-emp_no="' + item.emp_no + '" onclick="addUser(event);">' + item.name + '</a></li>';
				}

				if (item.dept_name == '시설팀') {
					config += '<li class="user"><a href="#" data-emp_no="' + item.emp_no + '" onclick="addUser(event);">' + item.name + '</a></li>';
				}
			}

			card += '</ul>';
			customer += '</ul>';
			config += '</ul>';

			$('.customers').html(card);
			$('.card2').html(customer);
			$('.config').html(config);
		}


		var calendar = new FullCalendar.Calendar(document.getElementById('calendar'), {
			initialView: 'dayGridMonth',
			selectable: true,
			headerToolbar: {
				left: 'prev,next today',
				center: 'title',
				right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
			},
			buttonText: {
				today: '오늘',
				month: '월',
				week: '주',
				day: '일',
				list: '목록'
			},
			events: function(fetchInfo, successCallback, failureCallback) {
			    // 1. 사용자의 emp_no 값을 가져옵니다.
				var empNo = $('#emp_no').val();
				console.log(empNo);

				// 2. emp_no 값을 GET 요청 파라미터로 넘겨서 서버에 요청합니다.
				$.ajax({
				    url: '/getEvents',
				    method: 'GET',
				    data: { emp_no: empNo }, // emp_no를 data 객체에 추가하여 전달합니다.
				    success: function(response) {
				        // 3. 서버에서 받아온 데이터를 처리하여 FullCalendar에 전달할 events 배열로 변환합니다.
				    	var events = response.map(function(event) {
				    	    return {
				    	        id: event.cal_no,
				    	        title: event.cal_content,
				    	        start: event.cal_start,
				    	        end: event.cal_end,
				    	        backgroundColor: event.shared_status ? 'skyblue' : '',
				    	        isShared: event.shared_status,
				    	    };
				    	});

				    	// successCallback을 호출하여 FullCalendar에 events 배열을 전달합니다.
				    	successCallback(events);

				    	// events 배열을 순회하면서 isShared  있는 경우 해당 버튼을 비활성화합니다.

			        },
			        error: function(error) {
				        console.error('일정 데이터를 가져오는 중 오류가 발생했습니다.', error);
				        failureCallback(error);
				    }
				});
			},				

	        dateClick: function(info) {
	            var date = info.dateStr;
	            $('#selectedParticipantsList').empty(); // 선택된 인원 목록을 비우기

	            var hasEvent = calendar.getEvents().some(function(event) {
	                var start = event.start;
	                var end = event.end;
	                return (start <= date && date <= end) || (event.allDay && start.getDate() === date.getDate());
	            });

	            if (!hasEvent) {
	                $('#eventStart').val(date);
	                $('#eventEnd').val(date);
	                $('#addEventModal').modal('show');
	            } else {
	                var event = calendar.getEvents().find(function(event) {
	                    return event.startStr === date;
	                });

	                $('#eventDetailsTitle').text(event.title);
	                $('#eventDetailsStart').text(event.startStr);
	                $('#eventDetailsEnd').text(event.endStr);

	                // isShared 값에 따라 다른 모달창을 보여줌

	            }
	        },
			eventClick: function(info) {
	            var eventId = info.event.id;
	            var empNo = $('#emp_no').val(); // emp_no 값을 가져옴

	            
	            var startDate = new Date(info.event.start).toLocaleString('ko-KR', {
	                year: 'numeric',
	                month: '2-digit',
	                day: '2-digit',
	                hour: '2-digit',
	                minute: '2-digit',
	                hour12: false
	            }).replace(/\./g, '-').replace(' ', '').replace(/-/g, '-').replace(/\s/g, '');

	            var endDate = new Date(info.event.end).toLocaleString('ko-KR', {
	                year: 'numeric',
	                month: '2-digit',
	                day: '2-digit',
	                hour: '2-digit',
	                minute: '2-digit',
	                hour12: false
	            }).replace(/\./g, '-').replace(' ', '').replace(/-/g, '-').replace(/\s/g, '');
	            
	            
				$('#eventDetailsTitle').text(info.event.title);
                $('#eventDetailsStart').text(startDate);
                $('#eventDetailsEnd').text(endDate);
			    $('#selectedParticipantsList').empty(); // 선택된 인원 목록을 비우기
			  

		$.ajax({
		    type: 'GET',
		    url: '/getEvent', // 서버에서 cal_no에 해당하는 데이터를 가져오는 엔드포인트
		    data: { emp_no: empNo, cal_no: eventId }, // cal_no 전송
		    success: function(data) {
		        // 받은 데이터로 모달 내용을 업데이트하거나 추가 처리
		        console.log('추가 데이터:', data);
		        console.log("ㅎㅇㅎㅇ : " + data.shared_status);
		        
		        // shared_status 값이 'true'인지 확인
				if (data.shared_status === true && data.emp_no != empNo ) {
                    $('#viewEventModal').modal('show');
                    $('#viewEventModal').data('eventId', eventId);
				  $('#deleteEventBtn').prop('disabled', true);
				  $('#shareEventBtn').prop('disabled', true);  
				  $('#editParticipantsBtn').prop('disabled', true);
				  $('#addParticipantsBtn').prop('disabled', true);
				  $('#editParties').prop('disabled', true);
				  
				} else {
                    $('#viewEventModal').modal('show');
                    $('#viewEventModal').data('eventId', eventId);
				  $('#deleteEventBtn').prop('disabled', false);
				  $('#editParticipantsBtn').prop('disabled', false);
				  $('#shareEventBtn').prop('disabled', false);  
				  $('#addParticipantsBtn').prop('disabled', false);
				  $('#editParties').prop('disabled', false);
				}
		    },
		    error: function(e) {
		        console.log('추가 데이터 가져오기 오류:', e);
		    }
		});
	    if (eventId) {
	        $.ajax({
	            type: 'GET',
	            url: '/getEventParticipants',
	            data: { id: eventId },
	            success: function(data) {
	                $('#sharedParticipantsList').empty(); // 기존 목록을 비웁니다.

	                // 컨트롤러에서 전달받은 data 배열을 직접 사용합니다.
	                data.forEach(function(name) {
	                    var listItem = '<li>' + name + '</li>';
	                    $('#sharedParticipantsList').append(listItem);
	                });
	            },
	            error: function(e) {
	                console.log(e);
	                alert('일정 공유된 인원을 불러오는 중 오류가 발생했습니다.');
	            }
	        });
	    }
			    
			}
		});

		calendar.render();
        
        

		
		$('#saveEventBtn').on('click', function() {
		    var eventTitle = $('#eventTitle').val();
		    var eventStart = $('#eventStart').val();
		    var eventEnd = $('#eventEnd').val();
		    var empNo = $('#emp_no').val();

		    // 시작일과 종료일을 Date 객체로 변환
		    var startDate = new Date(eventStart);
		    var endDate = new Date(eventEnd);

		    if (eventTitle && eventStart && eventEnd && empNo) {
		        // 시작일이 종료일보다 클 경우 경고창 띄우기
		        if (startDate > endDate) {
		            alert('시작일이 종료일보다 클 수 없습니다.');
		        } else {
		            $.ajax({
		                type: 'POST',
		                url: '/addEvent',
		                data: {
		                    cal_content: eventTitle,
		                    cal_start: eventStart,
		                    cal_end: eventEnd,
		                    emp_no: empNo
		                },
		                success: function(data) {
		                    if (data.success) {
		                        calendar.addEvent({
		                            title: eventTitle,
		                            start: eventStart,
		                            end: eventEnd
		                        });

		                        $('#addEventModal').modal('hide');
		                        $('#eventTitle').val('');
		                        $('#eventStart').val('');
		                        $('#eventEnd').val('');
		                    } else {
		                        alert('일정 추가에 실패했습니다.');
		                    }
		                },
		                error: function(e) {
		                    console.log(e);
		                    alert('일정 추가 중 오류가 발생했습니다.');
		                }
		            });
		        }
		    } else {
		        alert('일정 제목, 시작 시간, 종료 시간을 모두 입력해주세요.');
		    }
		});
		
		$('#deleteParties').on('click', function() {
			var eventId = $('#viewEventModal').data('eventId');

			if (eventId) {
				$.ajax({
					type: 'POST',
					url: '/deleteParties',
					data: { id: eventId },
					success: function(data) {
						if (data.success) {
							$('#viewEventModal').modal('hide');
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
		});

		$('#deleteEventBtn').on('click', function() {
		    var eventId = $('#viewEventModal').data('eventId');
			console.log('ddd' + eventId);
		    if (eventId) {
		        // 삭제 확인 모달 보이기
		        $('#confirmDeleteModal').modal('show');

		        // 삭제 확인 버튼 클릭 시 이벤트
		        $('#confirmDeleteBtn').on('click', function() {
		            $.ajax({
		                type: 'POST',
		                url: '/deleteEvent',
		                data: { id: eventId },
		                success: function(data) {
		                    if (data.success) {
		                        calendar.getEventById(eventId).remove();
		                        $('#viewEventModal').modal('hide');
		                    } else {
		                        alert('일정 삭제에 실패했습니다.');
		                    }
		                },
		                error: function(e) {
		                    console.log(e);
		                    alert('일정 삭제 중 오류가 발생했습니다.');
		                }
		            });

		            // 삭제 처리 후 모달 닫기
		            $('#confirmDeleteModal').modal('hide');
		        });
		    }
		});
	</script>
</body>
</html>
