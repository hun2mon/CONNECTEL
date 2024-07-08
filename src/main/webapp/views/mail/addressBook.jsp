<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>메일 주소록</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
.row {
    display: flex;
    flex-wrap: nowrap;
}

.col-xl-6 {
    padding: 10px;
    display: flex;
    flex-direction: column;
}

#card1 {
    flex: 7; /* 70%의 너비를 차지하도록 설정 */
    padding: 10px;
}

#card2 {
    flex: 3; /* 30%의 너비를 차지하도록 설정 */
    padding: 10px;
    margin-left: 20px; /* 두 카드 사이의 간격 조정 */
    
}

.card {
    width: 100%;
}


.table-responsive {
    max-height: 400px; /* 원하는 최대 높이 설정 */
    overflow-y: auto; /* 높이를 초과하면 수직 스크롤바 표시 */
}

#receiverList{
	max-height: 400px; /* 원하는 최대 높이 설정 */
    overflow-y: auto;
}

.table {
    width: 100%;
    margin-bottom: 1rem;
    background-color: transparent;
    border-collapse: collapse;
    text-align: center;
}

.table th,
.table td {
    padding: 0.75rem;
    vertical-align: top;
    border-top: 1px solid #dee2e6;
}

tr{
	cursor: pointer;
}

.table thead th {
    vertical-align: bottom;
    border-bottom: 2px solid #dee2e6;
}

.table tbody + tbody {
    border-top: 2px solid #dee2e6;
}

.table .table {
    background-color: #fff;
}

.nav-pills .nav-link {
    border-radius: 0.25rem;
}

.tab-content > .tab-pane {
    display: none;
}

.tab-content > .active {
    display: block;
}

.form-control {
    display: block;
    width: 100%;
    padding: 0.375rem 0.75rem;
    font-size: 1rem;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}

.bg-transparent {
    background-color: transparent;
}
</style>

</head>
<body>
<div class="container">
    <h3>메일 주소록</h3>
    <input class="form-control custom-shadow custom-radius bg-white" type="search" placeholder="수신자명 또는 이메일을 선택해주세요" aria-label="Search" onkeyup="search()" id="search">
    <hr>

    <div class="row">
        <div class="col-xl-6" id="card1">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-3 mb-2 mb-sm-0">
                            <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                                <a class="nav-link active show"  id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true">
                                    <i class="mdi mdi-home-variant d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block">내주소록</span>
                                </a>
                                <a class="nav-link"  id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false">
                                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block" style="font-size: 14px;">고객주소록</span>
                                </a>
                                <a class="nav-link"  id="v-pills-settings-tab" data-toggle="pill" href="#v-pills-settings" role="tab" aria-controls="v-pills-settings" aria-selected="false">
                                    <i class="mdi mdi-settings-outline d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block">즐겨찾기</span>
                                </a>
                            </div>
                        </div> <!-- end col-->

                        <div class="col-sm-9">
                            <div class="tab-content" id="v-pills-tabContent">
                                <div class="tab-pane fade active show" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
                                    <!-- 내주소록 -->
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th scope="col"><input type="checkbox" id="checkAllHome"></th>
                                                    <th scope="col">이름</th>
                                                    <th scope="col">이메일</th>
                                                </tr>
                                            </thead>
                                            <tbody id="myAddList">                                        
                                                <!-- 데이터 행 -->
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
                                    <!-- 고객주소록 -->
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th scope="col"><input type="checkbox" id="checkAllProfile"></th>
                                                    <th scope="col">이름</th>
                                                    <th scope="col">이메일</th>
                                                </tr>
                                            </thead>
                                            <tbody id="clientAddList">                                        
                                                <!-- 데이터 행 -->
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">
                                    <!-- 즐겨찾기 -->
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th scope="col"><input type="checkbox" id="checkAllSettings"></th>
                                                    <th scope="col">이름</th>
                                                    <th scope="col">이메일</th>
                                                </tr>
                                            </thead>
                                            <tbody id="markAddList">                                        
                                                <!-- 데이터 행 -->
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div> <!-- end tab-content-->
                        </div> <!-- end col-->
                    </div>
                    <!-- end row-->
                </div> <!-- end card-body-->
            </div> <!-- end card-->
        </div> <!-- end col -->

        <div class="col-xl-6" id="card2">
            <div class="card">
                <div class="card-body">
                    <h3>받는사람</h3>
                    <ul id="receiverList">
                        <!-- 받는사람 섹션의 내용 추가 -->
                    </ul>
                </div>
            </div>
        </div>
    </div> <!-- end row -->

    <!-- 추가: 취소 버튼과 확인 버튼 -->
    <div class="row mt-3">
        <div class="col text-center">
            <button class="btn btn-secondary" onclick="cancelAction()">취소</button>
            <button class="btn btn-primary" onclick="confirmAction()">확인</button>
        </div>
    </div>
</div> <!-- end container -->
</body>

<script>
    $(document).ready(() => {
        $('#checkAllHome').change(function(){
            $('#v-pills-home input:checkbox').prop('checked', $(this).prop('checked'));
            updateReceiverList();
        });

        $('#checkAllProfile').change(function(){
            $('#v-pills-profile input:checkbox').prop('checked', $(this).prop('checked'));
            updateReceiverList();
        });

        $('#checkAllSettings').change(function(){
            $('#v-pills-settings input:checkbox').prop('checked', $(this).prop('checked'));
            updateReceiverList();
        });

        // 개별 체크박스의 이벤트 핸들러
         $(document).on('change', '.check', function() {
	        var type = $(this).closest('.tab-pane').attr('id'); // 현재 탭의 ID 가져오기 (v-pills-home, v-pills-profile, v-pills-settings)
	        var addNo = $(this).val(); // 현재 체크된 체크박스의 값 (add_no)
	        
	        // 현재 탭 이외의 탭에서 동일한 값의 체크박스를 찾아서 상태를 동기화
	        $('.tab-pane').not('#' + type).find('[value="' + addNo + '"]').prop('checked', $(this).prop('checked'));
	        
	        updateReceiverList();
	    });
               
		listCall();
		clentListCall();
        myFavoriteListCall();
    });
    
    function search() {
        listCall();
        myFavoriteListCall();
        clentListCall();
    }

    function clentListCall(){
    	 var search = $('#search').val();
    	
        $.ajax({
            type: 'POST',
            url: '/mail/clientAddListCall.ajax',
            data: {
            	search : search
            },
            dataType: 'JSON',
            success: function(data){
                console.log(data);

                var content = '';
                for(let item of data.list){
                    content += '<tr>';
                    content += '<td><input type="checkbox" class="check" value="' + item.res_no + '"></td>';
                    content += '<td>' + item.cos_name + '</td>';
                    content += '<td>' + item.cos_email + '</td>';
                    content += '</tr>';
                }
                $('#clientAddList').html(content);
            },
            error: function(e){
                console.log(e);
            }
        });
    }
    
    function listCall(){
    	
    	var search = $('#search').val();
    	
        $.ajax({
            type: 'POST',
            url: '/mail/myAddList.ajax',
            data: {
            	search : search
            },
            dataType: 'JSON',
            success: function(data){
                console.log(data);

                var content = '';
                for(let item of data.list){
                    content += '<tr>';
                    content += '<td><input type="checkbox" class="check" value="' + item.add_no + '"></td>';
                    content += '<td>' + item.add_name + '</td>';
                    content += '<td>' + item.add_email + '</td>';
                    content += '</tr>';
                }
                $('#myAddList').html(content);
            },
            error: function(e){
                console.log(e);
            }
        });
    }
    
    function myFavoriteListCall(){
    	
    	var search = $('#search').val();
    	
        $.ajax({
            type: 'POST',
            url: '/mail/myFavoriteList.ajax',
            data: {
            	search : search
            },
            dataType: 'JSON',
            success: function(data){
                console.log(data);

                var content = '';
                for(let item of data.list){
                    content += '<tr>';
                    content += '<td><input type="checkbox" class="check" value="' + item.add_no + '"></td>';
                    content += '<td>' + item.add_name + '</td>';
                    content += '<td>' + item.add_email + '</td>';
                    content += '</tr>';
                }
                $('#markAddList').html(content);
            },
            error: function(e){
                console.log(e);
            }
        });
    }
    
    function updateReceiverList(){
        var selected = [];
        var selectedIds = []; // 선택된 항목의 ID를 저장하는 배열
        
        $('.check:checked').each(function(){
            var row = $(this).closest('tr');
            var id = $(this).val(); // 체크박스의 값 (예: add_no)
            var name = row.find('td').eq(1).text();
            var email = row.find('td').eq(2).text();
            
            // 이미 선택된 ID가 없는 경우에만 추가
            if (selectedIds.indexOf(id) === -1) {
                selectedIds.push(id); // ID 추가
                selected.push('' + name + ' "' + email + '"'); // 이름과 이메일 추가
            }
        });
        
        $('#receiverList').empty(); // 기존 내용을 모두 지우고
        $('#receiverList').html(selected.join('<br>')); // 새로운 선택된 목록을 추가
    }

    
    function confirmAction(){
        var receiverList = $('#receiverList').html();
        var receivers = receiverList.split('<br>');
        
        // 부모 창에서 주소로 이동
        if (window.opener) {
            window.opener.location.href = '/mail/sendMail?receivers=' + receivers;
            window.close(); // 팝업 창 닫기
        } else {
            alert('부모 창이 없습니다.');
        }
    }

    function cancelAction() {
        window.close(); // 팝업 창 닫기
    }
</script>
</html>
