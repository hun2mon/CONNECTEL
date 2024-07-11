<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>호텔 일정</title>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.11.3/main.min.css"
	rel="stylesheet" />
<link href="/css/jquery-explr-1.4.css" rel="stylesheet" type="text/css">
<style>
#calendar {
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
	width: 81%;
	height: 100%;
	margin-left: 320px;
	margin-right: 150px;
	margin-top: 122px;
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

.sssss {
	display: flex;
	width: 500px;
}

@media ( min-width : 992px) {
	.container {
		max-width: 1540px !important;
	}
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
				<div class="sssss">
					<div class="circle-test"></div>
					<span>내 일정</span> &nbsp;&nbsp;
					<div class="circle-test1"></div>
					<span>공유 일정</span>
				</div>
				<div id='calendar'></div>
			</div>
			<input type="hidden" id="emp_no" name="emp_no"
				value="${sessionScope.loginInfo.emp_no}">

			<!-- 일정 추가 모달 -->
			<div class="modal fade" id="addEventModal" tabindex="-1"
				aria-labelledby="addEventModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="addEventModalLabel">일정 추가</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<form id="addEventForm">
								<input type="hidden" id="emp_no" name="emp_no"
									value="${sessionScope.loginInfo.emp_no}">
								<div class="form-group">
									<label for="eventTitle">제목</label> <input type="text"
										class="form-control" id="eventTitle" placeholder="일정 제목 입력">
								</div>
								<div class="form-group">
									<label for="eventStart">시작 시간</label> <input
										type="datetime-local" class="form-control" id="eventStart">
								</div>
								<div class="form-group">
									<label for="eventEnd">종료 시간</label> <input
										type="datetime-local" class="form-control" id="eventEnd">
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox"
										id="allDayCheckbox"> <label class="form-check-label"
										for="allDayCheckbox"> 종일 이벤트 </label>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary" id="saveEventBtn">저장</button>
						</div>
					</div>
				</div>
			</div>


			<!-- 일정 상세 보기 모달 -->
			<div class="modal fade" id="viewEventModal" tabindex="-1"
				aria-labelledby="viewEventModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<!-- modal-lg: 큰 사이즈 모달 -->
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="viewEventModalLabel">일정 상세 보기</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<input type="hidden" id="editEventId">

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
								<ul id="sharedParticipantsList"></ul>
								<!-- 인원 목록을 표시할 ul 요소 -->
							</div>
							<!-- 일정 공유 버튼 -->
							<button type="button" class="btn btn-primary mt-3 mb-3"
								id="shareEventBtn">인원추가</button>
							<!-- 선택된 인원 표시할 영역 -->
							<ul id="selectedParticipantsList"></ul>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger" id="deleteEventBtn">삭제</button>
							<button type="button" class="btn btn-success"
								id="editParticipantsBtn" style="display: none;">일정 공유
								수정</button>
							<button type="button" class="btn btn-success"
								id="addParticipantsBtn">일정 공유</button>
							<button type="button" class="btn btn-success" id="editParties">수정</button>
						</div>
					</div>
				</div>
			</div>



			<!-- 일정 수정 모달 -->
			<div class="modal fade" id="editEventModal" tabindex="-1"
				aria-labelledby="editEventModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="editEventModalLabel">일정 수정</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>

						<div class="modal-body">
							<form id="editEventForm">
								<div class="form-group">
									<label for="editEventTitle">제목</label> <input type="text"
										class="form-control" id="editEventTitle"
										placeholder="일정 제목 입력">
								</div>
								<div class="form-group">
									<label for="editEventStart">시작 시간</label> <input
										type="datetime-local" class="form-control" id="editEventStart">
								</div>
								<div class="form-group">
									<label for="editEventEnd">종료 시간</label> <input
										type="datetime-local" class="form-control" id="editEventEnd">
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary" id="updateEventBtn">저장</button>
						</div>
					</div>
				</div>
			</div>

			<!-- 일정 공유 모달 -->
			<div class="modal fade" id="shareEventModal" tabindex="-1"
				aria-labelledby="shareEventModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="shareEventModalLabel">일정 공유</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
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
							<button type="button" class="btn btn-primary" id="deleteParties">일정
								참여자 삭제</button>
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>

			<!-- 삭제 확인 모달 -->
			<div class="modal fade" id="confirmDeleteModal" tabindex="-1"
				role="dialog" aria-labelledby="confirmDeleteModalLabel"
				aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="confirmDeleteModalLabel">일정 삭제
								확인</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<p>일정을 삭제하시겠습니까?</p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">취소</button>
							<button type="button" id="confirmDeleteBtn"
								class="btn btn-danger">삭제</button>
						</div>
					</div>
				</div>
			</div>


			<!-- 공유 확인 모달 -->
			<div class="modal fade" id="confirmShareModal" tabindex="-1"
				role="dialog" aria-labelledby="confirmShareModalLabel"
				aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="confirmShareModalLabel">일정 공유 확인</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">이 팀과 일정을 공유하시겠습니까?</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary"
								id="confirmShareBtn">확인</button>
						</div>
					</div>
				</div>
			</div>

			<!-- 선택된 인원 알림 모달 -->
			<div id="alreadySelectedModal" class="modal fade" tabindex="-1"
				role="dialog">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">알림</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<p>이미 선택된 인원입니다!</p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>

			<!-- 선택된 인원 알림 모달 -->
			<div id="SelectedModal" class="modal fade" tabindex="-1"
				role="dialog">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">알림</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<p id="selectedCountMessage">일정 공유되었습니다!</p>
						</div>
						<div class="modal-footer">
							<button type="button" id="addParticipantsBtnn"
								class="btn btn-primary" data-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
	<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js'></script>
	<script src="/js/jquery-explr-1.4.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>	
	
	<script>
	$.noConflict();

	var selectedParticipants = [];
	var sharedParticipants = [];
		// 조직도 불러오기 및 부서별 일정공유 버튼 클릭
	jQuery(document).ready(function($) {
	    function getParameterByName(name) {
	        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	            results = regex.exec(location.search);
	        return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	    }
	    var calNo = getParameterByName('cal_no');
	    console.log(calNo + '캘노 ㅇㅇㅇ');
        $('#viewEventModal').data('eventId', calNo);

	    if (calNo) {
	        $.ajax({
	            url: '/calendar/mainDetail',
	            type: 'GET',
	            data: {
	                cal_no: calNo
	            },
	            success: function(response) {
	                console.log(response); // 응답 데이터 확인
	                if (response) {
	                    var $response = $(response);
	                    var calContent = $response.find('.cal_content').text();
	                    var calStart = $response.find('.cal_start').text();
	                    var calEnd = $response.find('.cal_end').text();
	                    console.log(calContent, calStart, calEnd);
	                    $('#viewEventModal').modal('show');
	                    $('#eventDetailsTitle').text(calContent);
	                    $('#eventDetailsStart').text(calStart);
	                    $('#eventDetailsEnd').text(calEnd);
	                    $('#viewEventModal').data('eventId');
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error('AJAX 요청 실패:', error);
	            }
	        });
	    } else {
	        console.log('cal_no 파라미터가 없음');
	    }
			
			
		    $('#eventStart').on('change', function() {
		        var startTime = $(this).val();
		        if (startTime) {
		            endTime.setHours(endTime.getHours() + 10);
		            $('#eventEnd').val(endTime.toISOString().substr(11, 5));
		        }
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

		$('#viewEventModal').on('hidden.bs.modal', function () {
	        $('#selectedParticipantsList').empty();
	        $('#sharedParticipantsList').empty();
	        selectedParticipants = []; // 목록 초기화
		});
		
		   $('#viewEventModal').on('show.bs.modal', function() {
			    var eventId = $('#viewEventModal').data('eventId');
		    });

		
		// 조직도에서 선택된 사람들 인원추가하기!
		
		$('#addParticipantsBtn').on('click', function() {
	            $('#SelectedModal').modal('show');
		    });
		
		$('#addParticipantsBtnn').on('click', function() {
		    var eventId = $('#viewEventModal').data('eventId');
		    console.log('Event ID:', eventId); // 디버깅을 위해 추가
		    if (eventId && selectedParticipants.length > 0) {
		        if (hasDuplicates(selectedParticipants)) {
		            // 중복된 인원이 있을 경우 모달 띄우기
		            $('#alreadySelectedModal').modal('show');
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
		                    $('#SelectedModal').modal('hide');
		                    $('#viewEventModal').modal('hide');
		                    $('#selectedParticipantsList').empty();
		                    $('#sharedParticipantsList').empty();
		        	        selectedParticipants = []; // 목록 초기화
		                } else {
		                    $('#viewEventModal').modal('hide');
		                }
		            },
		            error: function(e) {
		                console.log(e);
		                alert('일정 추가 중 오류가 발생했습니다.');
		            }
		        }); 
		    }
		    else {
		        alert('선택된 인원이 없습니다.');
		    }
		});
		
		
		// 중복 체크 함수 (참여자)
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

		
		
		$('#updateEventBtn').on('click', function() {
		    // Retrieve values from modal inputs
	    	var eventId = $('#viewEventModal').data('eventId');
		    var eventTitle = $('#editEventTitle').val();
		    var eventStart = $('#editEventStart').val();
		    var eventEnd = $('#editEventEnd').val();
		    console.log("eventid " + eventId);
		    console.log("eventTitle " + eventTitle);
		    console.log("eventStart " + eventStart);
		    console.log("eventEnd " + eventEnd);

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
								calendar.refetchEvents();
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
                    alert('참여자가 성공적으로 추가되었습니다.');
                    $('#SelectedModal').modal('hide');
                    $('#viewEventModal').modal('hide');
                    selectedParticipants = []; // 초기화
                    $('#selectedParticipantsList').empty();
                    $('#sharedParticipantsList').empty();
		        },
		        error: function(xhr, status, error) {
		            console.error('일정 공유 중 오류 발생:', error);
		            alert('일정 공유 중 오류가 발생했습니다.');
		        }
		    });
		}
		
	    $('#editParties').on('click', function() {
	        // Retrieve values from modal inputs
	        var eventId = $('#viewEventModal').data('eventId');
	        console.log("eventid " + eventId);
            $('#editEventModal').modal('show');

	    });
	    function convertToLocalTimeMinus4Hours(isoDateString) {
	        var date = new Date(isoDateString);
	        date.setHours(date.getHours() + 18);
	        var localDate = new Date(date.getTime() + (date.getTimezoneOffset() * 60000)); // UTC 시간대에서 로컬 시간대로 변환
	        return localDate.toISOString().slice(0, 16); // YYYY-MM-DDTHH:mm 형식으로 반환
	    }
	    
	    $('#editEventModal').on('show.bs.modal', function() {
	        var eventId = $('#viewEventModal').data('eventId'); // 이벤트 ID 가져오기
	        console.log("EEEEEE eventId: " + eventId);

	        $.ajax({
	            type: 'GET',
	            url: '/getDays',
	            data: { cal_no: eventId },
	            success: function(response) {
	                console.log("Response: ", response);

	                if (response && response.length > 0) {
	                    var eventDetails = response[0]; // 첫 번째 이벤트 데이터 사용

	                    // 제목 입력 필드 업데이트
	                    if ($('#editEventTitle').length > 0) {
	                        $('#editEventTitle').val(eventDetails.cal_content);
	                        console.log('Title:', $('#editEventTitle').val());
	                    } else {
	                        console.error('Title field not found');
	                    }

	                    // 시작 시간 입력 필드 업데이트
	                    if ($('#editEventStart').length > 0) {
	                        var startFormatted = convertToLocalTimeMinus4Hours(eventDetails.cal_start);
	                        $('#editEventStart').val(startFormatted);
	                        console.log('Start:', $('#editEventStart').val());
	                    } else {
	                        console.error('Start field not found');
	                    }

	                    // 종료 시간 입력 필드 업데이트
	                    if ($('#editEventEnd').length > 0) {
	                        var endFormatted = convertToLocalTimeMinus4Hours(eventDetails.cal_end);
	                        $('#editEventEnd').val(endFormatted);
	                        console.log('End:', $('#editEventEnd').val());
	                    } else {
	                        console.error('End field not found');
	                    }
	                } else {
	                    console.error('No response data or empty response');
	                }
	            },
	            error: function(e) {
	                console.log('Error fetching event details:', e);
	                alert('일정 정보를 가져오는 데 실패했습니다.');
	            }
	        });
	    });
		
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
		
		function isShared(name) {
		    var shared = sharedParticipants.some(function(participant) {
		        return participant.name === name;
		    });
		    if (shared) {
		        $('#alreadySelectedModal').modal('show');
		    }
		    return shared;
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


		document.addEventListener('DOMContentLoaded', function() {
		    var calendarEl = document.getElementById('calendar');
		    var calendar = new FullCalendar.Calendar(calendarEl, {
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
		        events: function (fetchInfo, successCallback, failureCallback) {
		            var empNo = $('#emp_no').val();
		            $.ajax({
		                url: '/getEvents',
		                method: 'GET',
		                data: { emp_no: empNo },
		                success: function(response) {
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
		                    successCallback(events);
		                },
		                error: function(error) {
		                    console.error('일정 데이터를 가져오는 중 오류가 발생했습니다.', error);
		                    failureCallback(error);
		                }
		            });
		        },
		        dayMaxEventRows: true, // 하루에 최대 일정 수를 제한하여 보여줍니다.
		        dateClick: function(info) {		        	
		            var date = info.dateStr;
		            console.log('Clicked date:', date);
		            		            
		            $('#allDayCheckbox').prop('checked', false);

		            var startDateTime = date + 'T09:00';
		            var endDateTime = date + 'T10:00';
		            console.log('Start DateTime:', startDateTime);
		            $('#eventStart').val(startDateTime);
		            $('#eventEnd').val(endDateTime);
		            
		            // 콘솔에서 입력 필드의 값을 확인
		            console.log('eventStart value:', $('#eventStart').val());
		            console.log('eventEnd value:', $('#eventEnd').val());


		            var hasEvent = calendar.getEvents().some(function(event) {
		                var start = event.start;
		                var end = event.end;
		                return (start <= date && date <= end) || (event.allDay && start.getDate() === new Date(date).getDate());
		            });

		            if (!hasEvent) {
		                $('#addEventModal').modal('show');
		            } else {
		                var event = calendar.getEvents().find(function(event) {
		                    return event.startStr === date;
		                });
		                $('#eventDetailsTitle').text(event.title);
		                $('#eventDetailsStart').text(event.startStr);
		                $('#eventDetailsEnd').text(event.endStr);
		            }
		        },
                eventClick: function(info) {
                    var eventId = info.event.id;
                    console.log("이벤트아이디!!"+eventId);
                    var empNo = $('#emp_no').val();
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
                    $.ajax({
                        type: 'GET',
                        url: '/getEvent',
                        data: { emp_no: empNo, cal_no: eventId },
                        success: function(data) {
                            console.log('추가 데이터:', data);
                            if (data.shared_status === true && data.emp_no != empNo) {
                                $('#viewEventModal').modal('show');
                                $('#viewEventModal').data('eventId', eventId);
                                $('#deleteEventBtn').prop('disabled', true).css('display', 'none');
                                $('#shareEventBtn').prop('disabled', true).css('display', 'none');
                                $('#addParticipantsBtn').prop('disabled', true).css('display', 'none');
                                $('#editParties').prop('disabled', true).css('display', 'none');
                                $('.removeParticipantBtn').prop('disabled', true).css('display', 'none');
                            } else {
                                $('#viewEventModal').modal('show');
                                $('#viewEventModal').data('eventId', eventId);
                                $('#deleteEventBtn').prop('disabled', false).css('display', 'inline-block');
                                $('#shareEventBtn').prop('disabled', false).css('display', 'inline-block');
                                $('#addParticipantsBtn').prop('disabled', false).css('display', 'inline-block');
                                $('#editParties').prop('disabled', false).css('display', 'inline-block');
                                $('.removeParticipantBtn').prop('disabled', false).css('display', 'inline-block');                                
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

                                data.forEach(function(name) {
                                    var listItem = '<li>' + '<input type = "hidden" value = "'+name.emp_no+'" name = "emp_no">'+name + ' <button type="button" style="background-color: white; border: white; color:red;" class="btn btn-danger btn-sm removeParticipantBtn">x</button></li>';
                                    $('#sharedParticipantsList').append(listItem);
                                    console.log(listItem);
                                });

                                $('.removeParticipantBtn').click(function() {
                                    var participantName = $(this).parent().text().replace(' x', '');
                                    $(this).parent().remove();
                                    $.ajax({
                                        type: 'POST',
                                        url: '/removeEventParticipant',
                                        data: { eventId: eventId, name: participantName },
                                        success: function(response) {
                                            console.log('참가자가 성공적으로 삭제되었습니다.');
                                        },
                                        error: function(e) {
                                            console.log(e);
                                            alert('참가자를 삭제하는 중 오류가 발생했습니다.');
                                        }
                                    });
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
		    window.calendar = calendar;
            calendar.render();
            

            
            
            
            $('#allDayCheckbox').on('change', function() {
                var isAllDay = $(this).prop('checked'); // 종일 이벤트 체크 여부

                // 시작일과 종료일 입력 필드 값 가져오기
                var eventStartValue = $('#eventStart').val();
                var eventEndValue = $('#eventEnd').val();

                if (isAllDay) {
                    // 종일 이벤트인 경우 시간 정보를 제거
                    var startDate = new Date(eventStartValue);
                    startDate.setHours(09, 0, 0, 0); // 시작일의 시간을 00:00:00으로 설정
                    $('#eventStart').val(startDate.toISOString().slice(0, 16));

                    var endDate = new Date(eventEndValue);
                    endDate.setHours(32, 59, 59, 999); // 종료일의 시간을 23:59:59.999로 설정
                    $('#eventEnd').val(endDate.toISOString().slice(0, 16));
                } else {
                    // 종일 이벤트가 아닌 경우 기존에 설정된 값으로 초기화
                    $('#eventStart').val(eventStartValue);
                    $('#eventEnd').val(eventEndValue);
                }
            });

            $('#addEventModal').on('show.bs.modal', function(event) {
                // 모달이 열릴 때마다 날짜 입력 필드의 값을 초기화
				
                var isAllDay = $('#allDayCheckbox').prop('checked'); // 종일 이벤트 체크 여부
                
                // 클릭 이벤트에서 설정한 값 가져오기
                var eventStartValue = $('#eventStart').val();
                var eventEndValue = $('#eventEnd').val();
                
                if (isAllDay) {
                    // 종일 이벤트인 경우 시간 정보를 제거
                    var startDate = new Date(eventStartValue);
                    startDate.setHours(0, 0, 0, 0); // 시작일의 시간을 00:00:00으로 설정
                    $('#eventStart').val(startDate.toISOString().slice(0, 16));

                    var endDate = new Date(eventEndValue);
                    endDate.setHours(23, 59, 59, 999); // 종료일의 시간을 23:59:59.999로 설정
                    $('#eventEnd').val(endDate.toISOString().slice(0, 16));
                } else {
                    // 종일 이벤트가 아닌 경우, 기존에 설정된 값으로 초기화
                    if (eventStartValue && eventEndValue) {
                        $('#eventStart').val(eventStartValue);
                        $('#eventEnd').val(eventEndValue);
                    } else {
                        $('#eventStart').val('');
                        $('#eventEnd').val('');
                    }
                }
                
                // 이벤트 제목 필드는 항상 초기화
                $('#eventTitle').val('');
            });
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
		                            $('#addEventModal').modal('hide');
		                            $('#eventTitle').val('');
		                            $('#eventStart').val('');
		                            $('#eventEnd').val('');
		                            calendar.refetchEvents();
		                            
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
		                        $('#shareEventModal').modal('hide');
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
		        console.log('삭제할 이벤트 ID:', eventId);
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
		});		
</script>
</body>
</html>