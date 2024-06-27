<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/res/style.css" />
<link rel="stylesheet" type="text/css"
	href="/assets/extra-libs/prism/prism.css">
<style>
.approver, .draft_content {
	text-align: center;
	width: 800px;
	font-size: small;
}

.approver, .approver th, .approver td, .draft_content, .draft_content th,
	.draft_content td {
	border: 1px solid black;
	border-collapse: collapse;
	padding: 10px 3px;
}

.smallWidth {
	width: 10px;
}

.title {
	background-color: lightgrey;
	width: 100px;
}

.table_content {
	width: 200px;
}

.reason {
	height: 300px;
}

.approver {
	width: auto;
}

.main_div {
	width: 800px;
	text-align: -webkit-right;
}

.draft_body {
	margin-top: 20px;
}

.draft_title {
	text-align: center;
}

.draftTitle {
	width: 10%;
}

.draftSecond {
	width: 20%;
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

.appBtn2 {
	background: darkgray;
	border: darkgray;
	color: white;
	height: 40px;
	border-radius: 5px;
}

.table-bordered {
	text-align: center;
}

#div_editor {
	height: auto;
	width: 100%;
	overflow: hidden;
}

.bottomBtn {
	margin: 0 auto;
	width: 44%;
}

.botBtn {
	width: 150px;
}

.table_title {
	width: 10px;
	max-width: 10px;
}

th {
	width: 100px;
}

.top_div {
	width: 800px;
}

.card-body {
	text-align: -webkit-center;
}

#bottom{
	display: flex;
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
				<div class="row top_div">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-bordered app_line">
										<tbody>
											<tr class="appName">
												<th scope="col" rowspan="3" class="table_title">신청자</th>
												<th scope="col" class="emp_name drafter"></th>
												<th scope="col" rowspan="3" class="table_title validation">결재자</th>
											</tr>
											<tr class="sign">
												<td class="drafterSign">1</td>
											</tr>
											<tr class="signDate">
												<td class="drafterDate">1</td>
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
											<td class="draftSecond">${dto.draft_subject}</td>
											<td>마감기한</td>
											<td>2024-07-01</td>
										</tr>
										<tr>
											<td class="draftTitle">휴가종류</td>
											<td>${dto.leave_cate}</td>
											<td>보유 연차일수</td>
											<td>25일</td>
										</tr>
										<tr>
											<td class="draftTitle">기간</td>
											<td>
												<div class="date">${dto.leave_start}~ ${dto.leave_end}</div>
											</td>
											<td>신청일수</td>
											<td class="selectDate">${dto.leave_use}일</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="card">
					<div class="card-body">
						<div class="main_div">
							<div class="draft_title">
								<h1>휴가신청서</h1>
							</div>
							<div class="draft_head">
								<table class="approver">
									<tr id="approver">
										<th rowspan="3" class="smallWidth">결재자</th>
									</tr>
									<tr id="approver_sign">
									</tr>
									<tr id="sign_date">
									</tr>
								</table>
							</div>
							<div class="draft_body">
								<table class="draft_content">
									<tr>
										<th class="title">문서번호</th>
										<td class="table_content">${dto.draft_no }</td>
										<th class="title">작성일자</th>
										<td>${dto.draft_start }</td>
									</tr>
									<tr>
										<th class="title">이름</th>
										<td class="table_content">${dto.name }</td>
										<th class="title">보유 연차일수</th>
										<td class="table_content">25일</td>
									</tr>
									<tr>
										<th class="title">부서</th>
										<td class="table_content">${dto.dept_name }</td>
										<th class="title">직급</th>
										<td class="table_content">${dto.rank_name }</td>
									</tr>
									<tr>
										<th class="title">제목</th>
										<td colspan="3">${dto.draft_subject }</td>
									</tr>
									<tr>
										<th class="title">종류</th>
										<td colspan="3">${dto.leave_cate }</td>
									</tr>
									<tr>
										<th class="title">일정</th>
										<td colspan="3">${dto.leave_start }~ ${dto.leave_end}
											(${dto.leave_use }일)</td>
									</tr>
									<tr>
										<th class="title">신청 사유</th>
										<td colspan="3" class="reason">${dto.draft_content}</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div id="bottom">
					<div class="input-group mb-3">
						<div id="accordion" class="custom-accordion mb-4">
							<div class="card mb-0">
								<div class="card-header" id="headingOne">
									<h5 class="m-0">
										<a class="custom-accordion-title d-block pt-2 pb-2" data-toggle="collapse" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne"> 
											3개의 첨부파일 <span class="float-right"><i class="mdi mdi-chevron-down accordion-arrow"></i></span>
										</a>
									</h5>
								</div>
								<div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordion">
									<div class="card-body" id="file">
									</div>
								</div>
							</div>
							<!-- end card-->
						</div>
					</div>
					<c:if test="${loginInfo.emp_no != dto.register && dto.draft_status != 'N' && dto.draft_status != 'Y'}">
						<div class="bottomBtn">
							<input type="button" class="appBtn botBtn" value="승인" onclick="">
							<input type="button" class="appBtn2 botBtn" value="반려" onclick="">
						</div>					
					</c:if>
					<c:if test="${loginInfo.emp_no == dto.register && dto.draft_status == 'N' }">
						<div class="bottomBtn">
							<input type="button" class="appBtn botBtn" value="재기안" onclick="">
							<input type="button" class="appBtn2 botBtn" value="이전" onclick="">
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</body>
<script src="/assets/extra-libs/prism/prism.js"></script>
<script>
	approverCall();
	
	function approverCall() {
		var draft_no = '${dto.draft_no}'; 
		$.ajax({
    		url:'/approval/approverCall.ajax',
    		method:'get',
    		data:{
    			draft_no:draft_no
    		},
    		dataType:'JSON',
    		success:function(data){
    			console.log(data.approver);
    			drawApprover(data.approver, data.fileList);
    		},
    		error:function(e){
    			console.log(e);
    		}
    	})
	}
	
	function drawApprover(approver, files) {
		console.log(approver);
		var drafter =	approver[0].rank_name+'<br>'+approver[0].name;
		$('.drafter').html(drafter);
		var drafterSign = '';
		var drafterDate = '';
		var appName = '';
		var appSign = '';
		var appSignDate='';
		var fileList = '';
		var fileCnt = '';
		
		if (files.length > 0) {
			for (item of files) {
				console.log(item);
				fileList += '<a href="/download/'+item.file_name+'">'+item.ori_file_name+'</a><br>';
			}			
			fileCnt += '<a class="custom-accordion-title d-block pt-2 pb-2" data-toggle="collapse" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">';
			fileCnt += files.length + '개의 첨부파일 <span class="float-right"><i class="mdi mdi-chevron-down accordion-arrow"></i></span></a>';
			
		}
		
		
		
		for (item of approver) {
			
			
			if (item.app_procedure == 1) {
				drafterSign = item.name;
				var dateFormat = new Date(item.app_date);
				drafterDate = dateFormat.toLocaleString();
			} else if (item.app_date == null) {
				appName += '<th scope="col" class="emp_name">'+item.rank_name+'<br>'+item.name+'</th>';
				appSign += '<td></td>';
				appSignDate += '<td></td>';
			} else {
				appName += '<th scope="col" class="emp_name">'+item.rank_name+'<br>'+item.name+'</th>';
				if (item.app_status == 'N') {
					appSign += '<td>반려</td>';
				} else {
					appSign += '<td>'+item.name+'</td>';					
				}
				var dateFormat = new Date(item.app_date);
				drafterDate = dateFormat.toLocaleString();
				appSignDate += '<td>'+drafterDate+'</td>';
			}
		}
		
		$('.drafterSign').html(drafterSign);
		$('.drafterDate').html(drafterDate);
		$('.appName').append(appName);
		$('.sign').append(appSign);
		$('.signDate').append(appSignDate);
		$('#file').html(fileList);
		$('.m-0').html(fileCnt);
		
		appName = '';
		appSign = '';
		appSignDate='';
		
		
		for (item of approver) {
				
			if (item.app_date == null) {
				appName += '<td>'+item.rank_name+'<br>'+item.name+'</td>' ;
				appSign += '<td></td>';
				appSignDate += '<td></td>';
			} else {
				appName += '<td>'+item.rank_name+'<br>'+item.name+'</td>' ;
				appSign += '<td>'+item.name+'</td>';
				var dateFormat = new Date(item.app_date);
				drafterDate = dateFormat.toLocaleDateString();
				appSignDate += '<td>'+drafterDate+'</td>';
			}
		}
		
		$('#approver').append(appName);
		$('#approver_sign').append(appSign);
		$('#sign_date').append(appSignDate);
	}

</script>
</html>