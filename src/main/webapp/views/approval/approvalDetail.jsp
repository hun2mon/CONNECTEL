<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/res/style.css" />
<link rel="stylesheet" href="/richtexteditor/rte_theme_default.css" />
<script type="text/javascript" src="/richtexteditor/rte.js"></script>
<script type="text/javascript" src='/richtexteditor/plugins/all_plugins.js'></script>
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
	height: auto;
	width: 100%;
	overflow: hidden;
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
	max-width: 10px;
}

th{
	width: 100px;
}

.top_div{
	width: 800px;
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
													<div class="date">${dto.leave_start} ~ ${dto.leave_end}</div>
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
				<div id="div_editor"></div>
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
	<div id="content">${dto.draft_content}</div>
</body>
<script>	
$(document).ready(function() {
    var config = {};
    config.toolbar = "simple"; // basic은 거의 대부분의 기능이 나타나지만, simple 은 아무것도 나타나지 않는다.
    config.toolbar_simple = "{save,print,html2pdf}"; // 저장, 출력, pdf, html 코드보기

    config.editorResizeMode = "none";

    // 에디터 초기화
    var editor = new RichTextEditor("#div_editor", config);
    editor.setHTMLCode($('#content').html());
    editor.setReadOnly();

    // 이미지 크기를 조정하는 스타일 추가
    $('#div_editor img').css({
        'max-width': '100%',
        'height': 'auto'
    });
    
    $('#content').css('display','none');
});
	
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
    			drawApprover(data.approver);
    		},
    		error:function(e){
    			console.log(e);
    		}
    	})
	}
	
	function drawApprover(approver) {
		console.log(approver);
		var drafter =	approver[0].rank_name+'<br>'+approver[0].name;
		$('.drafter').html(drafter);
		var drafterSign = '';
		var drafterDate = '';
		var appName = '';
		var appSign = '';
		var appSignDate='';
		
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
				appSign += '<td>'+item.name+'</td>';
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
	}

</script>
</html>