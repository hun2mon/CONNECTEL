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
	width: 800px;
}
</style>
</head>
<body>

<form action="/test" method="post">
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
											<tr>
												<th scope="col" rowspan="3" class="table_title">신청자</th>
												<th scope="col" class="emp_name">사원<br>김정훈</th>
												<th scope="col" rowspan="3" class="table_title">결재자</th>
												<th scope="col" class="emp_name"></th>
												<th scope="col" class="emp_name"></th>
												<th scope="col" class="emp_name"></th>
												<th scope="col" class="emp_name"></th>
											</tr>
											<tr>
												<td>김정훈</td>
												<td><input type="hidden" value="SH12341234" name="emp_no"></td>
												<td><input type="hidden" value="SH12341234" name="emp_no"></td>
												<td><input type="hidden" value="SH12341234" name="emp_no"></td>
												<td><input type="hidden" value="SH12341234" name="emp_no"></td>
											</tr>
											<tr>
												<td>2024/06/22</td>
												<td><input type="hidden" value="SH43214321" name="emp_no"></td>
												<td><input type="hidden" value="SH43214321" name="emp_no"></td>
												<td><input type="hidden" value="SH43214321" name="emp_no"></td>
												<td><input type="hidden" value="SH43214321" name="emp_no"></td>
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
											<td class="draftTitle">양식</td>
											<td class="draftSecond">휴가신청서</td>
											<td>마감기한</td>
											<td>
												<input type="date" class="form-control" value="" name="deadline">
											</td>
										</tr>
										<tr>
											<td class="draftTitle">휴가종류</td>
											<td><select class="form-control" id="exampleFormControlSelect1" name="leave_type">
													<option>연차</option>
													<option>반차</option>
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
														<input type="date" class="form-control" value="" name="start_date">
														~ <input type="date" class="form-control" value="" name="end_date">
													</div>
											</td>
											<td>선택일수</td>
											<td></td>
										</tr>
										<tr>
											<td class="draftTitle">참조자</td>
											<td colspan="2">
												<input type="hidden" value="SH12341234" name="referrer">
												<input type="hidden" value="SH12341234" name="referrer">
												<input type="hidden" value="SH12341234" name="referrer">
												<input type="hidden" value="SH12341234" name="referrer">
												<input type="hidden" value="SH12341234" name="referrer">
											</td>
											<td class="tdButton"><button type="button" class="btn waves-effect waves-light btn-light">조직도</button></td>
										</tr>
										<tr>
											<td class="draftTitle">조회자</td>
											<td colspan="2"></td>
											<td class="tdButton"><button type="button"
													class="btn waves-effect waves-light btn-light">조직도</button></td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="div_editor"></div>
				<input type="hidden" name="content">
				<br>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">첨부파일</span>
					</div>
					<div class="custom-file">
						<input type="file" class="custom-file-input" id="inputGroupFile01" name="app_file">
						<label class="custom-file-label" for="inputGroupFile01">Choose
							file</label>
					</div>
				</div>
				<div class="bottomBtn">
					<input type="button" class="appBtn botBtn" value="임시저장">
					<input type="button" class="appBtn botBtn" value="작성완료" onclick="save()">
				</div>
			</div>
		</div>
	</div>	
</form>
</body>
<script>
	var config = {}
	config.toolbar = "basic";
	config.editorResizeMode = "none";
	var editor = new RichTextEditor("#div_editor", config);
	
	function save() {
		// 에디터에 작성된 문자열을 가져온다.
		var content = editor.getHTMLCode();
		$('input[name="content"]').val(content);
		
		//  이미지가 1MB 이하면 전송은 된다.
		// 이미지가 2MB 이상이면 전송되지 않는다.
		// tomcat 에서는 POST 전송 시 최대 2MB 까지만 받을 수 있도록 기본설정 되어 있다.
		// 그래서 그보다 많은 내용이 들어오면 받을 수 없어 null로 처리된다.
		// 해결방법 1 (외장 톰캣) - server.xml < Connector maxPostSize = "-1" ...로 잡아주거나 특정 크기로 정해준다.(byte)
		// 해결방법 2(내장톰캣 방법) - application.properties 에 설정 server.tomcat.max-http-form-post-size=100MB
		
		console.log("에디터에 작성된 문자열 : " + editor.getHTMLCode().length)
		
		if (content.length < (5 * 1024 * 1024)) {
			$('form').submit();
		} else {
			alert('5MB 초과 입니다.');
		}
		
		$('.form').submit();
		
	}
	
    function popup(){
        var url = "/approval/appChart.go";
        var name = "popup test";
        var option = "width = 1200, height = 500, top = 100, left = 200, location = no"
        window.open(url, name, option);
    }
</script>
</html>