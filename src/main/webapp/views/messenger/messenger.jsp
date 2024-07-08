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

#create_icon:hover, #bells:hover, #bars:hover{
	color: cornflowerblue;
}


#createRoom{
    text-align: end;
    padding: 9px;
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

.msg{
	max-width: 500px;
}

.content{
	overflow: unset;
}

#chat_left{
	height: 650px;
}

.text_center{
	text-align: center;
}

#chat_body_bottom{
	display: flex;
}

#file, #img {
  display: none;
}

#plusBtnDiv{
	font-size: x-large;
	padding-top: 7px;
}

#plusBtnDiv:hover{
	color:cornflowerblue;
	cursor: pointer;
}

#imgFileModal{
	position: absolute;
    bottom: 78px;
    width: 140px;
    height: auto;
    background-color: white;
    padding: 5px;
    border-radius: 10px;
    display: none;
}

.btn-upload{
	font-size: large;
	margin-bottom: 0px !important; 
}

.btn-upload:hover{
	color:cornflowerblue;
	cursor: pointer;
}

.chat_img{
	width: 100%;
}

#textarea1[readonly]{
	background-color: white !important;
}

#noChatRoom{
	margin: 0 auto;
    margin-top: 265px;
}

#memberModal{
	width: 160% !important;
}

#modal-body{
	display: flex;
}

#modal_right{
	margin: 0 auto;
}

#modalBtn{
	float: right;
}

#room_subject{
	margin-bottom: 10px;
}

#downloadBtn{
	width: 100%;
}

#chatMemberUl{
	height: 400px;
    overflow: auto;
}

#subject_change_div{
	display: flex;
	margin-right: auto !important;
    margin-left: 20px;
}

#room_subject_change{
	border: 1px solid #e9ecef;
}

#chatMemberList p{
	margin-top: 5px !important;
}

 #roomSubject{
 	 font-size: larger;
 	 font-weight: 800;
 }
 
 #cancel{
 	display: none;
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
										<i class="fa-solid fa-comment-medical" id="create_icon" onclick="createRoomModal('C')"></i>
									</div>
									<div class="scrollable position-relative"  id="chat_left">
										<ul class="mailbox list-style-none">
											<li>
												<div class="message-center" id="chat_body">
												</div>
											</li>
										</ul>
									</div>
								</div>
								<div id="noChatRoom">
									<img src="/assets/images/CONNECTEL-logo.png" width="500px">
								</div>
								<div class="col-lg-9  col-xl-10" id="chat_content">
								<div id="chat_top">
									<div id="subject_change_div">
										<p id="roomSubject"></p>
						        	</div>
									<div><i class="fa-solid fa-bell" id="bells"></i></div>
									<div><i class="fa-solid fa-bars" id="bars" onclick="open_side_bar()"></i></div>
								</div>
									<div class="chat-box scrollable position-relative" style="height: calc(76vh - 111px);" id="chatBody">
										<!--chat Row -->
										<ul class="chat-list list-style-none px-3 pt-3" id="chatContent">
										</ul>
									</div>
									<div class="card-body border-top">
										<div class="row">
											<div class="col-9">
												<div id="imgFileModal">
													<div>
														<label for="img" class="btn-upload">
														  	<i class="fa-solid fa-image"></i>&nbsp&nbsp이미지 전송
														</label>
														<input type="file" name="img" id="img" onchange="sendImg()" accept="image/gif, image/jpeg, image/png, image/webp">														
													</div>
													<div>
														<label for="file" class="btn-upload">
														  	&nbsp<i class="fa-solid fa-file"></i>&nbsp&nbsp파일 전송
														</label>
														<input type="file" name="file" id="file" onchange="sendFile()">
													</div>
												</div>
												<div class="input-field mt-0 mb-0" id="chat_body_bottom">
													<div id="plusBtnDiv" onclick="imgFileModal()">
														<i class="fa-solid fa-plus"></i>
													</div>													
													<input id="textarea1" placeholder="Type and enter" class="form-control border-0" type="text" onkeyup="keyCheck()" readonly="readonly">
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
	<img src="" id="base64-output">
	
	<div class="modal fade" id="bs-example-modal-sm" tabindex="-1" role="dialog"
	    aria-labelledby="mySmallModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-sm">
	        <div class="modal-content" id="memberModal">
	            <div class="modal-header">
	                <h4 class="modal-title" id="mySmallModalLabel">채팅 상대 지정</h4>
	                <button type="button" class="close" data-dismiss="modal"  aria-hidden="true">×</button>
	            </div>
	            <div class="modal-body" id="modal-body">
	            	<div id="modal_left">
		            	<input type="text" class="form-control" name="search" placeholder="검색어를 입력해주세요." onkeyup="treeCall()" id="treeSearch">
						<ul id="tree">
							<li class="card2"></li>
							<li class="customers"></li>
							<li class="config"></li>
						</ul>
	            	</div>
					<div id="modal_right">
						<input type="text" class="form-control" name="room_subject" placeholder="채팅방 이름을 입력해 주세요." id="room_subject">
						 대화상대
						 <ul id="chatMemberUl">
						 </ul>
						 <div id="modalBtn">
							<button type="button" class="btn btn-info btn-sm" name="modalBtn" data-dismiss="modal">닫기</button>
							<button type="button" class="btn btn-info btn-sm" name="modalBtn" onclick="createRoom()">확인</button>
						 </div>
					</div>
	            </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	
	<div id="right-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
	    <div class="modal-dialog modal-sm modal-right">
	        <div class="modal-content">
	            <div class="modal-body" id="modal_body">
	            	<div>
						<input type="text" name="room_subject" id="room_subject_change">
						<input type="hidden" name="subject">
						<button type="button" class="btn btn-info btn-sm" name="modalBtn" onclick="changeRoomSubject()">수정</button>
	            	</div>
	                <div class="text-center" id="chatMemberList">
	                </div>
					<div class="btn-group">
				    </div>
	            </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	
	<div class="modal fade" id="centermodal" tabindex="-1" role="dialog" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal"
	                    aria-hidden="true">×</button>
	            </div>
	            <div class="modal-body" id="imgModal">
	                
	            </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	<div id="info-alert-modal" class="modal fade" tabindex="-1" role="dialog"
	    aria-hidden="true">
	    <div class="modal-dialog modal-sm">
	        <div class="modal-content">
	            <div class="modal-body p-4">
	                <div class="text-center" id="alert_body">
	                    <i class="dripicons-information h1 text-info"></i>
	                    <p class="mt-3" id="alert_content"></p>
	                    <button type="button" class="btn btn-info my-2" data-dismiss="modal" id="submitBtn">확인</button>
	                    <button type="button" class="btn btn-info my-2" data-dismiss="modal" id="cancel">취소</button>
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
		
		$('#chat_content').css('display','none');
	});
	
	var division = 0;
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
    			if (division == 0) {
					$("#tree").explr(); 					
	    			division = 1;
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
	    			card += '<li class="user" onclick="addMember('+index+')">';
	    			card += '<a href="#">' + item.name +'</a></li>';
	    			index += 1;
	    		}
	    		
	    		if (item.dept_name == '고객팀') {
	    			team[index] = item;
	    			customer += '<li class="customers" onclick="addMember('+index+')">';
	    			customer += '<a href="#">' + item.name +'</a></li>';
	    			index += 1;
	    		}
	    		
	    		if (item.dept_name == '시설팀') {
	    			team[index] = item;
	    			config += '<li class="config" onclick="addMember('+index+')">';
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
    
    
    var plusMemberList = [];
    // 대화상대 추가
    function addMember(index) {
    	for (emp of memberList) {
			if (emp == team[index].emp_no) {
				$('#cancel').css('display','none');
				$('#alert_content').html('이미 선택한 직원입니다.');
				$('#info-alert-modal').modal('show');
				return;
			}
		}
    	
    	if (option == 'C') {
	    	memberList.push(team[index].emp_no);			
		} else {
			memberList.push(team[index].emp_no);	
			plusMemberList.push(team[index].emp_no);
		}
    	
    	var content = '<li onclick="delMember(\''+team[index].emp_no+'\', this)">'+team[index].name+'  <a href="#">삭제</a></li>'
  
    	
    	$('#chatMemberUl').append(content);
		console.log(memberList);
	}
    
    function delMember(emp_no, item) {
    	
    	for (var i = 0; i < memberList.length; i++) {
			if (memberList[i] == emp_no) {
	    		delete memberList[i];				
			}	
		}
    	if (option == 'P') {
    		for (var i = 0; i < plusMemberList.length; i++) {
    			if (plusMemberList[i] == emp_no) {
    	    		delete plusMemberList[i];				
    			}	
    		}
		}
    	console.log(item);
    	$(item).remove();
    	console.log(memberList);
	}
    
    function returnBtn() {
    	memberList = ['${loginInfo.emp_no}'];
    	plusMemberList = [];
		$('#room_subject').val('');
		$('#chatMemberUl').html('');
		console.log(memberList);
		$('#room_subject').attr("readonly",false);  
	}
    
    
    
    function createRoomModal(division) {
    	if (division == 'C') {
	    	returnBtn();		
	    	option = 'C';
		}
		$('#bs-example-modal-sm').modal('show');
	}
    
    function open_side_bar() {
    	$('#right-modal').css("height","50%");
    	$('#right-modal').css("top","10%");
    	$('.modal-right').css("height", "auto");
		$('#right-modal').modal('show');
	}
    
    
    var memberList = ['${loginInfo.emp_no}'];
    console.log(memberList);
    
    function createRoom() {
    	

    	
    	plusMemberList = plusMemberList.filter(function(item) {
			return item !== null && item !== undefined && item !== '';
		});	
    	
    	memberList = memberList.filter(function(item) {
			return item !== null && item !== undefined && item !== '';
		});	
    	
    	console.log(memberList);
    	
    	params = {
    			name:$('#room_subject').val(),
    			memberList:memberList,
    			registerName:'${loginInfo.name}'
    	}
    	
    	if ($('#room_subject').val() == '') {
    		$('#cancel').css('display','none');
    		$('#alert_content').html('채팅방 제목을 입력해 주세요.');
			$('#info-alert-modal').modal('show');
		}else{
			if (option == 'C') {
		    	$('#bs-example-modal-sm').modal('hide');
				
				params = {
		    			name:$('#room_subject').val(),
		    			memberList:memberList,
		    			registerName:'${loginInfo.name}'
		    	}
				
				$.ajax({
		       		url:'/chat/room',
		       		method:'post',
		       		data:JSON.stringify(params),
		       		contentType:'application/json; charset = UTF-8',
		       		dataType:'JSON',
		       		success:function(data){
		       			findAllRoom();
		       		},
		       		error:function(e){
		       			console.log(e);
		       		}
		       	})							
			} else {
				
				if (plusMemberList.length == 0) {
					$('#cancel').css('display','none');
					$('#alert_content').html('추가할 사원을 선택해 주세요.');
					$('#info-alert-modal').modal('show');
					return;
				}
				$('#bs-example-modal-sm').modal('hide');
				
				params = {
		    			chat_no:chat_no,
		    			plusMemberList:plusMemberList,
		    			room_name:$('#room_subject').val()
		    	}
				
				$.ajax({
		       		url:'/chat/plusMember',
		       		method:'post',
		       		data:JSON.stringify(params),
		       		contentType:'application/json; charset = UTF-8',
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
	}


	findAllRoom();
    
    function findAllRoom() {
    	$('#chat_body').html('');
    	 $.ajax({
     		url:'/chat/rooms',
     		method:'get',
     		data:{
     			emp_no:'${loginInfo.emp_no}'
     		},
     		dataType:'JSON',
     		success:function(data){
     			var content = '';
     			for (item of data) {
     				content += '<a href="javascript:enterRoom(\''+item.roomId+'\')" class="message-item d-flex align-items-center border-bottom px-3 py-2"><div class="user-img"><img src="/assets/images/chat.png" alt="user" class="img-fluid rounded-circle" width="40px"> <span class="profile-status online float-right"></span></div><div class="w-75 d-inline-block v-middle pl-2">';
					content += '<h6 class="message-title mb-0 mt-1">'+item.room_name+'</h6></div></a>';
				}
     			$('#chat_body').append(content);
     		},
     		error:function(e){
     			console.log(e);
     		}
     	})
	}
    
    var chatMemberList;
    var room_id = [];
    function enterRoom(roomId) {
    	var sender = '${loginInfo.name}';
    	var emp_no = '${loginInfo.emp_no}';
    	$('#chatMemberList').html('');
    	
    	
    	
    	
    	$('#textarea1').prop('readonly', false);
    	$('#chat_content').css('display','block');
    	$('#noChatRoom').css('display','none');
    	
        if(sender != "") {
            localStorage.setItem('wschat.sender',sender);
            localStorage.setItem('wschat.roomId',roomId);
            localStorage.setItem('wschat.emp_no',emp_no);
            $.ajax({
         		url:'/chat/room/enter/' + roomId,
         		method:'get',
         		data:{},
         		dataType:'JSON',
         		success:function(data){
         			findRoom(data.roomId);
         			chatMemberList = data.chatMemberList;
         			
         			chat_no = data.roomId;
         			
         			
         			
         			var content = '';
         			var button = '';
         			
         			console.log(chatMemberList);
         			
         			for (item of chatMemberList) {
         				content += '<p>'+item.name+' '+item.rank_name+'('+item.dept_name+')</p><hr>';
         				
         				if (item.emp_no == '${loginInfo.emp_no}') {							
	         				$('#roomSubject').html(item.room_name);
	         				$('#room_subject_change').val(item.room_name);
						}
					}
         			
         			button += '<button type="button" class="btn btn-info btn-sm" onclick="memberPlus()">대화 상대 추가</button>';
			        button += '<button type="button" class="btn btn-danger btn-sm" onclick="outRoomConfirm()">채팅방 나가기</button>';
         			
			        $('#chatMemberList').html(content);
			        $('.btn-group').html(button);
         		},
         		error:function(e){
         			console.log(e);
         		}
         	})
        }
	}
    
    
    function outRoomConfirm() {
    	$('#alert_content').html('채팅방을 나가시겠습니까?');
		$('#info-alert-modal').modal('show');
		$('#cancel').css('display','inline');
    	$('#submitBtn').on('click',function(){
    		$.ajax({
    			url:'/chat/outRoom',
    			method:'post',
    			data:{
    				chat_no:chat_no,
    				emp_no:'${loginInfo.emp_no}'
    			},
    			dataType:'JSON',
    			success:function(data){
    				location.reload(true);
    			},
    			error:function(e){
    				console.log(e);
    			}
    		})
    	});
	}
    
    
    function changeRoomSubject() {
    	$.ajax({
			url:'/chat/roomNameChange',
			method:'post',
			data:{
				chat_no:chat_no,
				room_name:$('#room_subject_change').val(),
				emp_no:'${loginInfo.emp_no}'
			},
			dataType:'JSON',
			success:function(data){
				$('#alert_content').html(data.msg);
				$('#info-alert-modal').modal('show');
				$('#roomSubject').html($('#room_subject_change').val());
				findAllRoom();
			},
			error:function(e){
				console.log(e);
			}
		})
		
	}
    
    
    var option = 'C';
    var chat_no = '';
    function memberPlus() {
    	
    	option = 'P';
    	
    	memberList = [];
    	plusMemberList = [];
    	$('#chatMemberUl').html('');
    	$('#bs-example-modal-sm').modal('show');
    	$('#right-modal').modal('hide');
    	
    	$('#room_subject').val();
    	
		console.log(chatMemberList);
		var idx = 0;
		var content = '';
		for (item of chatMemberList) {
			$('#room_subject').val(item.room_name);
			memberList.push(item.emp_no);
			content = '<li>'+item.name +' '+item.rank_name+'</li>';
			$('#chatMemberUl').append(content);
			chat_no = item.chat_no;
		}
		
		$('#room_subject').attr("readonly",true);
		
	}
    
    
    var sock = '';
    var ws = '';
    var reconnect = 0;
    
    
    function sendMessage() {
    	var roomId = localStorage.getItem('wschat.roomId');
        var sender = localStorage.getItem('wschat.sender');
        var emp_no = localStorage.getItem('wschat.emp_no');
        var message = $('#textarea1').val();
        
        
        if ($('#textarea1').val() != '') {
	        console.log('sdfsdf');
	        ws.send("/pub/chat/message", {}, JSON.stringify({type:'TALK', roomId:roomId, sender:sender, emp_no:emp_no,message:message,msg_type:'text',profile_img:'${loginInfo.profile_img}'}));
		}
    	
        message = '';
	}
    
    function sendImg() {
    	
    	$('#imgFileModal').css('display','none');
    	
    	var formData = new FormData();
		var inputFile = $("#img");
		var file = inputFile[0].files;
		console.log(file);
		formData.append("img", file[0]);
    	
    	
    	 $.ajax({
     		url:'/chat/sendImg',
     		method:'post',
     		data:formData,
     		dataType:'JSON',
     		contentType:false,
     		processData:false,
     		success:function(data){
     			console.log(data.newFileName);
     			
     			var roomId = localStorage.getItem('wschat.roomId');
     	        var sender = localStorage.getItem('wschat.sender');
     	        var emp_no = localStorage.getItem('wschat.emp_no');
     	        
     	    	
     	        ws.send("/pub/chat/message", {}, JSON.stringify({type:'TALK', roomId:roomId, sender:sender, emp_no:emp_no, message:data.newFileName, msg_type:'image', profile_img:'${loginInfo.profile_img}'}));
     			
     		},
     		error:function(e){
     			console.log(e);
     		}
     	})
	}
    
 function sendFile() {
    	
    	$('#imgFileModal').css('display','none');
    	
    	var formData = new FormData();
		var inputFile = $("#file");
		var file = inputFile[0].files;
		console.log(file);
		formData.append("file", file[0]);
		
    	var maxSize = 5 * 1024 * 1024; //* 5MB 사이즈 제한
		var fileSize = file[0].size;//업로드한 파일용량
		
		
		
		if(fileSize > maxSize){
			$('#alert_content').html("파일첨부 사이즈는 5MB 이내로 가능합니다.");
			$('#info-alert-modal').modal('show');
			$(inputFile).val(''); //업로드한 파일 제거
			return; 
		} else {
	    	 $.ajax({
	     		url:'/chat/sendFile',
	     		method:'post',
	     		data:formData,
	     		dataType:'JSON',
	     		contentType:false,
	     		processData:false,
	     		success:function(data){
	     			console.log(data.newFileName);
	     			
	     			var roomId = localStorage.getItem('wschat.roomId');
	     	        var sender = localStorage.getItem('wschat.sender');
	     	        var emp_no = localStorage.getItem('wschat.emp_no');
	     	        
	     	    	
	     	        ws.send("/pub/chat/message", {}, JSON.stringify({type:'TALK', roomId:roomId, sender:sender, emp_no:emp_no,message:data.newFileName,msg_type:'file', profile_img:'${loginInfo.profile_img}'}));
	     			
	     		},
	     		error:function(e){
	     			console.log(e);
	     		}
	     	})	
		}
	}
    
    var messages = [];
    function recvMessage(recv) {
    	var nowDate = new Date();
    	var emp_no = '${loginInfo.emp_no}';
    	
    	console.log(recv);
    	var content = '';
    	if (recv.emp_no != emp_no) {
			content += '<li class="chat-item list-style-none mt-3"><div class="chat-img d-inline-block"><img src="/photo/'+recv.profile_img+'" alt="user" class="rounded-circle" width="45"></div><div class="chat-content d-inline-block pl-3">';
			content += '<h6 class="font-weight-medium">'+recv.sender+'</h6>';
			if (recv.msg_type == 'file') {
				content += '<div class="msg p-2 d-inline-block mb-1"><a href="/download/'+recv.message+'"><i class="fa-solid fa-download"></i>&nbsp'+recv.message+'</a></div></div>';				
			} else if (recv.msg_type == 'text') {
				content += '<div class="msg p-2 d-inline-block mb-1">'+recv.message+'</div></div>';				
			} else {
				content += '<div class="msg p-2 d-inline-block mb-1"><img src="/photo/'+recv.message+'" class="chat_img" onclick="imgDetail(\''+recv.message+'\')"></div></div>';
			}
			content += '<div class="chat-time d-block font-10 mt-1 mr-0 mb-3">'+nowDate.toLocaleString()+'</div></li>';
		} else {
			content += '<li class="chat-item odd list-style-none mt-3">';
			content += '<div class="chat-content text-right d-inline-block pl-3">';
			if (recv.msg_type == 'file') {
				content += '<div class="msg p-2 d-inline-block mb-1"><a href="/download/'+recv.message+'"><i class="fa-solid fa-download"></i>&nbsp'+recv.message+'</a></div></div>';				
			} else if (recv.msg_type == 'text') {
				content += '<div class="msg p-2 d-inline-block mb-1">'+recv.message+'</div></div>';				
			} else {
				content += '<div class="msg p-2 d-inline-block mb-1"><img src="/photo/'+recv.message+'" class="chat_img" onclick="imgDetail(\''+recv.message+'\')"></div></div>';
			}
			content += '<div class="chat-time text-right d-block font-10 mt-1 mr-0 mb-3">'+nowDate.toLocaleString()+'</div></li>';
		}
		messages.unshift({"type":recv.type,"sender":recv.sender,"emp_no":recv.emp_no,"message":recv.message, profile_img:'${loginInfo.profile_img}'})
		if (recv.type != 'ENTER') {
			$('#chatContent').append(content);	
			$('#textarea1').val('');
		}
		content = '';
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
			    drawChatContent(roomId);
			    for (item of room_id) {
			    	if (item == roomId) {
						return;
					}	
				}
		    	room_id.push(roomId);
			    connect();
			    
			},
			error:function(e){
				console.log(e);
			}
		})
   	}
    
    
    function connect() {
	    $('#chatBody').prop('scrollTop',$('#chatBody').prop('scrollHeight'));
    	var roomId = localStorage.getItem('wschat.roomId');
        var sender = localStorage.getItem('wschat.sender');
        var emp_no = localStorage.getItem('wschat.emp_no');
        ws.connect({}, function(frame) {
            ws.subscribe("/sub/chat/room/"+roomId, function(message) {
                var recv = JSON.parse(message.body);
                recvMessage(recv);
            });
            ws.send("/pub/chat/message", {}, JSON.stringify({type:'ENTER', roomId:roomId, emp_no:emp_no, sender:sender}));
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
    
    function drawChatContent(roomId) {
    	var date;
    	var nowDate = new Date();
    	$('#chatContent').html('');	
    	$.ajax({
    		url:'/chat/content/' + roomId,
    		method:'get',
    		data:{},
    		dataType:'JSON',
    		success:function(data){
    			var emp_no = '${loginInfo.emp_no}';
    			console.log(data.list);
    			var content = '';
    			for (item of data.list) {
    				if (item.emp_no != emp_no) {
    					date = new Date(item.chat_date);
    					content += '<li class="chat-item list-style-none mt-3"><div class="chat-img d-inline-block"><img src="/photo/'+item.profile_img+'" alt="user" class="rounded-circle" width="45"></div><div class="chat-content d-inline-block pl-3">';
    					content += '<h6 class="font-weight-medium">'+item.name+'</h6>';
    					console.log('123 : ',item.msg_type);
    					if (item.msg_type == 'file') {
    						content += '<div class="msg p-2 d-inline-block mb-1"><a href="/download/'+item.chat_content+'"><i class="fa-solid fa-download"></i>&nbsp'+item.chat_content+'</a></div></div>';
						} else if (item.msg_type == 'text') {
    						content += '<div class="msg p-2 d-inline-block mb-1">'+item.chat_content+'</div></div>';			
    					} else {
    						content += '<div class="msg p-2 d-inline-block mb-1"><img src="/photo/'+item.chat_content+'" class="chat_img" onclick="imgDetail(\''+item.chat_content+'\')"></div></div>';
    					}
    					content += '<div class="chat-time d-block font-10 mt-1 mr-0 mb-3">'+date.toLocaleString()+'</div></li>';
					} else {
						date = new Date(item.chat_date);
						content += '<li class="chat-item odd list-style-none mt-3">';
						content += '<div class="chat-content text-right d-inline-block pl-3">';
						if (item.msg_type == 'file') {
    						content += '<div class="msg p-2 d-inline-block mb-1"><a href="/download/'+item.chat_content+'"><i class="fa-solid fa-download"></i>&nbsp'+item.chat_content+'</a></div></div>';
						} else if (item.msg_type == 'text') {
    						content += '<div class="msg p-2 d-inline-block mb-1">'+item.chat_content+'</div></div>';				
    					} else {
    						content += '<div class="msg p-2 d-inline-block mb-1"><img src="/photo/'+item.chat_content+'" class="chat_img" onclick="imgDetail(\''+item.chat_content+'\')"></div></div>';
    					}
						content += '<div class="chat-time text-right d-block font-10 mt-1 mr-0 mb-3">'+date.toLocaleString()+'</div></li>';
					}
				}
    			$('#chatContent').append(content);	
    			$('#chatBody').prop('scrollTop',$('#chatBody').prop('scrollHeight'));
    		},
    		error:function(e){
    			console.log(e);
    		}
    	})
	}
    
    $(document).mouseup(function (e){
    	var layerPopup = $("#imgFileModal");
    	if(layerPopup.has(e.target).length === 0){
    		$('#imgFileModal').css('display','none');
    	}
    });
    
    function imgFileModal() {
		$('#imgFileModal').css('display','block');
	}
    
    function imgDetail(imgName) {
    	$('#imgModal').html('');
    	$('#imgModal').html('<img src="/photo/'+imgName+'" class="chat_img"><button type="button" class="btn btn-info btn-sm" onclick="download(\''+imgName+'\')" id="downloadBtn">다운로드</button>');
    	$('#centermodal').modal('show');
		console.log(imgName);
	}
    
    function download(name) {
		location.href="/download/"+name;
	}
    
    function keyCheck() {
    	if (window.event.keyCode == 13 && $('#textarea1').val() != '') {
    		sendMessage();
        }
	}
    
</script>
</html>