<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/res/style.css" />
<link rel="stylesheet" href="/richtexteditor/rte_theme_default.css" />
<script type="text/javascript" src="/richtexteditor/rte.js"></script>
<script type="text/javascript"
	src='/richtexteditor/plugins/all_plugins.js'></script>
<link href="/css/jquery-explr-1.4.css" rel="stylesheet" type="text/css">	
<style>
.draftTitle {
	width: 10%;
}

.form-control {
	margin-bottom: 0px;
}

.draftSecond {
	width: 20%;
}

form {
	margin-bottom: 0px;
}

.date {
	display: flex;
	width: 450px;
}

.form-control {
	width: 200px;
}

.tdButton {
	text-align: end;
}

.appBtn {
	background: cornflowerblue;
	border: cornflowerblue;
	color: white;
	height: 40px;
	border-radius: 5px;
}

.table-bordered {
	text-align: center;
}

#div_editor {
	height: 500px;
}

.bottomBtn{
	margin: 0 auto;
    width: 31.5%;
}

.botBtn{
	width: 150px;
}

.table_title{
	width: 10px;
}

th{
	width: 100px;
}

.top_div{
	width: 260px;
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
</style>
</head>
<body>

<form action="/approval/writeDraft" method="post" enctype="multipart/form-data">
	<div class="parent">
		<div class="sideBar">
			<jsp:include page="../sideBar.jsp"></jsp:include>
		</div>
		<div class="content">
			<div class="container-fluid">
			<input type="button" class="appBtn" value="결재선 지정" onclick="popup()">
				<div class="row top_div">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-bordered app_line">
										<tbody>
											<tr class="appName">
												<th scope="col" rowspan="3" class="table_title">신청자</th>
												<th scope="col" class="emp_name">
													<input type="hidden" value="${emp_no}" name="emp_no"><br>${name }
												</th>
												<th scope="col" rowspan="3" class="table_title validation">결재자</th>
											</tr>
											<tr class="rankName">
												<td>${rank_name}</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<div class="table-responsive">
									<table class="table">
										<tr>
											<td class="draftTitle">제목</td>
											<td class="draftSecond"><input type="text" class="form-control" id="prenametext" value="${name }의 휴가신청서" name="draft_subject"></td>
											<td>마감기한</td>
											<td>
												<input type="date" class="form-control" value="" name="deadline">
											</td>
										</tr>
										<tr>
											<td class="draftTitle">휴가종류</td>
											<td><select class="form-control" id="exampleFormControlSelect1" name="leave_type">
													<option>연차</option>
													<option>오전 반차</option>
													<option>오후 반차</option>
													<option>경조사</option>
													<option>공가</option>
													<option>병가</option>
													<option>대체휴가</option>
											</select></td>
											<td>보유 연차일수</td>
											<td>25일</td>
										</tr>
										<tr>
											<td class="draftTitle">기간</td>
											<td>
													<div class="date">
														<input type="date" class="form-control startDate" value="" name="start_date" onchange="calculateDays()">
														~ <input type="date" class="form-control endDate" value="" name="end_date" onchange="calculateDays()">
													</div>
											</td>
											<td>선택일수</td>
											<td class="selectDate"></td>
										</tr>
										<tr>
											<td class="draftTitle">참조자</td>
											<td colspan="2" class="referrer">
											<input type="hidden" value="0" name="referrer">
											</td>
											<td class="tdButton" rowspan="2"><button type="button" class="btn waves-effect waves-light btn-light" data-toggle="modal"
                                        		data-target=".referrer_modal">조직도</button></td>
										</tr>
										<tr>
											<td class="draftTitle">조회자</td>
											<td colspan="2" class="viewer">
											<input type="hidden" value="0" name="viewer">
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="div_editor"></div>
				<input type="hidden" name="draft_content">
				<br>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">첨부파일</span>
					</div>
					<div class="custom-file">
						<input type="file" class="custom-file-input" id="inputGroupFile01" name="app_file" multiple="multiple">
						<label class="custom-file-label" for="inputGroupFile01">Choose
							file</label>
					</div>
				</div>
				<div class="bottomBtn">
					<input type="hidden" name="draft_status">
					<input type="button" class="appBtn botBtn" value="임시저장" onclick="save('1')">
					<input type="button" class="appBtn botBtn" value="작성완료" onclick="save('2')">
				</div>
			</div>
		</div>
	</div>	
</form>

<!-- 참조자 모달 -->
<div id="info-header-modal" class="modal fade referrer_modal" tabindex="-1" role="dialog"
    aria-labelledby="referrer-modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header modal-colored-header bg-info">
                <h4 class="modal-title" id="info-header-modalLabel">Modal Heading</h4>
                <button type="button" class="close" data-dismiss="modal"
                    aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <div>
					<ul id="tree">
						<li class="card2">
						</li>
						<li class="customers">
						</li>
						<li class="config">
						</li>
					</ul>
				</div>
				<div class="modal_table">
					<ul class="nav nav-tabs mb-3">
					    <li class="nav-item">
					        <a href="#home" data-toggle="tab" aria-expanded="false" class="nav-link active" onclick="checkTab('referrer')">
					            <i class="mdi mdi-home-variant d-lg-none d-block mr-1"></i>
					            <span class="d-none d-lg-block">참조자</span>
					        </a>
					    </li>
					    <li class="nav-item">
					        <a href="#profile" data-toggle="tab" aria-expanded="true" class="nav-link" onclick="checkTab('viewer')">
					            <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
					            <span class="d-none d-lg-block">조회자</span>
					        </a>
					    </li>
					</ul>
					<div class="tab-content">
					    <div class="tab-pane show active" id="home">
					    	<table class="table table_text">
								<thead>
									<tr>
									</tr>
								</thead>
								<tbody class="modal_table_body">
								</tbody>
							</table>
					    </div>
					    <div class="tab-pane" id="profile">
					    	<table class="table table_text">
								<thead>
									<tr>
										<th><input type="button" class="appBtn" value="인사팀" onclick="addTeam(11)"></th>
										<th><input type="button" class="appBtn" value="고객팀" onclick="addTeam(22)"></th>
										<th><input type="button" class="appBtn" value="시설팀" onclick="addTeam(33)"></th>
									</tr>
								</thead>
								<tbody class="modal_table_viewer">
								</tbody>
							</table>
					    </div>
					</div>
				</div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-info"  data-dismiss="modal" onclick="drawReferrer()">확인</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

	<!--동일 조회/참조자 모달 -->
	<div id="info-alert-modal" class="modal fade same" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-body p-4">
					<div class="text-center">
						<i class="dripicons-information h1 text-info"></i>
						<p class="mt-3">이미 등록된 사원 입니다.</p>
						<button type="button" class="btn btn-info my-2"
							data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	
	<!-- 결재자 미선택 모달 -->
	<div id="info-alert-modal" class="modal fade appNoti" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-body p-4">
					<div class="text-center">
						<i class="dripicons-information h1 text-info"></i>
						<p class="mt-3 noti">결재자를 선택해 주세요.</p>
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
<script src="/js/jquery-explr-1.4.js"></script> 
<script>
	$(document).ready(function(){
		treeCall();
	});

    $('input[type="date"]').attr('min', getTodayDate());
	
	/* 선택일수 표시 */
	function calculateDays() {
		 if ( $('input[name="end_date"]').val() != '' && $('input[name="end_date"]').val() < $('input[name="start_date"]').val()) {
			$('.noti').html('기간을 다시 설정해 주세요');
			$('.appNoti').modal('show');
		} else {
		    var startDate = $('.startDate').val();
		    var endDate =$('.endDate').val();
	
		    var start = new Date(startDate);
		    var end = new Date(endDate);
	
		    var timeDiff = end - start;
	
		    var daysDiff = timeDiff / (1000 * 3600 * 24) + 1;
	
		    if (endDate != '') {
			   $('.selectDate').html(daysDiff + '일<input type="hidden" value="'+daysDiff+'" name="totalDay">');			
			}
		}
	}
	
	
	
	
    function checkTab(item) {
		division = item;
	}
	
	var division = 'referrer';

	var config = {}
	config.toolbar = "basic";
	config.editorResizeMode = "none";
	var editor = new RichTextEditor("#div_editor", config);
	
	function save(saveDivision) {
		var content = editor.getHTMLCode();
		$('input[name="content"]').val(content);
		
		console.log("에디터에 작성된 문자열 : " + editor.getHTMLCode().length)
		
		if (saveDivision == 1) {
			$('input[name="draft_status"]').val('T');
		} else {
			$('input[name="draft_status"]').val('W');
		}
		
		
		if ($('.validation').next().length <= 0) {
			 $('.appNoti').modal('show');
		}else if ($('input[name="deadline"]').val() == '') {
			$('.noti').html('마감기한을 설정해 주세요');
			$('.appNoti').modal('show');
			$('input[name="deadline"]').focus();
		}else if ($('input[name="start_date"]').val() == '') {
			$('.noti').html('시작 날짜를 설정해 주세요');
			$('.appNoti').modal('show');
		}else if ($('input[name="end_date"]').val() == '') {
			$('.noti').html('종료 날짜를 설정해 주세요');
			$('.appNoti').modal('show');
		}else if (content.length > (5 * 1024 * 1024)) {
			$('.noti').html('파일 용량이 초과되었습니다.');
			$('.appNoti').modal('show');
		} else {
			$('form').submit();
		}
		
	}
	
    function popup(){
        var url = "/approval/appChart.go";
        var name = "popup test";
        var option = "width = 1200, height = 500, top = 100, left = 200, location = no"
        window.open(url, name, option);
    }
    
    function drawAppList(appVal) {
    	$('.appName').html('<th scope="col" rowspan="3" class="table_title">신청자</th><th scope="col" class="emp_name"><input type="hidden" value="${emp_no}" name="register"><br>${name }</th><th scope="col" rowspan="3" class="table_title validation">결재자</th>');
		$('.rankName').html('<td>${rank_name}</td>');
		$('.top_div').css('width','800px');
    	
		var content = '';
		var rankName = '';
		var procedure = 1;
		
		for(item of appVal){
			content += '<th scope="col" class="emp_name"><input type="hidden" value="'+procedure+'" name="procedure">';
			content += '<input type="hidden" value="'+item.emp_no+'" name="emp_no">'+item.eName+'</th>';
			rankName += '<td>'+item.rank_name+'</td>';
			procedure += 1;
		}
		$('.appName').append(content);
		$('.rankName').append(rankName);
	}
    
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

    var team = [];
    function drawTree(list) {
    		var card = '<a href="#">인사팀</a><ul>';
    		var customer = '<a href="#">고객팀</a><ul>';
    		var config = '<a href="#">시설팀</a><ul>';
    		var index = 0;
    	
    	if (division == 'referrer') {
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
		}
    	
    	card += '</ul>';
    	customer += '</ul>';
    	config += '</ul>';
    	
    	$('.customers').html(customer);
    	$('.card2').html(card);
    	$('.config').html(config);
    }
    
    var referrer = [];
    var viewer = [];
    var numRef = 0;
    var numView = 0;
    var sameCheckRef = [];
    var sameCheckView = [];
    function addReferrer(index) {
    	if (division == 'referrer') {
    		for(emp of sameCheckRef){
    			if (team[index].emp_no == emp) {
    				$('.same').modal('show');
					return;
				}
    		}
	    	var content = '<tr onclick="removeTd(this)"><input type="hidden" value="'+numRef+'" class="index">';
	    	content += '<td>'+team[index].eName+'</td>';
	    	content += '<td>'+team[index].rank_name+'</td>';
	    	content += '<td><a href="#">삭제</a></td>';
	    	content += '</tr>';
	    	
	    	sameCheckRef.push(team[index].emp_no);
	    	numRef += 1;
	
	    	referrer.push(team[index]);
			
			$('.modal_table_body').append(content);			
		} else {
			for(emp of sameCheckView){
    			if (team[index].emp_no == emp) {
    				$('.same').modal('show');
					return;
				}
    		}
	    	var content = '<tr onclick="removeTd(this)"><input type="hidden" value="'+numView+'" class="index">';
	    	content += '<td>'+team[index].eName+'</td>';
	    	content += '<td>'+team[index].rank_name+'</td>';
	    	content += '<td><a href="#">삭제</a></td>';
	    	content += '</tr>';
	    	
	    	sameCheckView.push(team[index].emp_no);
	    	numView += 1;
	
	    	viewer.push(team[index]);
			
			$('.modal_table_viewer').append(content);			
		}
	}
    
    function removeTd(item) {
    	if (division == 'referrer') {
	    	delete referrer[$(item).children().first().val()];
	    	delete sameCheckRef[$(item).children().first().val()];
	    	console.log(referrer);
			$(item).remove();
		}else{
	    	delete viewer[$(item).children().first().val()];
	    	delete sameCheckView[$(item).children().first().val()];
	    	console.log(viewer);
			$(item).remove();			
		}
	}
    
    function drawReferrer() {
		$('.referrer').html('');	
    	var referrer_emp_no = '<input type="hidden" value="0" name="referrer">';
    	var addReferrer = '';
		for(item of referrer){
			if (item == null) {
				continue;
			} else {
				referrer_emp_no += '<input type="hidden" value="'+item.emp_no+'" name="referrer">';
				addReferrer += item.name+'/';
			}
		}
		if (addReferrer.length>20) {
			addReferrer = addReferrer.substr(0,  32) + '...';
		}
		$('.referrer').append(addReferrer);	
		$('.referrer').append(referrer_emp_no);	
		
		$('.viewer').html('');	
		
    	var viewer_emp_no = '<input type="hidden" value="0" name="viewer">';
    	var addViewer = '';
		for(item of viewer){
			if (item == null) {
				continue;
			} else {
				viewer_emp_no += '<input type="hidden" value="'+item.emp_no+'" name="viewer">';
				addViewer += item.name+'/';
			}
		}
		if (addViewer.length>20) {
			addViewer = addViewer.substr(0,  32) + '...';
		}
		$('.viewer').append(addViewer);	
		$('.viewer').append(viewer_emp_no);	
	}
    
    function addTeam(code) {
    	for(emp of sameCheckView){
			if (code == emp) {
				$('.same').modal('show');
				return;
			}
		}
    	var team_name = '';
    	if (code == 11) {
        	var content = '<tr onclick="removeTd(this)"><input type="hidden" value="'+numView+'" class="index">';
        	content += '<td colspan="2">인사팀</td>';
        	content += '<td><a href="#">삭제</a></td>';
        	content += '</tr>';
        	
        	team_name = '인사팀';
		}
    	
    	if (code == 22) {
        	var content = '<tr onclick="removeTd(this)"><input type="hidden" value="'+numView+'" class="index">';
        	content += '<td colspan="2">고객팀</td>';
        	content += '<td><a href="#">삭제</a></td>';
        	content += '</tr>';
        	
        	team_name = '고객팀';
		}
    	
    	if (code == 33) {
        	var content = '<tr onclick="removeTd(this)"><input type="hidden" value="'+numView+'" class="index">';
        	content += '<td colspan="2">시설팀</td>';
        	content += '<td><a href="#">삭제</a></td>';
        	content += '</tr>';
        	
        	team_name = '시설팀';
		}
    	sameCheckView.push(code);
    	console.log(sameCheckView);
    	numView += 1;
 
    	viewer.push({'emp_no' : code, 'name' : team_name});
		
		$('.modal_table_viewer').append(content);			
	}
    
    function getTodayDate() {
        var today = new Date();
        var year = today.getFullYear();
        var month = ('0' + (today.getMonth() + 1)).slice(-2);
        var day = ('0' + today.getDate()).slice(-2);
        return year + '-' + month + '-' + day;
    }
    
    
    
</script>
</html>