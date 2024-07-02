<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="/css/jquery-explr-1.4.css" rel="stylesheet" type="text/css">	
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

#bells, #bars, #create_icon{
	font-size: 30px;
	cursor: pointer;
}

#chat_content{
	display: grid;
}

#createRoom{
    text-align: end;
    padding: 9px;
}

.modal-body{
	display: flex;
}

.modal_table{
	margin: 0 auto;	
	width: 270px;
}

.table_text{
	text-align: center;
}

.modal-dialog{
	max-width: 600px;
}

.appBtn {
	background: cornflowerblue;
	border: cornflowerblue;
	color: white;
	height: 40px;
	border-radius: 5px;
}

.table{
	width: 120%;
}

#treeDiv{
	width: 200px;
}

#treeSearch{
	width: 120%;
}

#right_modal{
	height: 50%;
	top: 10%;
}

.text-center{
	width: 105%;
	max-height: 300px;
    overflow-y: auto;
    overflow-x: hidden;
}

  .btn-group {
    display: flex;
    justify-content: center;
	gap: 10px;
}

#modal_body{
	display: ruby;
}


</style>
</head>
<body>
	<div class="parent">
		<div class="sideBar">
			<jsp:include page="../sideBar.jsp"></jsp:include>
		</div>
		<div class="content">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-12">
						<div class="card">
							<div class="row no-gutters">
								<div class="col-lg-3 col-xl-2 border-right">
									<div class="card-body border-bottom" id="createRoom">
										<i class="fa-solid fa-comment-medical" id="create_icon" onclick="createRoomModal()"></i>
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
															<img src="/assets/images/users/1.jpg" alt="user"
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
									<div><i class="fa-solid fa-bars" id="bars" onclick="open_side_bar()"></i></div>
								</div>
									<div class="chat-box scrollable position-relative"
										style="height: calc(100vh - 111px);">
										<!--chat Row -->
										<ul class="chat-list list-style-none px-3 pt-3" id="chatContent">
											<!--chat Row -->
											<li class="chat-item list-style-none mt-3">
												<div class="chat-img d-inline-block">
													<img src="/assets/images/users/1.jpg" alt="user"
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
													<img src="/assets/images/users/1.jpg" alt="user"
														class="rounded-circle" width="45">
												</div>
												<div class="chat-content d-inline-block pl-3">
													<h6 class="font-weight-medium">홍길동 사장</h6>
													<div class="msg p-2 d-inline-block mb-1">반가워요</div>
												</div>
												<div class="chat-time d-block font-10 mt-1 mr-0 mb-3">10:57am</div>
											</li>
											<!--chat Row -->
											<li class="chat-item odd list-style-none mt-3">
												<div class="chat-content text-right d-inline-block pl-3">
													<div class="box msg p-2 d-inline-block mb-1">I would love to join the team.</div>
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
													href="javascript:sendMessage()"><i class="fas fa-paper-plane"></i></a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="bs-example-modal-sm" tabindex="-1" role="dialog"
	    aria-labelledby="mySmallModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-sm">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h4 class="modal-title" id="mySmallModalLabel">채팅 상대 지정</h4>
	                <button type="button" class="close" data-dismiss="modal"  aria-hidden="true">×</button>
	            </div>
	            <div class="modal-body">
					<div>
	            		<input type="text" class="form-control" id="roomName">
	            		<button type="button" class="btn btn-info btn-sm" onclick="createRoom()">채팅방 개설</button>
					</div>
	            </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	
	<div id="right-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
	    <div class="modal-dialog modal-sm modal-right">
	        <div class="modal-content">
	            <div class="modal-body" id="modal_body">
	                <div class="text-center">
	                    <p>김정훈 사원(인사팀)</p><hr>
	                    <p>김정훈 사원(인사팀)</p><hr>
	                    <p>김정훈 사원(인사팀)</p><hr>
	                    <p>김정훈 사원(인사팀)</p><hr>
	                    <p>김정훈 사원(인사팀)</p><hr>
	                    <p>김정훈 사원(인사팀)</p><hr>
	                </div>
					<div class="btn-group">
				        <button type="button" class="btn btn-info btn-sm" data-dismiss="modal">대화 상대 추가</button>
				        <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">채팅방 나가기</button>
				    </div>
	            </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
</body>
<script src="/js/jquery-explr-1.4.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
	$(document).ready(function(){
		treeCall();
	});
	
	var start = 0;
	function treeCall() {
		var search = $('#treeSearch').val();
		
    	$.ajax({
    		url:'/treeCall.ajax',
    		method:'get',
    		data:{
    			search:search
    		},
    		dataType:'JSON',
    		success:function(data){
    			drawTree(data.list);
    			console.log(data);
    			if (start == 0 && search == '') {
    				start += 1;
	    			console.log(start);
    				$("#tree").explr();
				} else if (search == '') {
					$("#tree").explr('destroy');
					$("#tree").explr();
				}
    		},
    		error:function(e){
    			console.log(e);
    		}
    	})
    }

    // 조직도 출력
    var team = [];
    function drawTree(list) {
    		var card = '<a href="#">인사팀</a><ul>';
    		var customer = '<a href="#">고객팀</a><ul>';
    		var config = '<a href="#">시설팀</a><ul>';
    		var index = 0;
	    	for(item of list){
	    		if (item.dept_name == '인사팀') {
	    			team[index] = item;
	    			card += '<li class="user" onclick="addReferrer('+index+')">';
	    			card += '<a href="#">' + item.name +'</a></li>';
	    			index += 1;
	    		}
	    		
	    		if (item.dept_name == '고객팀') {
	    			team[index] = item;
	    			customer += '<li class="customers" onclick="addReferrer('+index+')">';
	    			customer += '<a href="#">' + item.name +'</a></li>';
	    			index += 1;
	    		}
	    		
	    		if (item.dept_name == '시설팀') {
	    			team[index] = item;
	    			config += '<li class="config" onclick="addReferrer('+index+')">';
	    			config += '<a href="#">' + item.name +'</a></li>';
	    			index += 1;
	    		}
	    	}
    	
    	card += '</ul>';
    	customer += '</ul>';
    	config += '</ul>';
    	
    	$('.customers').html(customer);
    	$('.card2').html(card);
    	$('.config').html(config);
    }
    
    
    
    function createRoomModal() {
		$('#bs-example-modal-sm').modal('show');
	}
    
    function open_side_bar() {
    	$('#right-modal').css("height","50%");
    	$('#right-modal').css("top","10%");
    	$('.modal-right').css("height", "auto");
		$('#right-modal').modal('show');
	}
    
    function createRoom() {
    	if($('#roomName').val() == '') {
            alert("방 제목을 입력해 주십시요.");
            return;
        } else {
            $.ajax({
        		url:'/chat/room',
        		method:'post',
        		data:{
        			name:$('#roomName').val(),
        			emp_no:'${loginInfo.emp_no}'
        		},
        		dataType:'JSON',
        		success:function(data){
        			console.log(data);
        		},
        		error:function(e){
        			console.log(e);
        		}
        	})
        }
	}


	findAllRoom();
    
    function findAllRoom() {
    	 $.ajax({
     		url:'/chat/rooms',
     		method:'get',
     		data:{},
     		dataType:'JSON',
     		success:function(data){
     			var content = '';
     			for (item of data) {
     				content += '<a href="javascript:enterRoom(\''+item.roomId+'\')" class="message-item d-flex align-items-center border-bottom px-3 py-2"><div class="user-img"><img src="/assets/images/users/1.jpg" alt="user" class="img-fluid rounded-circle" width="40px"> <span class="profile-status online float-right"></span></div><div class="w-75 d-inline-block v-middle pl-2">';
					content += '<h6 class="message-title mb-0 mt-1">'+item.name+'</h6></div></a>';
				}
     			$('.message-center').append(content);
     		},
     		error:function(e){
     			console.log(e);
     		}
     	})
	}
    
    function enterRoom(roomId) {
    	var sender = '${loginInfo.name}';
        if(sender != "") {
            localStorage.setItem('wschat.sender',sender);
            localStorage.setItem('wschat.roomId',roomId);
            $.ajax({
         		url:'/chat/room/enter/' + roomId,
         		method:'get',
         		data:{},
         		dataType:'JSON',
         		success:function(data){
         			findRoom(data.roomId);
         		},
         		error:function(e){
         			console.log(e);
         		}
         	})
        }
	}
    
    
    var sock = '';
    var ws = '';
    var reconnect = 0;
    
    
    function sendMessage() {
    	var roomId = localStorage.getItem('wschat.roomId');
        var sender = localStorage.getItem('wschat.sender');
        var message = $('#textarea1').val();
    	
        ws.send("/pub/chat/message", {}, JSON.stringify({type:'TALK', roomId:roomId, sender:sender, message:message}));
        message = '';
	}
    
    var messages = [];
    function recvMessage(recv) {
    	console.log(recv);
    	var content = '';
		content += '<li class="chat-item odd list-style-none mt-3"><div class="chat-content text-right d-inline-block pl-3"><div class="box msg p-2 d-inline-block mb-1 box">';
		content += recv.message + '</div><br></div><div class="chat-time text-right d-block font-10 mt-1 mr-0 mb-3">10:59 am</div></li>';
		messages.unshift({"type":recv.type,"sender":recv.type=='ENTER'?'[알림]':recv.sender,"message":recv.message})
		$('#chatContent').append(content);
	}
    
    function findRoom(roomId) {
      	 $.ajax({
        		url:'/chat/room/' + roomId,
        		method:'get',
        		data:{},
        		dataType:'JSON',
        		success:function(data){
        			sock = new SockJS("/ws_stomp");
        		    ws = Stomp.over(sock);
        		    reconnect = 0;
        			connect();
        		},
        		error:function(e){
        			console.log(e);
        		}
        	})
   	}
    
    
    function connect() {
    	var roomId = localStorage.getItem('wschat.roomId');
        var sender = localStorage.getItem('wschat.sender');
        console.log('123123');
        ws.connect({}, function(frame) {
            ws.subscribe("/sub/chat/room/"+roomId, function(message) {
                var recv = JSON.parse(message.body);
                recvMessage(recv);
            });
            ws.send("/pub/chat/message", {}, JSON.stringify({type:'ENTER', roomId:roomId, sender:sender}));
        },
        function(error) {
            if(reconnect++ <= 5) {
                setTimeout(function() {
                    console.log("connection reconnect");
                    sock = new SockJS("/ws-stomp");
                    ws = Stomp.over(sock);
                    connect();
                },10*1000);
            }
        });
	}
    
</script>
</html>