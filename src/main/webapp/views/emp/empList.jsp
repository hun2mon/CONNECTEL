<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
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
				<div>
					<button value="1" onclick="setCategory(1)">전체</button>
					<button value="2" onclick="setCategory(2)">인사팀</button>
					<button value="3" onclick="setCategory(3)">시설팀</button>
					<button value="4" onclick="setCategory(4)">고객팀</button>
				</div>
				<div>
					<select id="searchType" class="searchType">
						<option value="1" class="searchType">이름</option>
						<option value="2" class="searchType">재직상태</option>
					</select>
					<div class="input-container">
						<input type="text" id="searchText">
						<img src="/scss/icons/search.png" id="search" height="20px" width="20px" onclick="search()" class="searchIcon">
						
					</div>
				</div>
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
							<nav aria-label="page navigation" style="text-align: center">
								<ul class="pagination" id="pagination"></ul>
							</nav>
							<hr>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
<script src="/scss/icons/jquery.twbsPagination.js" type="text/javascript"></script>	
	<script>
	var category = 1;
	var showPage =1;
	var searchRemain = false;
	
	$(document).ready(function(){ // html 문서가 모두 읽히면 되면(준비되면) 다음 내용을 실행 해라
		listCall(showPage);
	});

	function setCategory(num){
		console.log("Category set to: " + num);
		category = num;
		$('#pagination').twbsPagination('destroy');
		showPage =1;
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
