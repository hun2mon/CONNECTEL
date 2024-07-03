<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
	.searchType{
		border-radius: 30%;
	}
	#searchText{
		width: 30%;
	}
	.searchdd{
		display : flex;
		text-align:right;
		margin-left:800px;
		width : 800px;
	}
	#excelForm{
		text-align : right;
		margin-right :100px;
	}
	.btnss button {
	    /* 기본 버튼 스타일 */
	    background-color: #ccc;
	    padding: 10px;
	    margin-right: 5px;
	    border: none;
	    cursor: pointer;
	}
	
	.btnss button.active {
	    /* 선택된 버튼 스타일 */
	    background-color: #444; /* 진한 회색 배경색 */
	    color: #fff; /* 글자색은 흰색 */
	    font-weight: bold;
	}
	.btnss{
		display : flex;
	}
	#searchdd{
		display : flex;
	}
	.parent {
		display: flex;
	}
	
	.sidebar {
		width: 250px;
		background-color: #f0f0f0;
		padding: 10px;
	}
	.content {
		flex: 1;
		padding: 20px;
		display: flex;
		flex-direction: column;
	}
	.filterTab{
		margin: 0 auto;
	}
	.input-container {
		position: relative;
		display: inline-block;
		width: 100%;
	}
	.input-container input {
		width: calc(100% - 40px);
		padding-right: 40px;
		box-sizing: border-box;
	}
	.input-container img {
		position: absolute;
		right: 10px;
		top: 50%;
		transform: translateY(-50%);
		cursor: pointer;
	}
	.titless{
		text-align : center;
	}
</style>
</head>
<body>
	<div class="parent">
		<div class="sidebar">
			<jsp:include page="../sideBar.jsp"></jsp:include>
		</div>
		<div class="content">
			<section>
			<div style= "text-align:right display : flex; margin : 0">
				<div id = "searchdd"">
					<select id="searchType" class="searchType">
						<option value="1" class="searchType">이름</option>
						<option value="2" class="searchType">재직상태</option>
						<input aria-label="Search" type="search" class="form-control custom-shadow custom-radius bg-white" type="text" id="searchText" onkeyup="search()" placeholder : "내용을 입력해주세요">
					</select>
				</div>
				</div><br>
				
							<ul class="nav nav-tabs mb-3">
								<li class="nav-item" onclick="setCategory(1)">
									<a href="#home" data-toggle="tab" aria-expanded="false" class="nav-link active">
										<input type="hidden" value="T">
										<i class="mdi mdi-home-variant d-lg-none d-block mr-1"></i>
										<span class="d-none d-lg-block">전체</span>
									</a>
								</li>
								<li class="nav-item" onclick="setCategory(2)">
									<a href="#home" data-toggle="tab" aria-expanded="true" class="nav-link">
										 <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i> 
										 <span class="d-none d-lg-block">인사팀</span>
									</a>
								</li>
								<li class="nav-item" onclick="setCategory(3)">
									<a href="#home" data-toggle="tab" aria-expanded="false" class="nav-link"> 
										<i class="mdi mdi-settings-outline d-lg-none d-block mr-1"></i> 
										<span class="d-none d-lg-block">시설팀</span>
									</a>
								</li>
								<li class="nav-item"  onclick="setCategory(4)">
									<a href="#home" data-toggle="tab" aria-expanded="false" class="nav-link">
										<i class="mdi mdi-settings-outline d-lg-none d-block mr-1"></i>
										<span class="d-none d-lg-block">고객팀</span>
									</a>
								</li>
							</ul>
			</section>
			<table id="showlist" class="table">
				<thead>
					<tr class="listhead">
						<th class="titless">사원번호</th>
						<th class="titless">이름</th>
						<th class="titless">부서</th>
						<th class="titless">직급</th>
						<th class="titless">재직상태</th>

					</tr>
				</thead>
				
				<tbody id="list" class="listhead"></tbody>
				<tr>
					<td colspan="5" id="paging">
						<div class="container">
							<nav aria-label="page navigation" style="text-align: center; width: 1000px; margin-left :355px;"">
								<ul class="pagination" id="pagination"></ul>
							</nav>
							<hr>
						</div>
					</td>
				</tr>
			</table>
				<form id="excelForm" action="/excel/download" method="get" style = "text-align : right;">
				    <button type="submit" class="btn waves-effect waves-light btn-primary">엑셀 다운</button>
				</form>
		</div>
	</div>
<script src="/scss/icons/jquery.twbsPagination.js" type="text/javascript"></script>	
	<script>
	var category = 1;
	var showPage =1;
	var searchRemain = false;
	
	$(document).ready(function() {

	    // 기존 기능 초기화
	    listCall(showPage);
	});

	function setCategory(num) {
	    console.log("Category set to: " + num);
	    category = num;
	    // 버튼 스타일 변경
	    $('.btnss button').removeClass('active'); // 모든 버튼에서 active 클래스 제거
	    $('.btnss button[value="' + num + '"]').addClass('active'); // 선택한 버튼에 active 클래스 추가
	    $('#pagination').twbsPagination('destroy');
	    showPage = 1;
	    listCall(showPage);
	}
	
	function search(){
		$('#pagination').twbsPagination('destroy');
		showPage =1;
		listCall(showPage);		
	};
	
	
	function listCall(page){
			var searchType = $('select[id="searchType"]').val();
			var searchText = $('input[id="searchText"]').val();
			console.log(searchType);
			console.log(searchText);
		    console.log("Category: " + category); // 추가된 콘솔 로그

	    $.ajax({
	       type:'get',
	       url:'/empList.ajax',
	       data:{
	    	    'page':page,
	    		'searchType':searchType,
	    		'searchText':searchText,
	    		'categoryNum' : category,
	       },
	       dataType:'json',
	       success:function(data){
	          drawList(data.list);
	          
	          var startPage = 1;
	          
	       // 플러그인 추가
	       	$('#pagination').twbsPagination({
	    		startPage:data.currPage, // 시작 페이지
	    		totalPages:data.totalPages, // 총 페이지 갯수
	    		visiblePages:5,  // 보여줄 페이지 수[1][2][3][4][5]
	    		onPageClick:function(evt,pg){ // 페이지 클릭시 실행 함수
	    			console.log(evt); // 이벤트 객체
	    			console.log(pg); //클릭한 페이지 번호 의미
	        		showPage = pg;
	        		listCall(pg);
	    			
	    		}
	       	});
	       
	       },
	       error:function(error){
	          console.log(error)
	       }
	    });
	}

    function drawList(list) {
        var content = '';
        for (var i = 0; i < list.length; i++) {
            var emp = list[i];
            var dept = '';
            var rank = '';

            switch (emp.dept_code) {
                case 11: dept = "인사팀"; break;
                case 22: dept = "시설팀"; break;
                case 33: dept = "고객팀"; break;
            }

            switch (emp.rank_code) {
                case 1: rank = "사장"; break;
                case 2: rank = "이사"; break;
                case 3: rank = "팀장"; break;
                case 4: rank = "과장"; break;
                case 5: rank = "대리"; break;
                case 6: rank = "사원"; break;
            }

            content += '<tr style="border-bottom: 1px solid #ddd; height: 50px;">';
            content += '<td style="text-align: center;">' + emp.emp_no + '</td>';
            content += '<td style="text-align: center;"><a href="/empDetail.go?emp_no=' + emp.emp_no + '">' + emp.name + '</a></td>';
            content += '<td style="text-align: center;">' + dept + '</td>';
            content += '<td style="text-align: center;">' + rank + '</td>';
            content += '<td style="text-align: center;">' + emp.status_division + '</td>';
            content += '</tr>';
        }
        $('#list').html(content);
    }
	</script>
</body>
</html>
