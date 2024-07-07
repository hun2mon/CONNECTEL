<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>주소록 관리</title> <!-- Insert title here를 적절한 제목으로 수정 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" crossorigin="anonymous">

<style>
    body {
        margin: 0;
        padding: 0;
        display: flex;
        height: 100vh;
        overflow: hidden;
    }

    .sidebar-container {
        flex-shrink: 0;
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
        margin-top: 50px;
    }

    .card {
        margin: 20px 0;
    }
    
    #search{
	    width: 30%;
	    border-color: skyblue; 
	    right: 0;
	}
	    .customize-input {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
}

.pagging {
        text-align: center;
    }

    .pagination {
        justify-content: center;
    }

table {
        text-align: center;
        table-layout: fixed; /* 테이블 열의 너비를 고정 */
        width: 100%;
    }

	/* my-table 클래스가 적용된 테이블에만 스타일 적용 */
.my-table th:nth-child(1), 
.my-table td:nth-child(1) {
    width: 5%; /* 체크박스 열의 너비 */
}

.my-table th:nth-child(2), 
.my-table td:nth-child(2) {
    width: 10%; /* 즐겨찾기 열의 너비 */
}

.my-table th:nth-child(5), 
.my-table td:nth-child(5) {
    width: 10%; /* 삭제 열의 너비 */
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
                                <input class="form-control custom-shadow custom-radius bg-white" type="search" placeholder="Search" aria-label="Search" onkeyup="search()" id="search">
                   		 </div>
                        <ul class="nav nav-tabs mb-3">
                            <li class="nav-item">
                                <a href="#home" data-toggle="tab" aria-expanded="true" class="nav-link active">
                                    <i class="mdi mdi-home-variant d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block">내 주소록</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#profile" data-toggle="tab" aria-expanded="false" class="nav-link">
                                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block">즐겨찾는 주소록</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#settings" data-toggle="tab" aria-expanded="false" class="nav-link">
                                    <i class="mdi mdi-settings-outline d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block">고객 주소록</span>
                                </a>
                            </li>
                            <li class="nav-item ml-auto"> <!-- ml-auto를 추가하여 오른쪽으로 이동 -->
                                <button type="button" id="add_address" onclick="openAddModal()" class="btn btn-info btn-sm">연락처 추가</button>
                            </li>
                        </ul>

                        <div class="tab-content">
                            <div class="tab-pane show active" id="home">
                                <div class="table-responsive">			                           
				                           <table class="table my-table my">
											    <thead>
											        <tr>
											            <th><input type="checkbox" id="select-all-checkouts"></th>
											            <th>즐겨찾기</th>
											            <th>이름</th>
											            <th>이메일</th>
											            <th>전화번호</th>
											            <th>소속</th>
											            <th>삭제</th>
											        </tr>
											    </thead>
				                               <tbody id="myAddressList">
				                               </tbody>
				                                   <tr>
				                                       <td colspan="7">
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
                            <div class="tab-pane" id="profile">
                                즐겨찾는 주소록 내용
                            </div>
                            <div class="tab-pane" id="settings">
                                <div class="table-responsive">			                           
				                           <table class="table">
				                               <thead >
				                                   <tr>
				                                       <th>이름</th>
				                                       <th>이메일</th>
				                                       <th>전화번호</th>			                                    			                                    
				                                   </tr>
				                               </thead>
				                               <tbody id="clentList">
				                               </tbody>
				                                   <tr>
				                                       <td colspan="3">
				                                           <div class="pagging">
				                                               <nav aria-label="Page navigation" style="text-align: center">
				                                                   <div id="clientPagination"></div>
				                                               </nav>
			                                    			</div>
		                               				  </td>
		                           					</tr>                                
	                      					</table>
	               					    </div>
                            </div>
                        </div>

                    </div> <!-- end card-body-->
                </div> <!-- end card-->
            </div> <!-- end col -->
        </div> <!-- end row -->
    </div> <!-- end container-fluid -->
</div> <!-- end content-body -->

<!-- Modal -->
<div id="addModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="text-center mt-2 mb-4">
                    연락처 추가
                </div>
                <div class="form-group">
                    <label for="add_name">이름</label>
                    <input class="form-control" type="text" id="add_name" required="" placeholder="Michael Zenaty">
                </div>

                <div class="form-group">
                    <label for="add_email">이메일주소</label>
                    <input class="form-control" type="email" id="add_email" required="" placeholder="john@deo.com">
                </div>

                <div class="form-group">
                    <label for="add_phone">연락처</label>
                    <input class="form-control" type="tel" id="add_phone" required="" placeholder="010-1234-1234">
                </div>
                    
                <div class="form-group">
                    <label for="belong">소속</label>
                    <input class="form-control" type="text" id="belong" required="" placeholder="구디아카데미">
                </div>

                <div class="form-group">
                    <label for="star-checkbox">즐겨찾기</label>
                    <div class="star-checkbox" onclick="toggleStar(this)">
                        <i id="star-icon" class="far fa-star"></i>
                    </div>
                </div>

                <div class="form-group text-center">
                    <button class="btn btn-primary" type="button" onclick="addAddress()">등록</button>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</body>
<script src="/js/jquery.twbsPagination.js" type="text/javascript"></script>
<script>
var showPage=1;
var num;
var clentNum;

	$(document).ready(function(){
		listCall(showPage);
		clentListCall(showPage);
	})
	
	function search() {
        $('#pagination').twbsPagination('destroy');
        $('#clientPagination').twbsPagination('destroy');
        listCall(showPage);
        clentListCall(showPage);
    }

	function listCall(showPage){
		var search = $('#search').val();
        console.log("리스트콜 호출");
        $.ajax({
            type: 'POST',
            url: '/mail/myAddressList.ajax',
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
                    startPage: startPage, // 시작페이지
                    totalPages: totalPages, // 총 페이지 수
                    visiblePages: 5, // 보여줄 페이지 수 1,2,3,4,5
                    onPageClick: function(evt, pg){ // 페이지 클릭시 실행 함수
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
	
	function clentListCall(showPage){
		var search = $('#search').val();
        $.ajax({
            type: 'POST',
            url: '/mail/clentList.ajax',
            data:{
                search : search,
                page : showPage,            
                cnt : 10
            },
            dataType: 'json',
            success: function(data) {            
                var startPage = data.currPage > data.totalPages ? data.totalPages : data.currPage;
                clentDrawList(data.list);
                console.log(data);

                var totalPages = data.totalPages;

                $('#clientPagination').twbsPagination({
                    startPage: startPage, // 시작페이지
                    totalPages: totalPages, // 총 페이지 수
                    visiblePages: 5, // 보여줄 페이지 수 1,2,3,4,5
                    onPageClick: function(evt, pg){ // 페이지 클릭시 실행 함수
                        console.log(pg); // 클릭한 페이지 번호
                        clentNum = pg;
                        clentListCall(pg);
                    }
                })
            },
            error: function(e) {
                console.log(e);
            }
        });
	}
	
	function drawList(list) {
        var roomContainer = $('#myAddressList');
        roomContainer.empty(); 
        
        var content = '';
        for (var item of list) {
                    
            content += '<tr>';
            content += '<td><input type="checkbox" class="checkout-room-checkbox" value="' + item.add_no + '"></td>';
            if (item.add_favorite === 'true') {
                content += '<td><div class="star-checkbox" onclick="toggleStar(this)" data-add-no="' + item.add_no + '">';
                content += '<i class="fas fa-star" id="star-icon"></i>'; // 채워진 별
                content += '</div></td>';
            } else if (item.add_favorite === 'false') {
                content += '<td><div class="star-checkbox" onclick="toggleStar(this)" data-add-no="' + item.add_no + '">';
                content += '<i class="far fa-star" id="star-icon"></i>'; // 빈 별
                content += '</div></td>';
            }
            
            content += '<td>' + item.add_name + '</td>';
            content += '<td>' + item.add_email + '</td>';
            content += '<td>' + item.add_phone  + '</td>';
            content += '<td>' + item.belong+ '</td>';
            content += '<td><a href="#" onclick="deleteAddr(' + item.add_no + ')"><i class="fas fa-trash-alt"></i></a></td>';  
            content += '</tr>';
        }
        $('#myAddressList').html(content);

        
    }
	
	function clentDrawList(list) {
        var roomContainer = $('#clentList');
        roomContainer.empty(); 
        
        var content = '';
        for (var item of list) {
                    
            content += '<tr>';       
            content += '<td>' + item.client_name + '</td>';
            content += '<td>' + item.client_email + '</td>';
            content += '<td>' + item.client_phone  + '</td>';
            content += '</tr>';
        }
        $('#clentList').html(content);

        
    }
	
	
	function allDelete() {
  	  var checkedIds = [];
  	    $('.checkout-room-checkbox:checked').each(function() {
  	        checkedIds.push($(this).val());
  	    });
  	    console.log('checkedIds : ',checkedIds);
  	    $.ajax({
  	    	type:'POST',
  	    	url:'/mail/myAddressListdelete.ajax',
  	    	contentType: 'application/json',
  	    	data:JSON.stringify({
  	    		add_no:checkedIds
  	    	}),
  	    	dataType:'JSON',
  	    	success:function(data){
  	    		console.log(data);
  	    		listCall(showPage);
  	    	},
  	    	error:function(e){
  	    		console.log(e);
  	    	}
  	    });
  	    
  }
	
	
	

    function openAddModal() {
        $('#addModal').modal('show');
    }

    function toggleStar(element) {
        var icon = $(element).find('i');
        icon.toggleClass('far'); // 빈 별 아이콘 클래스 토글
        icon.toggleClass('fas'); // 채워진 별 아이콘 클래스 토글
    }

    function addAddress() {
        var add_name = $('#add_name').val().trim();
        var add_email = $('#add_email').val().trim();
        var belong = $('#belong').val().trim();
        var add_phone = $('#add_phone').val().trim();

        var isStarred = $('#star-icon').hasClass('fas');
        
        console.log('이름: ' + add_name + ', 이메일: ' + add_email + ', 소속: ' + belong + ', 연락처: ' + add_phone + ', 즐겨찾기: ' + isStarred);
        
        // 간단한 예시로 이름과 이메일 주소 유효성 검사
        if (add_name === '') {
            alert('이름을 입력해주세요.');
            return;
        }

        if (add_email === '') {
            alert('이메일 주소를 입력해주세요.');
            return;
        }

        // 이메일 주소 형식 검사 (간단한 형식 검사 예시)
        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(add_email)) {
            alert('올바른 이메일 주소 형식이 아닙니다.');
            return;
        }
			
        $.ajax({
        	type:'POST',
        	url:'/mail/addAddress.ajax',
        	data:{
        		add_name:add_name,
        		add_email:add_email,
        		belong:belong,
        		add_phone:add_phone,
        		isStarred:isStarred
        	},
        	dataType:'JSON',
        	success:function(res) {
        		$('#addModal').modal('hide');
        		
        	},
        	error: function(e) {
                console.error("Error occurred:", e);
                alert("결제 준비 중 오류가 발생했습니다. 다시 시도해주세요.");
            }
        })
        
    }
</script>
</html>
