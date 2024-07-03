<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>

   body {
        margin: 0;
        padding: 0;
        display: flex;
        height: 100vh;
        overflow: hidden;
    }

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

.pagging{
	margin: 0 auto;
    padding: 0px;
    width: 333px;
    height: 40px;
}

.appContent{
	flex-grow: 1;
    padding: 20px;
    overflow-y: auto;
    margin-top: 81px;
}

.table{
	text-align: center;
}

.subject{
	width: 450px;
}

.modal {
  display: none;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.4);
}

.modal_my {
  background-color: #fefefe;
  margin: 15% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 30%;
  height: 20%;
}

.close-button {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close-button:hover,
.close-button:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

.modalBtn{
	float: right;
}

.appBtn {
	background: cornflowerblue;
	border: cornflowerblue;
	color: white;
	height: 40px;
	border-radius: 5px;
	width: 60px;
}

.card{
	width: 1415px;
}

</style>
</head>
<body>
	<div class="parent">
		<div class="sideBar">
			<jsp:include page="../sideBar.jsp"></jsp:include>
		</div>
		<div class="appContent">
			<div class="row">
				<div>
					<div class="card">
						<div class="card-body">
							<h4 class="card-title mb-3">내 기안문서</h4>

							<ul class="nav nav-tabs mb-3">
								<li class="nav-item" onclick="cateListCall()">
									<a href="#home" data-toggle="tab" aria-expanded="false" class="nav-link active">
										<input type="hidden" value="T">
										<i class="mdi mdi-home-variant d-lg-none d-block mr-1"></i>
										<span class="d-none d-lg-block">전체보기</span>
									</a>
								</li>
								<li class="nav-item" onclick="cateListCall('W')">
									<a href="#home" data-toggle="tab" aria-expanded="true" class="nav-link">
										 <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i> 
										 <span class="d-none d-lg-block">기안중</span>
									</a>
								</li>
								<li class="nav-item" onclick="cateListCall('N')">
									<a href="#home" data-toggle="tab" aria-expanded="false" class="nav-link"> 
										<i class="mdi mdi-settings-outline d-lg-none d-block mr-1"></i> 
										<span class="d-none d-lg-block">반려</span>
									</a>
								</li>
								<li class="nav-item"  onclick="cateListCall('Y')">
									<a href="#home" data-toggle="tab" aria-expanded="false" class="nav-link">
										<i class="mdi mdi-settings-outline d-lg-none d-block mr-1"></i>
										<span class="d-none d-lg-block">결재</span>
									</a>
								</li>
								<li class="nav-item" onclick="cateListCall('T')">
									<a href="#home" data-toggle="tab" aria-expanded="false" class="nav-link">
										<input type="hidden" value="T">
								 		<i class="mdi mdi-settings-outline d-lg-none d-block mr-1"></i>
								 		<span class="d-none d-lg-block">임시저장</span>
									</a>
								</li>
							</ul>

							<div class="tab-content">
								<div class="tab-pane show active" id="home">
									<div class="table-responsive">
										<ul class="navbar-nav float-right">
											<!-- ============================================================== -->
											<!-- Search -->
											<!-- ============================================================== -->
											<li class="nav-item d-none d-md-block"><a
												class="nav-link" href="javascript:void(0)">
														<input
															class="form-control custom-shadow custom-radius border-0 bg-white"
															type="search" placeholder="Search" aria-label="Search"
															onkeyup="search()">
											</a></li>
										</ul>
										<table class="table table-bordered">
											<thead>
												<tr>
													<th scope="col">문서번호</th>
													<th scope="col">기안날짜</th>
													<th scope="col" class="subject">제목</th>
													<th scope="col">기안자</th>
													<th scope="col">최종 결재자</th>
													<th scope="col">결재</th>
													<th scope="col">상태</th>
												</tr>
											</thead>
											<tbody class="table_content">
											</tbody>
											<tr>
												<td colspan="7">
													<div class="pagging">
														<nav aria-label="Page navigation"
															style="text-align: center">
															<ul class="pagination" id="pagination"></ul>
														</nav>
													</div>
												</td>
											</tr>
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
			</div>
		</div>
	</div>
	
	
	
<div id="modal" class="modal">
  <div class="modal_my">
    <h4>반려 사유</h4>
    <hr>
    <p class="compReason">Modal content goes here...</p>
   	<div class="modalBtn">
	  	<input type="button" value="닫기" class="appBtn" id="modal_close">
   	</div>
  </div>
</div>
	
	
</body>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="/js/jquery.twbsPagination.js" type="text/javascript"></script>
<script>

var startPage = 1;
var num;
var category;

$(document).ready(function(){
	listCall(startPage);
});

function cateListCall(cate) {
	category = cate;
	$('#pagination').twbsPagination('destroy');
	listCall(startPage, category);
}

function search() {
	$('#pagination').twbsPagination('destroy');
	listCall(startPage, category);
}

var dontDouble = false;
function listCall(showPage, cate) {
	
	if(dontDouble) {
		return;
	}
	dontDouble = true;
	
	console.log(cate);
	console.log(showPage);
	var search = $('.form-control').val();
	
	$.ajax({
		url:'/approval/myAppListCall.ajax',
		method:'get',
		data:{
			search : search,
			page : showPage,
			cnt : 10,
			cate : cate
		},
		dataType:'JSON',
		success:function(data){
			drawList(data.list);

			
			var totalPages = data.totalPages;
			
			if (data.totalPages > 0) {
				$('#pagination').twbsPagination({
	            	startPage:showPage, // 시작페이지
	            	totalPages:totalPages, // 총 페이지 수
	            	visiblePages:5, // 보여줄 페이지 수 1,2,3,4,5
	            	onPageClick:function(evt,pg){ // 페이지 클릭시 실행 함수
	            		listCall(pg,cate);
	            	}
	            })				
			}			
			
			dontDouble = false;
			
		},
		error:function(e){
			console.log(e);
		}
	})
}

function drawList(list) {
	var content = '';
	
	if (list.length == 0) {
		content = '<td colspan="7">검색 결과가 없습니다.</td>';
		$('#pagination').twbsPagination('destroy');
	} else {
		for(item of list){
			content += '<tr>';
			content += '<td>' + item.draft_no + '</td>';
			content += '<td>' + item.draft_start + ' ~ ' +item.draft_end + '</td>';
			content += '<td>' + item.draft_subject + '</td>';
			content += '<td>' + item.register + '</td>';
			content += '<td>' + item.final_approver + '</td>';
			content += '<td><a href="/approval/draftDetail?draft_no='+item.draft_no+'&draft_status='+item.draft_status+'">보기</a></td>';
			if (item.draft_status == 'W') {
				content += '<td>기안중</td>';					
			}
			if (item.draft_status == 'Y') {
				content += '<td>결재</td>';					
			}
			if (item.draft_status == 'N') {
				content += '<td><a href="javascript:reason(\''+item.draft_no+'\')">반려</a></td>';					
			}
			if (item.draft_status == 'T') {
				content += '<td>임시저장</td>';					
			}
			content += '</tr>';
		}		
	}
	
	$('.table_content').html(content);
}

function reason(draft_no) {
	$.ajax({
		url:'/approval/compReason.ajax',
		method:'post',
		data:{
			draft_no:draft_no 
		},
		dataType:'JSON',
		success:function(data){
			var modal = document.getElementById("modal");
			$('.compReason').html(data.reason);
			modal.style.display = "block";
			$('#modal_close').on("click",function(){
				modal.style.display = "none";	
			})
		},
		error:function(e){
			console.log(e);
		}
	})
}

	
</script>
</html>