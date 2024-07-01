<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="/dist/css/style.min.css" rel="stylesheet">
<style>

#chat_top {
    display: flex;
    justify-content: flex-end;
    align-items: center;
}

#chat_top div {
    margin-right: 10px;
    margin-top: 10px;
}

#bells, #bars{
	font-size: 30px;
}

#chat_content{
	display: grid;
}

#createRoom{
	font-size: 30px;
    text-align: end;
    padding: 9px;
}
</style>
</head>
<body>
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-12">
						<div class="card">
							<div class="row no-gutters">
								<div class="col-lg-3 col-xl-2 border-right">
									<div class="card-body border-bottom" id="createRoom">
										<i class="fa-solid fa-comment-medical"></i>
									</div>
									<div class="scrollable position-relative"
										style="height: calc(100vh - 111px);">
										<ul class="mailbox list-style-none">
											<li>
												<div class="message-center">
													<!-- Message -->
													<a href="javascript:void(0)"
														class="message-item d-flex align-items-center border-bottom px-3 py-2">
														<div class="user-img">
															<img src="assets/images/users/1.jpg" alt="user"
																class="img-fluid rounded-circle" width="40px"> <span
																class="profile-status online float-right"></span>
														</div>
														<div class="w-75 d-inline-block v-middle pl-2">
															<h6 class="message-title mb-0 mt-1">홍길동 사장</h6>
															<span
																class="font-12 text-nowrap d-block text-muted text-truncate">오늘 일찍 퇴근하세요</span> <span
																class="font-12 text-nowrap d-block text-muted">9:30AM</span>
														</div>
													</a>
												</div>
											</li>
										</ul>
									</div>
								</div>
								<div class="col-lg-9  col-xl-10" id="chat_content">
								<div id="chat_top">
									<div><i class="fa-solid fa-bell" id="bells"></i></div>
									<div><i class="fa-solid fa-bars" id="bars"></i></div>
								</div>
									<div class="chat-box scrollable position-relative"
										style="height: calc(100vh - 111px);">
										<!--chat Row -->
										<ul class="chat-list list-style-none px-3 pt-3">
											<!--chat Row -->
											<li class="chat-item list-style-none mt-3">
												<div class="chat-img d-inline-block">
													<img src="assets/images/users/1.jpg" alt="user"
														class="rounded-circle" width="45">
												</div>
												<div class="chat-content d-inline-block pl-3">
													<h6 class="font-weight-medium">홍길동 사장</h6>
													<div class="msg p-2 d-inline-block mb-1">안녕하세요</div>
												</div>
												<div class="chat-time d-block font-10 mt-1 mr-0 mb-3">10:56am</div>
											</li>
											<!--chat Row -->
											<li class="chat-item list-style-none mt-3">
												<div class="chat-img d-inline-block">
													<img src="assets/images/users/2.jpg" alt="user"
														class="rounded-circle" width="45">
												</div>
												<div class="chat-content d-inline-block pl-3">
													<h6 class="font-weight-medium">홍길동 사장</h6>
													<div class="msg p-2 d-inline-block mb-1">반가워요</div>
												</div>
												<div class="chat-time d-block font-10 mt-1 mr-0 mb-3">10:57
													am</div>
											</li>
											<!--chat Row -->
											<li class="chat-item odd list-style-none mt-3">
												<div class="chat-content text-right d-inline-block pl-3">
													<div class="box msg p-2 d-inline-block mb-1">I would
														love to join the team.</div>
													<br>
												</div>
											</li>
											<!--chat Row -->
											<li class="chat-item odd list-style-none mt-3">
												<div class="chat-content text-right d-inline-block pl-3">
													<div class="box msg p-2 d-inline-block mb-1 box">
														Whats budget of the new project.</div>
													<br>
												</div>
												<div
													class="chat-time text-right d-block font-10 mt-1 mr-0 mb-3">
													10:59 am</div>
											</li>
										</ul>
									</div>
									<div class="card-body border-top">
										<div class="row">
											<div class="col-9">
												<div class="input-field mt-0 mb-0">
													<input id="textarea1" placeholder="Type and enter"
														class="form-control border-0" type="text">
												</div>
											</div>
											<div class="col-3">
												<a class="btn-circle btn-lg btn-cyan float-right text-white"
													href="javascript:void(0)"><i class="fas fa-paper-plane"></i></a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
</body>
<script>
	
</script>
</html>