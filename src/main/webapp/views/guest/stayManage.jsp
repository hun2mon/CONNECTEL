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
                            
                            <!-- 탭 시작 -->
                    <ul class="nav nav-tabs nav-justified nav-bordered mb-3">                                   
                                    <li class="nav-item">
                                        <a href="#profile-b2" data-toggle="tab" aria-expanded="true"
                                            class="nav-link active">
                                            <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                            <span class="d-none d-lg-block">TODAY 체크인</span>
                                        </a>
                                    </li>
                                    <li onclick="noCheckListCall('1')" class="nav-item">
                                        <a href="#settings-b2" data-toggle="tab" aria-expanded="false" class="nav-link">
                                            <i class="mdi mdi-settings-outline d-lg-none d-block mr-1"></i>
                                            <span class="d-none d-lg-block">미체크인 고객</span>
                                        </a>
                                    </li>
                                </ul>
                     <!-- 탭 끝 -->
                            
                            <!-- 리스트 시작 -->
                     <div class="tab-content">                                  
                                    <!-- 체크인 고객 -->
                                    <div class="tab-pane show active" id="profile-b2">
                                        <div class="table-responsive">			                           
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
                                    
                                  	   <!-- 미체크인 고객  -->
	                                   <div class="tab-pane" id="settings-b2">
	                                      	<div class="table-responsive">			                           
				                         		<table class="table">
					                                <thead class="bg-info text-white">
					                                    <tr>
					                                        <th>예약번호</th>
					                                        <th>객실타입</th>					                                        
					                                        <th>예약자명</th>
					                                        <th>전화번호</th>                                      
					                                    </tr>
					                                </thead>
					                                <tbody id="NostayList">
					                                </tbody>
					                                    <tr>
					                                        <td colspan="4">
					                                            <div class="pagging">
					                                                <nav aria-label="Page navigation" style="text-align: center">
					                                                    <div id="noChekPagination"></div>
					                                                </nav>
					                                            </div>
					                                        </td>
					                                    </tr>                                
					                            </table>
               					    </div>
	                                   </div>
                                </div>
 
                            <hr>
                           
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
var nocheckNum;

$(document).ready(function(){
	var today = new Date();
	today.setHours(today.getHours() + 9); // 한국 시간은 UTC+9이므로 9시간 더해줌
	var todayKST = today.toISOString().split('T')[0];
    $('#searchDate').val(todayKST);
	listCall(showPage);   
});

function search() {
	$('#pagination').twbsPagination('destroy');
	$('#noChekPagination').twbsPagination('destroy');
	listCall(showPage);
	noCheckListCall(showPage);
}

$('#searchDate').change(function() {
	$('#pagination').twbsPagination('destroy');
	$('#noChekPagination').twbsPagination('destroy');
    var selectedDate = $(this).val();
    console.log('Selected date:', selectedDate);

    listCall(showPage);
    noCheckListCall(showPage);
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

function noCheckListCall(showPage){
	var search = $('#search').val();
	var searchDate = $('#searchDate').val();
	
	console.log("searchDate : "+searchDate);

	
	console.log("미체크인 고객 리스트 호출");
	
    $.ajax({
        type: 'POST',
        url: '/guest/noCheckListCall.ajax',
        data:{
        	search : search,
        	searchDate : searchDate,
        	page : showPage,			
			cnt : 10
        },
        dataType: 'json',
        success: function(data) {            
        	var startPage = data.currPage > data.totalPages ? data.totalPages : data.currPage;
			drawNoCheckList(data.list);
			console.log('미체크인 고객 리스트'+data);
			
			var totalPages = data.totalPages;
			
			$('#noChekPagination').twbsPagination({
            	startPage:startPage, // 시작페이지
            	totalPages:totalPages, // 총 페이지 수
            	visiblePages:5, // 보여줄 페이지 수 1,2,3,4,5
            	onPageClick:function(evt,pg){ // 페이지 클릭시 실행 함수
            		console.log(pg); // 클릭한 페이지 번호            	
            		nocheckNum=pg;
            		listCall(pg);
            	}
            })
					
        },
        error: function(e) {
            console.log(e);
        }
    });
}

function drawNoCheckList(list) {
	 var roomContainer = $('#NostayList');
	 roomContainer.empty(); 
	    
	 var content = '';
 for (var item of list) {
     content += '<tr>';    
     content += '<td>'+item.res_no+'</td>';
     
    
     if (item.type_code === 1001) {
         content += '<td>스탠다드룸</td>';
     } else if (item.type_code === 1002) {
         content += '<td>슈페리어룸</td>';
     } else if (item.type_code === 1003) {
         content += '<td>디럭스룸</td>';
     } else if (item.type_code === 1004) {
         content += '<td>스위트룸</td>';
     }

     
     content += '<td>'+item.cos_name+'</td>';
     content += '<td>'+item.cos_phone+'</td>';         
     content += '</tr>';
     
 }

 $('#NostayList').html(content);
 
}

</script>
</html>