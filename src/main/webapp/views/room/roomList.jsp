<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    .text-right {
        text-align: right;
    }
    
    table,tr {
		text-align: justify;
		text-align: center;
	}

	#available {
	    font-weight: 900; 
	    color: green;     
	}
	
	#nonAvailable {
	    font-style: italic; 
	    color: red;         
	}
	
	#room_no{
		font-weight: 900; 
	}
	
	#search{
	    width: 30%;
	    margin-left: 70%;
	    border: 1px solid skyblue; 
	    border-color: skyblue; 
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
                                <input class="form-control custom-shadow custom-radius bg-white" type="search" placeholder="검색할 호수를 입력하세요." aria-label="Search" onkeyup="search()" id="search">
                            	<!-- <button id="test">버튼 텍스트</button>  -->
                            </div>
                            <hr>
                            <table class="table">
                                <thead class="bg-info text-white">
                                    <tr>
                                        <th>호수</th>
                                        <th>객실타입</th>
                                        <th>이용상태</th>
                                        <th>상태변경</th>
                                    </tr>
                                </thead>
                                <tbody id="roomStateList">
                                </tbody>
                                    <tr>
                                        <td colspan="4">
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
		
		var search = $('#search').val();
		
		console.log("리스트콜 호출");
	    $.ajax({
	        type: 'POST',
	        url: '/room/roomStateList.ajax',
	        data:{
	        	search : search,
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
		 var roomContainer = $('#roomStateList');
		 roomContainer.empty(); 
		    
		 var content = '';
	    for (var item of list) {
	        content += '<tr>';
	        content += '<td id="room_no">' + item.room_no + '</td>';
	        if (item.type_code === 1001) {
	            content += '<td>스탠다드룸</td>';
	        } else if (item.type_code === 1002) {
	            content += '<td>슈페리어룸</td>';
	        } else if (item.type_code === 1003) {
	            content += '<td>디럭스룸</td>';
	        } else if (item.type_code === 1004) {
	            content += '<td>스위트룸</td>';
	        }
	        
	        if (item.room_status ==='I' || item.room_status ==='O' || item.room_status ==='A') {
	       		 content += '<td id="available">이용가능</td>';				
			}else{
				 content += '<td id="nonAvailable">이용불가</td>';						
			}
	        
	        if (item.room_status ==='I') {
	       		 content += '<td>객실이용중</td>';				
			}else if(item.room_status ==='A' || item.room_status ==='O'){
				 content += '<td><button type="button" class="btn waves-effect waves-light btn-secondary" onclick="updateNotAvailable('+ item.room_no+')">';
				 content += '<i class="fas fa-frown"></i> 이용불가 변경</td>';						
			}else{
				content += '<td><button type="button" class="btn waves-effect waves-light btn-success" onclick="updateAvailable('+item.room_no+')">';
				content += '<i class="fas fa-check"></i> 이용가능 변경</td>';
			}
	        content += '</tr>';
	    }

	    $('#roomStateList').html(content);
	    
	} 
	
	function updateNotAvailable(room_no){

		$.ajax({
			type:'POST',
			url:'/room/updateNotAvailable.ajax',
			data:{
				room_no:room_no
			},
			dataType:'JSON',
			success:function(data){
				listCall(num);
			},
			error:function(e){
				console.log(e);
			}
		});
		
	}
	
	function updateAvailable(room_no){

		$.ajax({
			type:'POST',
			url:'/room/updateAvailable.ajax',
			data:{
				room_no:room_no
			},
			dataType:'JSON',
			success:function(data){
				listCall(num);
			},
			error:function(e){
				console.log(e);
			}
		});
		
	}
	
</script>
</html>