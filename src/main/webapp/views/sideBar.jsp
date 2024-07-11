<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="/assets/extra-libs/c3/c3.min.css" rel="stylesheet">
<link href="/assets/extra-libs/jvector/jquery-jvectormap-2.0.2.css"
	rel="stylesheet" />
<link rel="shortcut icon" href="#">
<!-- Custom CSS -->
<link href="/dist/css/style.min.css" rel="stylesheet">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
	integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="/assets/libs/jquery/dist/jquery.min.js"></script>
<script src="/assets/libs/popper.js/dist/umd/popper.min.js"></script>
<script src="/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- apps -->
<!-- apps -->
<script src="/dist/js/app-style-switcher.js"></script>
<script src="/dist/js/feather.min.js"></script>
<script src="/assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
<script src="/dist/js/sidebarmenu.js"></script>
<!--Custom JavaScript -->
<script src="/dist/js/custom.min.js"></script>
<!--This page JavaScript -->
<script src="/assets/extra-libs/c3/d3.min.js"></script>
<script src="/assets/extra-libs/c3/c3.min.js"></script>
<script src="/assets/extra-libs/jvector/jquery-jvectormap-2.0.2.min.js"></script>
<script
	src="/assets/extra-libs/jvector/jquery-jvectormap-world-mill-en.js"></script>
<style>
.sidebar{
	width: 260px;
}

.content{
    flex-grow: 1;
    padding: 20px;
    overflow-y: auto;
    margin-top: 81px;
}

.parent{
	display: flex;
}
</style>
</head>
<body>

	<div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>

	<div id="main-wrapper" data-theme="light" data-layout="vertical"
		data-navbarbg="skin6" data-sidebartype="full"
		data-sidebar-position="fixed" data-header-position="fixed"
		data-boxed-layout="full">
		<!-- ============================================================== -->
		<!-- Topbar header - style you can find in pages.scss -->
		<!-- ============================================================== -->
		<header class="topbar" data-navbarbg="skin6">
			<nav class="navbar top-navbar navbar-expand-md">
				<div class="navbar-header" data-logobg="skin6">
					<!-- This is for the sidebar toggle which is visible on mobile only -->
					<a class="nav-toggler waves-effect waves-light d-block d-md-none"
						href="javascript:void(0)"><i class="ti-menu ti-close"></i></a>
					<!-- ============================================================== -->
					<!-- Logo -->
					<!-- ============================================================== -->
					<div class="navbar-brand">
						<!-- Logo icon -->
						<a href="/main"> <b class="logo-icon"> <!-- Dark Logo icon -->
								<img src="/assets/images/CONNECTEL-logo.png" alt="homepage"
								class="dark-logo" width="200px" />
						</b>
						</a>
					</div>
					<input type = "hidden" id = "authority" value = "${sessionScope.loginInfo.authority}">
					<input type = "hidden" id = "dept_code" value = "${sessionScope.loginInfo.dept_code}">
					<!-- ============================================================== -->
					<!-- End Logo -->
					<!-- ============================================================== -->
					<!-- ============================================================== -->
					<!-- Toggle which is visible on mobile only -->
					<!-- ============================================================== -->
					<a class="topbartoggler d-block d-md-none waves-effect waves-light"
						href="javascript:void(0)" data-toggle="collapse"
						data-target="#navbarSupportedContent"
						aria-controls="navbarSupportedContent" aria-expanded="false"
						aria-label="Toggle navigation"><i class="ti-more"></i></a>
				</div>
				<!-- ============================================================== -->
				<!-- End Logo -->
				<!-- ============================================================== -->
				<div class="navbar-collapse collapse" id="navbarSupportedContent">
					<!-- ============================================================== -->
					<!-- toggle and nav items -->
					<!-- ============================================================== -->
					<ul class="navbar-nav float-left mr-auto ml-3 pl-1">
						<!-- Notification -->
	<li class="nav-item dropdown">
	    <a class="nav-link dropdown-toggle pl-md-3 position-relative"
	       href="javascript:void(0)" id="bell" role="button"
	       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	        <span><i data-feather="bell" class="svg-icon"></i></span>
	        <span class="badge badge-primary notify-no rounded-circle">0</span>
	    </a>
	    <div class="dropdown-menu dropdown-menu-left mailbox animated bounceInDown">
	        <ul class="list-style-none">
	            <li>
	                <div class="message-center notifications position-relative" id="notificationList">
							
	                </div>
	            </li>
	            <li>
	                <a class="nav-link pt-3 text-center text-dark" href="javascript:void(0);">
	                    <strong>Check all notifications</strong>
	                    <i class="fa fa-angle-right"></i>
	                </a>
	            </li>
	        </ul>
	    </div>
	</li>
    <input type = "hidden" name = "emp_no" value = "${sessionScope.loginInfo.emp_no}">
						<!-- End Notification -->
						<!-- ============================================================== -->
						<!-- create new -->
						<!-- ============================================================== -->
					</ul>
					<!-- ============================================================== -->
					<!-- Right side toggle and nav items -->
					<!-- ============================================================== -->
					<ul class="navbar-nav float-right">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="javascript:void(0)"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<img src="/assets/images/users/profile-pic.jpg" alt="user"
								class="rounded-circle" width="40"> <span
								class="ml-2 d-none d-lg-inline-block"><span>Hello,</span>
									<span class="text-dark">${sessionScope.loginInfo.name}</span> <i data-feather="chevron-down" class="svg-icon"></i></span>
						</a>
							<div
								class="dropdown-menu dropdown-menu-right user-dd animated flipInY">
								<a class="dropdown-item" href="/profile/profile.go"><i
									data-feather="user" class="svg-icon mr-2 ml-1"></i> My Profile</a>
								<a class="dropdown-item" href="/logout.do"><i
									data-feather="power" class="svg-icon mr-2 ml-1"></i> Logout</a>
							</div></li>
						<!-- ============================================================== -->
						<!-- User profile and search -->
						<!-- ============================================================== -->
					</ul>
				</div>
			</nav>
		</header>
		<!-- ============================================================== -->
		<!-- End Topbar header -->
		<!-- ============================================================== -->
		<!-- ============================================================== -->
		<!-- Left Sidebar - style you can find in sidebar.scss  -->
		<!-- ============================================================== -->
		<aside class="left-sidebar" data-sidebarbg="skin6">
			<!-- Sidebar scroll-->
			<div class="scroll-sidebar" data-sidebarbg="skin6">
				<!-- Sidebar navigation-->
				<nav class="sidebar-nav">
					<ul id="sidebarnav">
						<li class="sidebar-item"><a class="sidebar-link sidebar-link"
							href="/main" aria-expanded="false"><i
								data-feather="home" class="feather-icon"></i><span
								class="hide-menu">대시보드</span></a></li>

						<li class="sidebar-item"><a class="sidebar-link sidebar-link"
							href="/room/liveRoomManage.go" aria-expanded="false"><i
								class="fa-solid fa-people-roof"></i><span class="hide-menu">실시간
									객실 모니터링</span></a></li>


						<li class="sidebar-item"><a class="sidebar-link has-arrow" href="javascript:void(0)"
							aria-expanded="false"><i
								class="fa-solid fa-hotel"></i><span class="hide-menu">예약/투숙
									관리 </span></a>
							<ul aria-expanded="false"
								class="collapse first-level base-level-line">
								<li class="sidebar-item"><a href="/guest/proxyReserve.go"
									class="sidebar-link"><span class="hide-menu"> 예약 </span></a></li>
								<li class="sidebar-item"><a href="/guest/reserveManage.go"
									class="sidebar-link"><span class="hide-menu"> 예약리스트 </span></a></li>
								<li class="sidebar-item"><a
									href="/guest/stayManage.go" class="sidebar-link"><span
										class="hide-menu"> 투숙리스트 </span></a></li>
							</ul></li>

						<li class="sidebar-item"><a class="sidebar-link has-arrow"
							href="javascript:void(0)" aria-expanded="false"><i
								class="fa-solid fa-pen-nib"></i><span class="hide-menu">전자결재
							</span></a>
							<ul aria-expanded="false"
								class="collapse first-level base-level-line">
								<li class="sidebar-item"><a href="/approval/draftForm.go"
									class="sidebar-link"><span class="hide-menu"> 기안서 작성
									</span></a></li>

								<li class="sidebar-item"><a
									href="/approval/myApproval.go" class="sidebar-link"><span
										class="hide-menu"> 내 기안서 </span></a></li>

								<li class="sidebar-item"><a
									href="/approval/requestApproval.go" class="sidebar-link"><span
										class="hide-menu"> 결재 요청 문서 </span></a></li>
										
										<li class="sidebar-item"><a
									href="/approval/availableViewList.go" class="sidebar-link"><span
										class="hide-menu"> 열람 가능한 문서 </span></a></li>
							</ul></li>

						<li class="sidebar-item"><a class="sidebar-link has-arrow"
							href="javascript:void(0)" aria-expanded="false"><i
								class="fa-solid fa-envelope"></i><span class="hide-menu">메일
							</span></a>
							<ul aria-expanded="false"
								class="collapse first-level base-level-line">
								<li class="sidebar-item"><a href="/mail/sendMail.go"
									class="sidebar-link"><span class="hide-menu"> 메일 보내기
									</span></a></li>

								<li class="sidebar-item"><a
									href="/mail/sendMailList.go" class="sidebar-link"><span
										class="hide-menu"> 보낸 메일함 </span></a></li>

								<li class="sidebar-item"><a
									href="/mail/tempMailList.go" class="sidebar-link"><span
										class="hide-menu"> 임시 보관함 </span></a></li>
							</ul></li>

						<li class="sidebar-item"><a class="sidebar-link sidebar-link"
							href="/calendar/calendar.go" aria-expanded="false"><i
								class="fa-regular fa-calendar-days"></i><span class="hide-menu">캘린더</span></a>
						</li>

						<li class="sidebar-item"><a class="sidebar-link sidebar-link"
							href="/messenger/messenger.go" aria-expanded="false"><i
								class="fa-solid fa-comments"></i><span class="hide-menu">메신저</span></a>
						</li>

						<li class="sidebar-item"><a class="sidebar-link has-arrow"
							href="javascript:void(0)" aria-expanded="false"><i
								class="fa-solid fa-user"></i><span class="hide-menu">인사관리
							</span></a>
							<ul aria-expanded="false"
								class="collapse first-level base-level-line">
								<li class="sidebar-item" id = "empList"><a href="/emp/empList.go"
									class="sidebar-link"><span class="hide-menu"> 직원 목록
									</span></a></li>

								<li class="sidebar-item" id = "empRegist"><a href="/emp/empRegist.go"
									class="sidebar-link"><span class="hide-menu"> 직원 등록
									</span></a></li>
							</ul></li>

						<li class="sidebar-item"><a class="sidebar-link has-arrow"
							href="javascript:void(0)" aria-expanded="false"><i
								class="fa-solid fa-gears"></i><span class="hide-menu">객실 관리</span></a>
							<ul aria-expanded="false"
								class="collapse first-level base-level-line">
								<li class="sidebar-item"><a href="/room/roomInfoUpdate.go"
									class="sidebar-link"><span class="hide-menu">객실 정보</span></a></li>
								<li class="sidebar-item"><a href="/room/roomList.go"
									class="sidebar-link"><span class="hide-menu">객실 리스트</span></a></li>
								<li class="sidebar-item"><a href="/room/roomPriceSet.go"
									class="sidebar-link"><span class="hide-menu">객실 가격 설정</span></a></li>
								<li class="sidebar-item"><a href="/room/roomPriceCalendar.go"
									class="sidebar-link"><span class="hide-menu">객실 가격 캘린더</span></a></li>
								<li class="sidebar-item"><a href="/room/roomManageList.go"
									class="sidebar-link"><span class="hide-menu">객실 관리 내역</span></a></li>
							</ul></li>

						<li class="sidebar-item"><a class="sidebar-link has-arrow"
							href="index.html" aria-expanded="false"><i
								class="fa-solid fa-clipboard"></i><span class="hide-menu">게시판
							</span></a>
							<ul aria-expanded="false"
								class="collapse first-level base-level-line">
								<li class="sidebar-item"><a
									href="/faq/faqList.go" class="sidebar-link"><span
										class="hide-menu"> FAQ </span></a></li>
								<li class="sidebar-item"><a
									href="/ann/annList.go" class="sidebar-link"><span
										class="hide-menu"> 고객 공지사항 </span></a></li>
								<li class="sidebar-item"><a
									href="/ann/empAnnList.go" class="sidebar-link"><span
										class="hide-menu"> 직원 공지사항 </span></a></li>
							</ul></li>
					</ul>
				</nav>
				<!-- End Sidebar navigation -->
			</div>
			<!-- End Sidebar scroll-->
		</aside>
	</div>
</body>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.0/sockjs.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
   <script>
    // 페이지 로드 시 초기 실행
    var emp_no = document.querySelector('input[name="emp_no"]').value;

    window.addEventListener('load', function() {
        fetchNotifications(); // 초기 공지사항 데이터 가져오기
        connectWebSocket(); // 웹 소켓 연결 설정
    });

    // 공지사항 데이터를 가져오는 함수 (AJAX)
function fetchNotifications() {
    $.ajax({
        type: 'GET',
        url: '/notifications', // 공지사항 목록을 제공하는 서버 엔드포인트 URL
        dataType: 'json',
        data: {
            emp_no: emp_no // emp_no 값을 쿼리 파라미터로 추가
        },
        success: function(data) {
            data.forEach(notification => {
                showNotification(notification);
            });
        },
        error: function(error) {
            console.error('공지사항 목록을 가져오는 중 에러 발생:', error);
        }
    });
}

    // 웹 소켓 연결을 설정하는 함수
    var stompClient = null;
    var isWebSocketConnected = false;

    function connectWebSocket() {
        var socket = new SockJS('/ws_stomp');
        stompClient = Stomp.over(socket);

        stompClient.connect({}, function(frame) {
            console.log('Connected: ' + frame);
            isWebSocketConnected = true;

            // 사용자별 알림 채널 구독
            var userEmpNo = document.querySelector('input[name="emp_no"]').value;
            console.log("사원 번호는??? " + userEmpNo);
            stompClient.subscribe('/user/' + userEmpNo + '/queue/notifications', function(message) {
                console.log('Received message from topic ' + userEmpNo + ': ' + message.body);
                
                showNotification(JSON.parse(message.body)); // 서버에서 JSON 문자열을 받아 객체로 변환하여 처리
                
                
            });

            // 웹 소켓 연결 후 초기 메시지 전송 (옵션)
            sendMessageToServer();
        }, function(error) {
            console.error('Error during WebSocket connection: ' + error);
            // 재연결 로직 추가 가능
        });
    }

    // 웹 소켓 연결 해제
    window.addEventListener('beforeunload', function() {
        if (stompClient !== null && isWebSocketConnected) {
            stompClient.disconnect();
        }
    });

    // 예제로 메시지 전송하는 함수 (웹 소켓)
    function sendMessageToServer() {
        if (stompClient !== null && stompClient.connected) {
            stompClient.send('/app/chat', {}, JSON.stringify({ 'content': 'Hello, Server!' }));
        }
    }
    function updateNotificationCount() {
        var notifyNo = document.querySelector('.notify-no');
        notifyNo.innerText = document.querySelectorAll('.message-item').length;
    }

	    // 알림을 HTML에 추가하는 함수
	function showNotification(notification) {
	    console.log("뭘 받았을까? " + notification);
	    var notificationList = document.getElementById('notificationList');
	
	    var notificationItem = document.createElement('div');
	    notificationItem.className = 'message-item d-flex align-items-center border-bottom px-3 py-2';
	
	    var iconSpan = document.createElement('span');
	    iconSpan.className = 'btn btn-success text-white rounded-circle btn-circle';
	    iconSpan.innerHTML = '<i data-feather="calendar" class="text-white"></i>';
	
	    var contentDiv = document.createElement('div');
	    contentDiv.className = 'w-75 d-inline-block v-middle pl-2';
	
	    var titleDiv = document.createElement('div');
	    titleDiv.className = 'd-flex justify-content-between align-items-center mb-1';
	
	    var titleH6 = document.createElement('h6');
	    titleH6.className = 'message-title mb-0';
	    titleH6.innerText = 'New Notification';
	
	    var deleteButton = document.createElement('button');
	    deleteButton.className = 'btn btn-sm btn-outline-danger delete-notification';
	    deleteButton.innerText = 'x';
	    deleteButton.addEventListener('click', function() {
	        var noti_idx = notification.noti_idx; // 알림 객체의 noti_idx를 가져옴
	        // AJAX를 사용하여 서버에 삭제 요청 보내기
	        deleteNotification(noti_idx);
	        // UI에서 삭제
	        notificationList.removeChild(notificationItem);
	        // 알림 개수 업데이트
	        updateNotificationCount();
	    });
	
	    titleDiv.appendChild(titleH6);
	    titleDiv.appendChild(deleteButton);
	
	    var messageSpan = document.createElement('span');
	    messageSpan.className = 'font-12 text-nowrap d-block text-muted text-truncate';
	    messageSpan.innerText = notification.noti_content; // 알림 내용
	
	    var timeSpan = document.createElement('span');
	    timeSpan.className = 'font-12 text-nowrap d-block text-muted';
	    timeSpan.innerText = new Date(notification.noti_date); // 알림 시간
	
	    contentDiv.appendChild(titleDiv);
	    contentDiv.appendChild(messageSpan);
	    contentDiv.appendChild(timeSpan);
	
	    // 클릭 시 noti_link로 이동
	    iconSpan.addEventListener('click', function() {
	        window.location.href = notification.noti_link;
	    });
	
	    notificationItem.appendChild(iconSpan);
	    notificationItem.appendChild(contentDiv);
	
	    notificationList.prepend(notificationItem);
	
	    // 알림 개수 업데이트
	    updateNotificationCount();
	}
	    
	//알림 삭제 요청을 처리하는 함수 (AJAX)
function deleteNotification(noti_idx) {
    $.ajax({
        type: 'DELETE',
        url: '/notifications/' + noti_idx, // 알림의 고유 ID를 사용하여 삭제 요청
        success: function(response) {
            console.log('알림 삭제 성공:', response);
        },
        error: function(error) {
            console.error('알림 삭제 중 에러 발생:', error);
            // 실패 시에 대한 처리
        }
    });
}
	
	
document.addEventListener('DOMContentLoaded', function() {
    // 권한 검사 함수
    function checkEmpList() {
        var authority = parseInt($('#authority').val()); // 예시에서는 authority 값이 input 요소에 저장되어 있다고 가정합니다.
        var deptCode = $('#dept_code').val(); // 예시에서는 dept_code 값이 input 요소에 저장되어 있다고 가정합니다.
        console.log(deptCode + authority + "ㅁㄴㅇㅁㄴㅇㅁㄴㅇ");

        // 권한 검사
        if (authority >= 2 || deptCode === '11') {
            // 권한이 충족되면 해당 URL로 이동
            window.location.href = '/emp/empList.go';
        } else {
            // 권한이 없는 경우 알림창 표시
            alert('권한이 없습니다.');
        }
    }
    
    function checkEmpRegist() {
        var authority = parseInt($('#authority').val()); // authority 값을 정수로 변환
        var deptCode = $('#dept_code').val(); // dept_code 값을 정수로 변환
        console.log("dept Code : " +deptCode + "authority : " + +authority + "ㅁㄴㅇㅁㄴㅇㅁㄴㅇ");

        // 권한 검사
        if (authority >= 2 && deptCode === '11') {
            // 권한이 충족되면 해당 URL로 이동
            window.location.href = '/emp/empRegist.go';
        } else {
            // 권한이 없는 경우 알림창 표시
            alert('권한이 없습니다.');
        }
    }
    // 사이드바 링크 클릭 이벤트 처리
    $('#empRegist').on('click', 'a', function(event) {
        event.preventDefault(); // 기본 동작 방지

        // 권한 검사 함수 호출
        checkEmpRegist();
    });
    

    // 사이드바 링크 클릭 이벤트 처리
    $('#empList').on('click', 'a', function(event) {
        event.preventDefault(); // 기본 동작 방지

        // 권한 검사 함수 호출
        checkEmpList();
    });
})

	
    
    </script>
    </html>