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
    margin-top: 0;
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

	#cancelModal{
		width: 100%;
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
                    <div class="customize-input">
                                <input type="date" class="form-control custom-shadow custom-radius bg-white" id="searchDate">
                                <input class="form-control custom-shadow custom-radius bg-white" type="search" placeholder="Search" aria-label="Search" onkeyup="search()" id="search">
                    </div>
                    
                    <!-- 탭 시작 -->
                    <ul class="nav nav-tabs nav-justified nav-bordered mb-3">
                                    <li class="nav-item">
                                        <a href="#home-b2" data-toggle="tab" aria-expanded="false" class="nav-link">
                                            <i class="mdi mdi-home-variant d-lg-none d-block mr-1"></i>
                                            <span class="d-none d-lg-block">현장결제</span>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#profile-b2" data-toggle="tab" aria-expanded="true"
                                            class="nav-link active">
                                            <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                            <span class="d-none d-lg-block">결제완료</span>
                                        </a>
                                    </li>
                                    <li onclick="cancelListCall('1')" class="nav-item">
                                        <a href="#settings-b2" data-toggle="tab" aria-expanded="false" class="nav-link">
                                            <i class="mdi mdi-settings-outline d-lg-none d-block mr-1"></i>
                                            <span class="d-none d-lg-block">예약취소</span>
                                        </a>
                                    </li>
                                </ul>
                     <!-- 탭 끝 -->
                    
                    
                    <!-- 리스트 시작 -->
                     <div class="tab-content">
                     
                     				<!-- 현장결제 -->
                                    <div class="tab-pane" id="home-b2">
                                       	
                                    </div>
                                    
                                    <!-- 결제완료 -->
                                    <div class="tab-pane show active" id="profile-b2">
                                        <div class="table-responsive">			                           
				                           <table class="table">
				                               <thead class="bg-info text-white">
				                                   <tr>
				                                       <th>예약번호</th>
				                                       <th>객실명</th>
				                                       <th>예약자명</th>
				                                       <th>전화번호</th>
				                                       <th>이메일</th>
				                                       <th>결제금액</th>
				                                       <th>체크인</th>
				                                       <th>체크아웃</th>
				                                       <th>예약날짜</th>
				                                       <th>예약취소</th>
				                                   </tr>
				                               </thead>
				                               <tbody id="reserveList">
				                               </tbody>
				                                   <tr>
				                                       <td colspan="10">
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
                                    
                                  	   <!-- 예약취소 리스트  -->
	                                   <div class="tab-pane" id="settings-b2">
	                                      	<div class="table-responsive">			                           
				                           <table class="table">
				                               <thead class="bg-info text-white">
				                                   <tr>
				                                       <th>예약번호</th>
				                                       <th>객실명</th>
				                                       <th>예약자명</th>
				                                       <th>전화번호</th>
				                                       <th>이메일</th>
				                                       <th>결제금액</th>
				                                       <th>환불금액</th>
				                                       <th>체크인</th>
				                                       <th>취소아웃</th>
				                                       <th>취소날짜</th>
				                                   </tr>
				                               </thead>
				                               <tbody id="resCanselList">
				                               </tbody>
				                                   <tr>
				                                       <td colspan="10">
				                                           <div class="pagging">
				                                               <nav aria-label="Page navigation" style="text-align: center">
				                                                   <div id="cancelPagination"></div>
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
</div>
                    
                    
                    
                    
                    
 						

<!-- 예약취소 모달 -->
<div id="cancelModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="danger-header-modalLabel" aria-hidden="true">
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header modal-colored-header bg-danger">
            <h4 class="modal-title" id="danger-header-modalLabel">정말 예약을 취소하시겠습니까?</h4>
            <button type="button" class="close" data-dismiss="modal"
                aria-hidden="true">×</button>
	        </div>
	        <div class="modal-body">
                <table class="table" id="cancelModal">
        <tbody>
            <tr>
                <th scope="row">예약번호</th>
                <td id="cancel_res_no"></td>
            </tr>
            <tr>
                <th scope="row">예약자</th>
                <td id="cancel_name"></td>
            </tr>
            <tr>
                <th scope="row">체크인 날짜</th>
                <td id="cancel_date"></td>
            </tr>
            <tr>
                <th scope="row">현재 날짜</th>
                <td id="current_date"></td>
            </tr>
            <tr>
                <th scope="row">예약 일 전</th>
                <td id="minus_date"></td>
            </tr>
            <tr>
                <th scope="row">환불 정책</th>
                <td id="cancel_content"></td>
            </tr>
            <tr>
                <th scope="row">환불 금액</th>
                <td id="refund_price"></td>
            </tr>
        </tbody>
    </table>
				
             </div>
             <div class="modal-footer">
                 <button type="button" class="btn btn-danger" onclick="reserveDelete()">예약 취소</button>
             </div>
         </div><!-- /.modal-content -->
     </div><!-- /.modal-dialog -->
 </div><!-- /.modal -->

</body>
<script src="/js/jquery.twbsPagination.js" type="text/javascript"></script>
<script>
var showPage = 1;
var num;
var cancelNum;
var cancelPrice;
var today = new Date();
today.setHours(today.getHours() + 9); // 한국 시간은 UTC+9이므로 9시간 더해줌
var todayKST = today.toISOString().split('T')[0];

$(document).ready(function(){
	
    $('#searchDate').val(todayKST);
	
	listCall(showPage);   
});

function search() {
	$('#pagination').twbsPagination('destroy');
	$('#cancelPagination').twbsPagination('destroy');
	listCall(showPage);
	cancelListCall(showPage);
}

$('#searchDate').change(function() {
	$('#pagination').twbsPagination('destroy');
	$('#cancelPagination').twbsPagination('destroy');
   /*  var selectedDate = $(this).val();
    console.log('Selected date:', selectedDate); */

    listCall(showPage);
    cancelListCall(showPage);
});

function listCall(showPage) {
	
	var search = $('#search').val();
	var searchDate = $('#searchDate').val();
	
	console.log("searchDate : "+searchDate);
	console.log("오늘 날짜 : " +todayKST);
	
	console.log("리스트콜 호출");
    $.ajax({
        type: 'POST',
        url: '/guest/reserveList.ajax',
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
			console.log('결제완료 리스트'+data);
			
			var totalPages = data.totalPages;
			
			$('#pagination').twbsPagination({
            	startPage:startPage, // 시작페이지
            	totalPages:totalPages, // 총 페이지 수
            	visiblePages:5, // 보여줄 페이지 수 1,2,3,4,5
            	onPageClick:function(evt,pg){ // 페이지 클릭시 실행 함수
            		console.log(pg); // 클릭한 페이지 번호            	
            		num=pg;
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
	 var roomContainer = $('#reserveList');
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
       content += '<td>'+item.cos_email+'</td>';
       content += '<td>'+item.res_price+'</td>';
       content += '<td>'+item.in_date+'</td>';
       content += '<td>'+item.out_date+'</td>';
       content += '<td>'+item.res_date+'</td>';  
       
       if (todayKST> item.in_date) {
    	   content += '<td>-</td>'; 
	}else{
		content += '<td><a href="#" onclick="openCancelModal(' + item.res_no + ', \'' + item.cos_name + '\', \'' + item.in_date + '\', ' + item.res_price + ')">취소</a></td>';
    
	}
       content += '</tr>';
       
   }

   $('#reserveList').html(content);
   
}

function cancelListCall(showPage) {
	var search = $('#search').val();
	var searchDate = $('#searchDate').val();
	
	console.log("searchDate : "+searchDate);
	console.log("오늘 날짜 : " +todayKST);
	
	console.log("리스트콜 호출");
    $.ajax({
        type: 'POST',
        url: '/guest/cancelList.ajax',
        data:{
        	search : search,
        	searchDate : searchDate,
        	page : showPage,			
			cnt : 10
        },
        dataType: 'json',
        success: function(data) {            
        	var startPage = data.currPage > data.totalPages ? data.totalPages : data.currPage;
			drawCancelList(data.list);
			console.log('결제완료 리스트'+data);
			
			var totalPages = data.totalPages;
			
			$('#cancelPagination').twbsPagination({
            	startPage:startPage, // 시작페이지
            	totalPages:totalPages, // 총 페이지 수
            	visiblePages:5, // 보여줄 페이지 수 1,2,3,4,5
            	onPageClick:function(evt,pg){ // 페이지 클릭시 실행 함수
            		console.log(pg); // 클릭한 페이지 번호            	
            		cancelNum=pg;
            		listCall(pg);
            	}
            })
					
        },
        error: function(e) {
            console.log(e);
        }
    });
}

function drawCancelList(list) {
	 var roomContainer = $('#resCanselList');
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
      content += '<td>'+item.cos_email+'</td>';
      content += '<td>'+item.res_price+'</td>';
      content += '<td>'+item.cancel_price+'</td>';  
      content += '<td>'+item.in_date+'</td>';
      content += '<td>'+item.out_date+'</td>';
      content += '<td>'+item.cancel_date+'</td>';            
      content += '</tr>';
      
  }

  $('#resCanselList').html(content);
  
}


function openCancelModal(res_no,name,date,price){
	console.log('하이');
	
	$('#cancel_res_no').empty();
	$('#cancel_name').empty();
	$('#cancel_date').empty();
	$('#current_date').empty();
	$('#minus_date').empty();
	$('#cancel_content').empty();
	$('#refund_price').empty();

	var today = new Date();
    today.setHours(0, 0, 0, 0); // 자정으로 설정

    // 예약 날짜와 오늘 날짜를 Date 객체로 변환
    var reservationDate = new Date(date);
    reservationDate.setHours(0, 0, 0, 0); // 예약 날짜도 자정으로 설정

    console.log(reservationDate+ '-' +today);
    
    // 날짜 차이 계산 (밀리초 단위 차이를 일 단위로 변환)
    var timeDifference = reservationDate - today;
    var dayDifference = Math.floor(timeDifference / (1000 * 60 * 60 * 24));
	
    console.log(dayDifference);
   
    // 며칠 전인지에 따른 환불 퍼센트 불러오는 ajax
    $.ajax({
    	type:'POST',
    	url:'/guest/resCancelDate.ajax',
    	data:{
    		date : dayDifference
    	},
    	dataType:'JSON',
    	success:function(data){
    		console.log(data.percent);
    		$('#cancel_res_no').text(res_no);
    	    $('#cancel_name').text(name);
    	    $('#cancel_date').text(date);
    	    $('#current_date').text(todayKST);
    	    $('#minus_date').text(dayDifference + '일 전');
    	    $('#cancel_content').text('환불정책에 의거하여 결제 요금의 ' + data.percent + '%가 환불됩니다.');
    	    
    	    cancelPrice = price * (data.percent / 100);
    	    $('#refund_price').text(cancelPrice + '원');   	    
    	    $('#cancelModal').modal('show');
    	},
    	error:function(e){
    		console.log(e);
    	}
    })

}



// [예약 취소] 예약 취소하면 실행되고 카카오페이 결제 취소 후, C로 테이블에서 구분값 변경 후, res_cancel 테이블에 insert
function reserveDelete(){
	var res_no = $('#cancel_res_no').text().replace('예약번호 : ','');
	console.log('cancelPrice'+cancelPrice);
	  $.ajax({
	        type: 'POST',
	        url: '/guest/reserveCancel.ajax',
	        data:{
	        	res_no:res_no,
	        	cancelPrice:cancelPrice
	        },
	        dataType: 'json',
	        success: function(res) {            	      
				console.log(res);
				 alert("취소하였습니다.");
				$('#cancelModal').modal('hide');
				listCall(num);				
	        },
	        error: function(e) {
	        	console.log(e);
	        	$('#cancelModal').modal('hide');
				listCall(num);	
	       }
	    });  
	
}

</script>
</html>