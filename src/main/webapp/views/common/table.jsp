<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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

.pagging{
	margin: 0 auto;
    padding: 0px;
    width: 333px;
    height: 40px;
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
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<div class="table-responsive">
									<ul class="navbar-nav float-right">
										<!-- ============================================================== -->
										<!-- Search -->
										<!-- ============================================================== -->
										<li class="nav-item d-none d-md-block"><a
											class="nav-link" href="javascript:void(0)">
												<div class="customize-input">
													<input
														class="form-control custom-shadow custom-radius border-0 bg-white"
														type="search" placeholder="Search" aria-label="Search"
														onkeyup="search()">
												</div>
										</a></li>
									</ul>
									<table class="table table-bordered">
										<thead>
											<tr>
												<th scope="col">부서</th>
												<th scope="col">이름</th>
											</tr>
										</thead>
										<tbody class="table_content">
										</tbody>
										<tr>
											<td colspan="2">
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
				</div>
			</div>
		</div>
	</div>
</body>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="/js/jquery.twbsPagination.js" type="text/javascript"></script>
<script>
var showPage = 1;
var num;

$(document).ready(function(){
	listCall(showPage);
});

function search() {
	$('#pagination').twbsPagination('destroy');
	listCall(showPage);
}

function listCall(showPage) {
	
	var search = $('.form-control').val();
	
	$.ajax({
		url:'/listCall.ajax',
		method:'get',
		data:{
			search : search,
			page : showPage,
			cnt : 10
		},
		dataType:'JSON',
		success:function(data){
			drawList(data.list);
			
			var totalPages = data.totalPages;
			
			$('#pagination').twbsPagination({
            	startPage:1, // 시작페이지
            	totalPages:totalPages, // 총 페이지 수
            	visiblePages:5, // 보여줄 페이지 수 1,2,3,4,5
            	onPageClick:function(evt,pg){ // 페이지 클릭시 실행 함수
            		listCall(pg);
            	}
            })
		},
		error:function(e){
			console.log(e);
		}
	})
}

function drawList(list) {
	var content = '';
	
	if (list.length == 0) {
		content = '<td colspan="2">검색 결과가 없습니다.</td>';
		$('#pagination').twbsPagination('destroy');
	} else {
		for(item of list){
			content += '<tr>';
			content += '<td>' + item.dept_name + '</td>';
			content += '<td>' + item.name + '</td>';
			content += '</tr>';
		}		
	}
	

	$('.table_content').html(content);
}

</script>
</html>