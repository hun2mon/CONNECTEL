<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/res/style.css" />
<link rel="stylesheet" type="text/css" href="/assets/extra-libs/prism/prism.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.3.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.3.2/html2canvas.min.js"></script>
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
	color: black;
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

.emp_name{
	width: 210px;
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
											<td>${dto.leftOver}일</td>
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
				<div class="card" id="pdf_body">
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
										<td class="table_content">${dto.leftOver}일</td>
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
					<div class="bottomBtn">
						<c:if test="${loginInfo.emp_no == dto.register && dto.draft_status == 'N' }">
							<input type="button" class="appBtn botBtn" value="재기안" onclick="reApproval()">
							<input type="button" class="appBtn2 botBtn" value="이전" onclick="history.back()">
						</c:if>
						<c:if test="${dto.draft_status == 'Y'}">
							<input type="button" class="appBtn2 botBtn" value="pdf 다운로드" onclick="downloadPDF()">
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<div id="info-header-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="info-header-modalLabel" aria-hidden="true">
		<div class="modal-dialog">
        	<div class="modal-content">
            	<div class="modal-header modal-colored-header bg-info">
               		<h4 class="modal-title" id="info-header-modalLabel">기안서 결재</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				</div>
				<div class="modal-body">
					<h5 class="mt-0">기안서를 결재하시겠습니까?</h5>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-light" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-info" id="approve">확인</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	
	<div id="info-alert-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
	    <div class="modal-dialog modal-sm">
	        <div class="modal-content">
	            <div class="modal-body p-4">
	                <div class="text-center">
	                    <i class="dripicons-information h1 text-info"></i>
	                    <p class="mt-3">결재가 완료 되었습니다.</p>
	                    <button type="button" class="btn btn-info my-2" data-dismiss="modal" id="location">확인</button>
	                </div>
	            </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	
	
	<!-- Danger Header Modal -->
	<div id="danger-header-modal" class="modal fade" tabindex="-1" role="dialog"
	    aria-labelledby="danger-header-modalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header modal-colored-header bg-danger">
	                <h4 class="modal-title" id="danger-header-modalLabel">반려 하시겠습니까?</h4>
	                <button type="button" class="close" data-dismiss="modal"
	                    aria-hidden="true">×</button>
	            </div>
	            <div class="modal-body">
	            	<textarea class="form-control" rows="3" placeholder="반려 사유를 입력해 주세요...." id="comReason"></textarea>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-light"
	                    data-dismiss="modal">닫기</button>
	                <button type="button" class="btn btn-danger" id="companion">반려</button>
	            </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	
	
	
	
	
	
	
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
    			drawButton(data.approver);
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
				if (item.app_status == 'N') {
					appSign += '<td>반려</td>';
				} else {
					appSign += '<td>'+item.name+'</td>';					
				}
				var dateFormat = new Date(item.app_date);
				drafterDate = dateFormat.toLocaleDateString();
				appSignDate += '<td>'+drafterDate+'</td>';
			}
		}
		
		$('#approver').append(appName);
		$('#approver_sign').append(appSign);
		$('#sign_date').append(appSignDate);
	}
	
	var max_procedure = '';
	function drawButton(approvers){
		var content = '';
		max_procedure = approvers.length;
		for (item of approvers) {
			if (item.emp_no == '${loginInfo.emp_no}' && item.app_date == null) {
				content += '<input type="button" class="appBtn botBtn" value="승인" onclick="approve(\''+item.emp_no+'\',\''+item.app_procedure+'\')">';
				content += '<input type="button" class="appBtn2 botBtn" value="반려" onclick="companion(\''+item.emp_no+'\')">';
			}
		}
		
		if (content != '') {
			$('.bottomBtn').html(content);			
		}
	}
	
	// 결재 승인
	function approve(emp_no, procedure){
		var division = 0
		$('#info-header-modal').modal('show');
		
		console.log(emp_no);
		console.log(procedure);
		console.log(max_procedure);

		$('#approve').on("click",function(){
			
			$.ajax({
	    		url:'/approval/approve.ajax',
	    		method:'post',
	    		data:{
	    			draft_no:'${dto.draft_no}'
					,emp_no:emp_no
					,procedure:procedure
					,max_procedure:max_procedure
					,register:'${dto.register}'
					,annual:'${dto.leave_use}'
	    		},
	    		dataType:'JSON',
	    		success:function(data){
					console.log(data);
					if (data.msg != '') {
						$('#info-header-modal').modal('hide');
						$('#info-alert-modal').modal('show');
						$('#info-alert-modal').on("click",function(){
							location.href="/approval/requestApproval.go";							
						})
					}
	    		},
	    		error:function(e){
	    			console.log(e);
	    		}
    		}) 
		})
	}
	
	// 결재 반려
	function companion(emp_no){
		$('#danger-header-modal').modal("show");
		console.log(emp_no);
		
		$('#companion').on("click",function(){
			var reason = $('#comReason').val();
			if (reason == '') {
				$('.mt-3').html('사유를 입력해 주세요');
				$('#info-alert-modal').modal('show');
				return;
			}
			else{
			
				$.ajax({
		    		url:'/approval/comapnion.ajax',
		    		method:'post',
		    		data:{
		    			draft_no:'${dto.draft_no}'
						,emp_no:emp_no
						,reason:reason
		    		},
		    		dataType:'JSON',
		    		success:function(data){
						console.log(data);
						if (data.msg != '') {
							$('#danger-header-modal').modal("hide");
							$('#info-alert-modal').modal('show');
							$('.mt-3').html(data.msg);
							$('#info-alert-modal').on("click",function(){
								location.href="/approval/requestApproval.go";							
							})
						}
		    		},
		    		error:function(e){
		    			console.log(e);
		    		}
	    		}) 
			}
		})
	}
	
	
	
	// pdf 다운로드
	function downloadPDF() {
	    const element = document.getElementById('pdf_body');

	    html2canvas(element).then((canvas) => {
	    	let imgData = canvas.toDataURL('image/png');

	        let imgWidth = 210; // 이미지 가로 길이(mm) A4 기준
	        let pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
	        let imgHeight = canvas.height * imgWidth / canvas.width;
	        let heightLeft = imgHeight;

	        let doc = new jspdf.jsPDF('p', 'mm');
	        let position = 0;


	        doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
	        doc.save('${dto.draft_no}' + '_' +'${dto.draft_subject}' + '.pdf');
	    });
	}
	
	function reApproval() {
		location.href='/approval/draftDetail?draft_no=${dto.draft_no}&draft_status=T';
	}
	

</script>
</html>