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

#notiTitle{
	color: black !important;
}

#delNotiDiv{
	width: 30px;
    text-align: center;
    height: auto;
    padding-top: 5px;
}

#delNoti{
	cursor: pointer;
}

#delNoti:hover{
	color: red;
}

#notiDiv{
	display: flex;
}

.imgCover{
	height: 50px;
    object-fit: cover;
}

#load {
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    position: fixed;
    display: block;
    opacity: 0.8;
    background: white;
    z-index: 99;
    text-align: center;
}

#load > img {
    position: absolute;
    top: 50%;
    left: 50%;
    z-index: 100;
}


</style>
</head>
<body>

	

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
                            <a class="nav-link dropdown-toggle pl-md-3 position-relative" href="javascript:void(0)"
                                id="bell" role="button" data-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false">
                                <span><i data-feather="bell" class="svg-icon"></i></span>
                                <span class="badge badge-primary notify-no rounded-circle"></span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-left mailbox animated bounceInDown" style="padding-bottom: 0px">
                                <ul class="list-style-none">
                                    <li>
                                        <div class="message-center notifications position-relative" id="notiContent">
                                            
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </li>
					</ul>
   					<input type = "hidden" name = "emp_no" value = "${sessionScope.loginInfo.emp_no}">
					<!-- ============================================================== -->
					<!-- Right side toggle and nav items -->
					<!-- ============================================================== -->
					<ul class="navbar-nav float-right">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="javascript:void(0)"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<img src="/photo/${loginInfo.profile_img}" alt="user"
								class="rounded-circle imgCover" width="40"> <span
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
									href="/mail/addressManagement.go" class="sidebar-link"><span
										class="hide-menu"> 주소록 </span></a></li>
									

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
<script>
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
        if (authority >= 2 || deptCode === '11') {
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
