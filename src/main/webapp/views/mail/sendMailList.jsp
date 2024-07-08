<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>메일 리스트</title>
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
    }

    .card {
        margin: 20px 0;
    }

    .table-responsive {
        margin-top: 20px;
    }

    .customize-input {
        margin-bottom: 15px;
    }

    .custom-shadow {
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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

    th, td {
        vertical-align: middle;
        overflow: hidden; /* 내용이 넘칠 때 숨김 */
        text-overflow: ellipsis; /* 내용이 넘칠 때 ... 표시 */
        white-space: nowrap; /* 텍스트 줄바꿈을 하지 않음 */
    }

    th:nth-child(1), td:nth-child(1) {
        width: 5%; /* 체크박스 열의 너비 */
    }

    th:nth-child(5), td:nth-child(5) {
        width: 10%; /* 삭제 열의 너비 */
    }

    th:nth-child(3), td:nth-child(3) {
        width: 40%; /* 제목 열의 너비 */
    }
    
    .trHover{
    	cursor: pointer;
    }

    .form-control {
        border-radius: 0.375rem;
    }

    .btn-sl-sm {
        padding: 5px 10px;
        font-size: 0.875rem;
    }
    
   #search{
	    width: 30%;
	    margin-top:10px;
	    margin-left: 70%;
	    margin-right:5px;
	    border: 0px;
	    border-color: white; 
	}
	
	#allDelete{
		margin-left: 94%;
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
                                <input class="form-control custom-shadow custom-radius bg-white" type="search" placeholder="검색할 수신자 또는 제목을 입력하세요." aria-label="Search" onkeyup="search()" id="search">
                            </div>
                            <hr>
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th><input type="checkbox" id="select-all-checkouts"></th>
                                        <th>수신자</th>
                                        <th>제목</th>
                                        <th>발신 날짜</th>
                                        <th>삭제</th>
                                    </tr>
                                </thead>
                                <tbody id="sendMailList">

                                </tbody>
                                <tr>
                                    <td colspan="5">
                                        <div class="pagging">
                                            <nav aria-label="Page navigation">
                                                <div id="pagination"></div>
                                            </nav>
                                        </div>
                                    </td>
                                </tr>
                            </table>

							    <button id="allDelete" onclick="allDelete()" class="btn btn-danger btn-delete">
							        <i class="fa fa-trash"></i> 삭제
							    </button>

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
        listCall(showPage);
    });

    function allDelete() {
    	
    	  var checkedIds = [];
    	    $('.checkout-room-checkbox:checked').each(function() {
    	        checkedIds.push($(this).val());
    	    });
    	    console.log('checkedIds : ',checkedIds);
    	    $.ajax({
    	    	type:'POST',
    	    	url:'/mail/mail_all_delete.ajax',
    	    	contentType: 'application/json',
    	    	data:JSON.stringify({
    	    		mail_no:checkedIds
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
    
    
    function search() {
        $('#pagination').twbsPagination('destroy');
        listCall(showPage);
    }

    function listCall(showPage) {
        var search = $('#search').val();
        console.log("리스트콜 호출");
        $.ajax({
            type: 'POST',
            url: '/mail/sendMailList.ajax',
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

    function drawList(list) {
        var roomContainer = $('#sendMailList');
        roomContainer.empty(); 
        
        var content = '';
        for (var item of list) {
            var receivers = item.mail_receiver.split(',');
            var displayReceivers = [];
            var remainingReceivers = 0;
            
            for (var receiver of receivers) {
                receiver = receiver.trim();
                if (receiver.includes('"')) {
                    // "이름" <이메일> 형식의 수신자 처리
                    var emailStart = receiver.indexOf('"');
                    var emailEnd = receiver.indexOf('"', emailStart + 1);
                    if (emailStart != -1 && emailEnd != -1) {
                        var name = receiver.substring(0, emailStart).trim();
                        var email = receiver.substring(emailStart + 1, emailEnd).trim();
                        displayReceivers.push(name + ' <' + email + '>');
                    }
                } else {
                    // 단순 이메일 형식의 수신자 처리
                    displayReceivers.push(receiver);
                }
            }

            if (displayReceivers.length > 1) {
                remainingReceivers = displayReceivers.length - 1;
            }

            var displayText = remainingReceivers > 0 ? displayReceivers[0] + ' 외 ' + remainingReceivers + '명' : displayReceivers[0];
            
            content += '<tr class="trHover">';
            content += '<td><input type="checkbox" class="checkout-room-checkbox" value="' + item.mail_no + '"></td>';
            content += '<td>' + displayText + '</td>';
            content += '<td ><a href="#" onclick="mailDetail(' + item.mail_no + ')">' + item.mail_subject + '</a></td>';
            content += '<td>' + item.send_date + '</td>';     
            content += '<td><a href="#" onclick="deleteMail(' + item.mail_no + ')"><i class="fas fa-trash-alt"></i></a></td>';     
            content += '</tr>';
        }
        $('#sendMailList').html(content);

        $('#select-all-checkouts').click(function() {
            $('.checkout-room-checkbox').prop('checked', this.checked);
        });
    }

    function deleteMail(mail_no) {

    	$.ajax({
	    	type:'POST',
	    	url:'/mail/deleteMail.ajax',
	    	data:{
	    		mail_no : mail_no
	    	},
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
    
    
    function mailDetail(mail_no){
    	location.href="/mail/mailDetail.go?mail_no="+mail_no;
    }
</script>
</html>
