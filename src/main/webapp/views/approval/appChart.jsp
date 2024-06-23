<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="/dist/css/style.min.css" rel="stylesheet">
<!-- This Page CSS -->
<link rel="stylesheet" type="text/css"
	href="/assets/extra-libs/prism/prism.css">
<link href="/css/jquery-explr-1.4.css" rel="stylesheet" type="text/css">
</head>
<style>
.card {
	width: 450px;
	margin: 20px 20px;
}

.row {
	width: 1200px;
	height: 530px;
	display: block;
}

.top_bar {
	width: 1200px;
	background-color: cornflowerblue;
	height: 30px;
}

.top_bar_content {
	margin-left: 30px;
	color: white;
}

.middle_div {
	display: flex;
}

.col {
	width: 600px;
}

.middle_left {
	margin-left: 20px;
	width: 450px;
}

.card_table {
	width: 650px;
	margin-left: 50px;
}

.table {
	text-align: center;
}

.btn {
	background-color: cornflowerblue;
	border-color: cornflowerblue;
	margin-left: 5px;
}

.upBtn {
	margin-left: 410px;
}

.form-control {
	width: 200px;
	margin-left: 10px;
}

.bottom_div {
	display: flex;
}

.btn_submit {
	margin-left: 254px;
}

.btn_cancel {
	background-color: gray;
}
</style>
<body>
	<div class="row">
		<div class="top_bar">
			<div class="top_bar_content">결재선 지정</div>
		</div>
		<div class="middle_div">
			<div class="middle_left">
				<div class="card">
					<div class="card-body">
						<ul class="nav nav-tabs mb-3">
							<li class="nav-item"><a href="#profile" data-toggle="tab"
								aria-expanded="true" class="nav-link active"> <i
									class="mdi mdi-account-circle d-lg-none d-block mr-1"></i> <span
									class="d-none d-lg-block">조직도</span>
							</a></li>
							<li class="nav-item"><a href="#settings" data-toggle="tab"
								aria-expanded="false" class="nav-link"> <i
									class="mdi mdi-settings-outline d-lg-none d-block mr-1"></i> <span
									class="d-none d-lg-block">결재선</span>
							</a></li>
						</ul>

						<div class="tab-content">
							<div class="tab-pane show active" id="profile">
								<div class="content">
									<ul id="tree">
										<li class="card2"></li>
										<li class="customers"></li>
										<li class="config"></li>
									</ul>
								</div>
							</div>
							<div class="tab-pane" id="settings">
								<div class="table-responsive">
									<table class="table">
										<tbody class="appLineTable">
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<!-- end card-body-->
				</div>
				<!-- end card-->
			</div>
			<!-- end col -->
			<div class="middle_right">
				<div class="card card_table">
					<div>
						<button type="button"
							class="btn waves-effect waves-light btn-sm btn-success"
							data-toggle="modal" data-target=".allDel">모두
							삭제</button>
						<button type="button"
							class="btn waves-effect waves-light btn-sm btn-success"
							onclick="selectDel()">삭제</button>
						<button type="button"
							class="btn waves-effect waves-light btn-sm btn-success upBtn">위로</button>
						<button type="button"
							class="btn waves-effect waves-light btn-sm btn-success">아래로</button>
					</div>
					<div class="table-responsive">
						<table class="table">
							<thead>
								<tr>
									<th scope="col"></th>
									<th scope="col">순번</th>
									<th scope="col">부서</th>
									<th scope="col">이름</th>
									<th scope="col">직급</th>
								</tr>
							</thead>
							<tbody class="appBody">
							</tbody>
						</table>
					</div>
					<form action="">
						<div class="bottom_div">
							<input type="text" class="form-control appLineName" value="Name">
							<button type="button"
								class="btn waves-effect waves-light btn-sm btn-success"
								onclick="appLineSave()">결재선 저장</button>
							<button type="button"
								class="btn waves-effect waves-light btn-sm btn-success btn_submit" onclick="sendData()">확인</button>
							<button type="button"
								class="btn waves-effect waves-light btn-sm btn-success btn_cancel">취소</button>
						</div>
					</form>
				</div>
				<!-- end card-->
			</div>
			<!-- end col -->
		</div>


		<!-- 전체삭제 모달 -->
		<div id="danger-header-modal" class="modal fade allDel" tabindex="-1"
			role="dialog" aria-labelledby="danger-header-modalLabel"
			aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header modal-colored-header bg-danger">
						<h4 class="modal-title" id="danger-header-modalLabel">전체삭제
							하시겠습니까?</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×</button>
					</div>
					<div class="modal-body">
						<p>지정한 결재선을 전체삭제 하시겠습니까?</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-light" data-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-danger" onclick="allDel()"
							data-dismiss="modal">삭제</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
	</div>

	<!--결재자 인원초과 모달 -->
	<div id="info-alert-modal" class="modal fade over" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-body p-4">
					<div class="text-center">
						<i class="dripicons-information h1 text-info"></i>
						<p class="mt-3">결재자 인원이 초과하였습니다.</p>
						<button type="button" class="btn btn-info my-2"
							data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!--동일 결재자 모달 -->
	<div id="info-alert-modal" class="modal fade same" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-body p-4">
					<div class="text-center">
						<i class="dripicons-information h1 text-info"></i>
						<p class="mt-3">이미 등록된 결재자 입니다.</p>
						<button type="button" class="btn btn-info my-2"
							data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<!--결재선 저장 모달 -->
	<div id="info-alert-modal" class="modal fade appLineSave" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-body p-4">
					<div class="text-center">
						<i class="dripicons-information h1 text-info"></i>
						<p class="mt-3">결재선 저장이 완료되었습니다..</p>
						<button type="button" class="btn btn-info my-2"
							data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

</body>
<script src="/dist/js/custom.min.js"></script>
<script src="/assets/extra-libs/prism/prism.js"></script>
<script src="/assets/libs/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap tether Core JavaScript -->
<script src="/assets/libs/popper.js/dist/umd/popper.min.js"></script>
<script src="/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="/js/jquery-explr-1.4.js"></script>
<script>
    treeCall();
    lineCall();
    var num = 1;

    var appVal = [
    	{emp_no: '${emp_no}', dept_name: '${dept_name}', eName: '${name}', rank_name: '${rank_name}'}
    ];

function treeCall() {
	$.ajax({
		url:'/treeCall.ajax',
		method:'get',
		data:{},
		dataType:'JSON',
		success:function(data){
			drawTree(data.list);
			console.log(data);
			$("#tree").explr();
		},
		error:function(e){
			console.log(e);
		}
	})
}

function lineCall() {
	$.ajax({
		url:'/approval/lineCall.ajax',
		method:'get',
		data:{},
		dataType:'JSON',
		success:function(data){
			drawLine(data.list);
		},
		error:function(e){
			console.log(e);
		}
	})
}

var team = [];
function drawTree(list) {
		var card = '<a href="#">인사팀</a><ul>';
		var customer = '<a href="#">고객팀</a><ul>';
		var config = '<a href="#">시설팀</a><ul>';
		var index = 0;
	for(item of list){
		if (item.dept_name == '인사팀') {
			team[index] = item;
			card += '<li class="user" onclick="plusApp('+index+')">';
			card += '<a href="#">' + item.name +'</a></li>';
			index += 1;
		}
		
		if (item.dept_name == '고객팀') {
			team[index] = item;
			customer += '<li class="customers" onclick="plusApp('+index+')">';
			customer += '<a href="#">' + item.name +'</a></li>';
			index += 1;
		}
		
		if (item.dept_name == '시설팀') {
			team[index] = item;
			config += '<li class="config" onclick="plusApp('+index+')">';
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

function drawLine(list) {
	var content = '';
	for(item of list){
		content += '<tr>';
		content += '<th scope="col"><a href="javascript:saveListCall('+item.app_line_no+')">'+item.app_line_name+'</a></th>';
		content += '<th scope="col"><button type="button" class="btn btn-secondary" onclick="saveLineDel('+item.app_line_no+')"><i class="ti-trash"></i></button></th>';
		content += '</tr>';
	}
	$('.appLineTable').html(content);
}

function saveLineDel(app_line_no) {
	$.ajax({
		url:'/approval/savaLineDel.ajax',
		method:'get',
		data:{
			"app_line_no":app_line_no
		},
		dataType:'JSON',
		success:function(data){
			lineCall();
		},
		error:function(e){
			console.log(e);
		}
	})
}

function saveListCall(app_line_no) {
	$.ajax({
		url:'/approval/saveListCall.ajax',
		method:'get',
		data:{
			"app_line_no":app_line_no
		},
		dataType:'JSON',
		success:function(data){
			appVal = [];
			for (item of data.list) {
				appVal.push(item);
			}
			drawList(appVal);
		},
		error:function(e){
			console.log(e);
		}
	})
}


var approver = ['${emp_no}'];


drawList(appVal);

function plusApp(index){
	if (num > 4) {
              $('.over').modal('show');
	} else {
		for(emp of approver){
			if (team[index].emp_no == emp) {
				$('.same').modal('show');
				return;
			}
		}
		num = num+1;
		
		appVal.push(team[index]);
		console.log(appVal);
		console.log(index);
		approver.push(team[index].emp_no);
		
		drawList(appVal);
	}
}

function drawList(appVal) {
	var index = 1;
	content = '';
	for(item of appVal){
		content += '<tr>';
		content += '<td><input type="checkbox" class="check" value="' + item.emp_no + '"></td>';
		content += '<th scope="row" class="thIndex">'+index+'</th>';
		content += '<td>'+item.dept_name+'</td>';
		content += '<td>'+item.eName+'</td>';
		content += '<td>'+item.rank_name+'</td>';
		content += '</tr>';	
		index += 1;
	}
	$('.appBody').html('');
	$('.appBody').append(content);
}

function allDel() {
	appVal = [
		{emp_no: '${emp_no}', dept_name: '${dept_name}', eName: '${name}', rank_name: '${rank_name}'}
	];
	approver = ['${emp_no}'];
	num = 1;
    drawList(appVal);
}

function selectDel() {
	var checkedVal = [];
    $('.check:checked').each(function() {
        checkedVal.push($(this).val());
    });
    console.log(appVal);
    console.log(checkedVal);
    for (var j = 0; j < checkedVal.length; j++) {
	    for (var i = 0; i < appVal.length; i++) {
			if (appVal[i].emp_no == checkedVal[j]) {
				appVal.splice(i,1);
			}
		}	
	}
    
    for (let emp of checkedVal) {
		for (var i = 0; i < approver.length; i++) {
			if (approver[i] == emp) {
				approver.splice(i,1);
			}
		}
	}
    num = num - checkedVal.length;
    console.log(approver)
    drawList(appVal);
}

function appLineSave() {
	var appLine = [];
	for (item of appVal) {
		appLine.push(item.emp_no);
	}
	console.log(appLine);	
	$.ajax({
		url:'/approval/appLineSave.ajax',
		method:'get',
		traditional: true,
		data:{
			"appLine":appLine,
			"name": $('.appLineName').val()
		},
		dataType:'JSON',
		success:function(data){
			if (data.row>0) {
				 $('.appLineSave').modal('show');
				 $('.appLineName').val('');
				 lineCall();
			}
		},
		error:function(e){
			console.log(e);
		}
	})
}

function sendData() {
	 window.opener.drawAppList(appVal);
	 window.close();
}









</script>
</html>