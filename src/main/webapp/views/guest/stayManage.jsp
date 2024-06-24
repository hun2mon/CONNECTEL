<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
       body {
        margin: 0;
        padding: 0;
        display: flex;
        height: 100vh;
        overflow: hidden;
    }

    .sidebar-container {
        flex-shrink: 0; /* 변경: flex-grow를 0으로 설정 */
        width: 250px;
        background-color: #f8f9fa;
        box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        overflow-y: auto;
    }

    .sidebar {
        padding: 20px;
    }

    .content-body {
        flex-grow: 1;
        padding: 20px;
        overflow-y: auto;
        margin-top: 50px; /* 상단 바의 높이에 맞춰 조정 */
    }

    .card {
        margin: 20px 0;
    }
    
    .customize-input {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
}


	#searchDate {
	    border-color: skyblue;
	    width: 200px;
	}
	
	#search{
	    width: 30%;
	    border-color: skyblue; 
	}
	
	.pagging{
	margin: 0 auto;
    padding: 0px;
    width: 333px;
    height: 40px;
}

.table-responsive {
    width: 100%;
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: separate;
    }

th, td {
    white-space: nowrap;
    text-align: center;
    padding: 8px;
}

thead {
    background-color: #17a2b8;
    color: white;
    text-align: center;
}

@media (max-width: 768px) {
    #search {
        width: 100%;
        margin-left: 0;
    }
    
   .cancelModal{
   	z-index: 1050; 
   }
    
}

</style>
</head>
<body>
<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>

<div class="content-body">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
						<div class="table-responsive">
                            <div class="customize-input">
                                <input type="date" class="form-control custom-shadow custom-radius bg-white" id="searchDate">
                                <input class="form-control custom-shadow custom-radius bg-white" type="search" placeholder="Search" aria-label="Search" onkeyup="search()" id="search">
                            </div>
                            <hr>
                            <table class="table">
                                <thead class="bg-info text-white">
                                    <tr>
                                        <th>예약번호</th>
                                        <th>호수</th>
                                        <th>예약자명</th>
                                        <th>전화번호</th>                                      
                                        <th>체크인 시간</th>
                                        <th>체크아웃 시간</th>
                                    </tr>
                                </thead>
                                <tbody id="stayList">
                                </tbody>
                                    <tr>
                                        <td colspan="6">
                                            <div class="pagging">
                                                <nav aria-label="Page navigation" style="text-align: center">
                                                    <div id="pagination"></div>
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

</body>
<script src="/js/jquery.twbsPagination.js" type="text/javascript"></script>
<script>
var showPage = 1;
var num;

$(document).ready(function(){
	var today = new Date();
	today.setHours(today.getHours() + 9); // 한국 시간은 UTC+9이므로 9시간 더해줌
	var todayKST = today.toISOString().split('T')[0];
    $('#searchDate').val(todayKST);
	listCall(showPage);   
});

function search() {
	$('#pagination').twbsPagination('destroy');
	listCall(showPage);
}

$('#searchDate').change(function() {
    var selectedDate = $(this).val();
    console.log('Selected date:', selectedDate);

    listCall(showPage);
});

function listCall(showPage) {
	
	var search = $('#search').val();
	var searchDate = $('#searchDate').val();
	
	console.log("searchDate : "+searchDate);
	
	console.log("리스트콜 호출");
    $.ajax({
        type: 'POST',
        url: '/guest/stayList.ajax',
        data:{
        	search : search,
        	searchDate : searchDate,
        	page : showPage,			
			cnt : 10
        },
        dataType: 'json',
        success: function(data) {            
        	var startPage = data.currPage > data.totalPages ? data.totalPages : data.currPage;
			drawList(data.list);
			console.log(data);
			
			var totalPages = data.totalPages;
			
			$('#pagination').twbsPagination({
            	startPage:startPage, // 시작페이지
            	totalPages:totalPages, // 총 페이지 수
            	visiblePages:5, // 보여줄 페이지 수 1,2,3,4,5
            	onPageClick:function(evt,pg){ // 페이지 클릭시 실행 함수
            		console.log(pg); // 클릭한 페이지 번호
            		num = pg;
            		listCall(pg);
            	}
            })
					
        },
        error: function(e) {
            console.log(e);
        }
    });
}

function drawList(list) {
	 var roomContainer = $('#stayList');
	 roomContainer.empty(); 
	    
	 var content = '';
   for (var item of list) {
       content += '<tr>';    
       content += '<td>'+item.res_no+'</td>';
       content += '<td>'+item.room_no+'호</td>';
       content += '<td>'+item.cos_name+'</td>';
       content += '<td>'+item.cos_phone+'</td>';     
       content += '<td>'+item.stay_check_in+'</td>';
       if (!item.stay_check_out) {
    	   content += '<td style="color:green;">체크인 중</td>';
		}else{
	       content += '<td>'+item.stay_check_out+'</td>';		
		}   
       content += '</tr>';
   }

   $('#stayList').html(content);
   
}

</script>
</html>