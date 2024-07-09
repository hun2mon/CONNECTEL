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

#receiverList {
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

tr {
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
    display: none; /* 기본적으로 모든 탭 숨기기 */
}

.tab-content > .active {
    display: block; /* 활성 탭만 표시 */
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
                                <a class="nav-link active show" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true">
                                    <i class="mdi mdi-home-variant d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block">내주소록</span>
                                </a>
                                <a class="nav-link" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false">
                                    <i class="mdi mdi-account-circle d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block" style="font-size: 14px;">고객주소록</span>
                                </a>
                                <a class="nav-link" id="v-pills-settings-tab" data-toggle="pill" href="#v-pills-settings" role="tab" aria-controls="v-pills-settings" aria-selected="false">
                                    <i class="mdi mdi-settings-outline d-lg-none d-block mr-1"></i>
                                    <span class="d-none d-lg-block">즐겨찾기</span>
                                </a>
                            </div>
                        </div> <!-- end col-->

                        <div class="col-sm-9">
                            <div class="tab-content" id="v-pills-tabContent">
                                <div class="tab-pane fade active show" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
                                    <!-- 내주소록 -->
                                    <button class="btn btn-primary mb-2" onclick="toggleSelectAll('myAddList')">전체 선택/해제</button>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
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
                                    <button class="btn btn-primary mb-2" onclick="toggleSelectAll('clientAddList')">전체 선택/해제</button>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
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
                                    <button class="btn btn-primary mb-2" onclick="toggleSelectAll('markAddList')">전체 선택/해제</button>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
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
    listCall();
    clientListCall();
    myFavoriteListCall();
   
});

function search() {
    listCall();
    myFavoriteListCall();
    clientListCall();
}

function clientListCall() {
    var search = $('#search').val();
    $.ajax({
        type: 'POST',
        url: '/mail/clientAddListCall.ajax',
        data: { search: search },
        dataType: 'JSON',
        success: function(data) {
            console.log(data);
            var content = '';
            for (let item of data.list) {
                content += '<tr onclick="selectRow(this, \'clientAddList\')">';
                content += '<td>' + item.cos_name + '</td>';
                content += '<td>' + item.cos_email + '</td>';
                content += '</tr>';
            }
            $('#clientAddList').html(content);
            syncSelectedItems('clientAddList');
        },
        error: function(e) {
            console.log(e);
        }
    });
}

function listCall() {
    var search = $('#search').val();
    $.ajax({
        type: 'POST',
        url: '/mail/myAddList.ajax',
        data: { search: search },
        dataType: 'JSON',
        success: function(data) {
            console.log(data);
            var content = '';
            for (let item of data.list) {
                content += '<tr onclick="selectRow(this, \'myAddList\')">';
                content += '<td>' + item.add_name + '</td>';
                content += '<td>' + item.add_email + '</td>';
                content += '</tr>';
            }
            $('#myAddList').html(content);
            syncSelectedItems('myAddList');
        },
        error: function(e) {
            console.log(e);
        }
    });
}

function myFavoriteListCall() {
    var search = $('#search').val();
    $.ajax({
        type: 'POST',
        url: '/mail/myFavoriteList.ajax',
        data: { search: search },
        dataType: 'JSON',
        success: function(data) {
            console.log(data);
            var content = '';
            for (let item of data.list) {
                content += '<tr onclick="selectRow(this, \'markAddList\')">';
                content += '<td>' + item.add_name + '</td>';
                content += '<td>' + item.add_email + '</td>';
                content += '</tr>';
            }
            $('#markAddList').html(content);
            syncSelectedItems('markAddList');
        },
        error: function(e) {
            console.log(e);
        }
    });
}

function updateReceiverList() {
    var selected = [];
    $('#myAddList tr.selected, #clientAddList tr.selected, #markAddList tr.selected').each(function() {
        var name = $(this).find('td').eq(0).text();
        var email = $(this).find('td').eq(1).text();
        var itemText = name + ' "' + email + '"';
        if (!isAlreadySelected(itemText)) {
            selected.push(itemText);
        }
    });
    $('#receiverList').empty();
    $('#receiverList').html(selected.join('<br>'));
}

function isAlreadySelected(itemText) {
    var alreadySelected = false;
    $('#receiverList li').each(function() {
        if ($(this).text() === itemText) {
            alreadySelected = true;
            return false; // 반복문 종료
        }
    });
    return alreadySelected;
}

function selectRow(row, tableId) {
    var selectedTable = $('#' + tableId);
    $(row).toggleClass('selected');
    updateReceiverList(); // 선택 변경 후 수신자 목록 업데이트
    syncSelectedItems(tableId);
}

function toggleSelectAll(tableId) {
    var allSelected = $('#' + tableId + ' tr').length === $('#' + tableId + ' tr.selected').length;
    $('#' + tableId + ' tr').each(function() {
        $(this).toggleClass('selected', !allSelected);
    });
    updateReceiverList();
    syncSelectedItems(tableId);
}

function syncSelectedItems(tableId) {
    // Remove items from receiver list which are not selected anymore
    var selectedTable = $('#' + tableId);
    $('#receiverList li').each(function() {
        var listItemText = $(this).text();
        var isSelected = false;
        selectedTable.find('tr.selected').each(function() {
            var name = $(this).find('td').eq(0).text();
            var email = $(this).find('td').eq(1).text();
            if (listItemText === name + ' "' + email + '"') {
                isSelected = true;
                return false; // Break the loop
            }
        });
        if (!isSelected) {
            $(this).remove();
        }
    });
}

function confirmAction() {
	
	// 현재 URL에서 파라미터 가져오기
    var urlParams = new URLSearchParams(window.location.search);

    // mail_receiver, mail_subject, mail_content 파라미터 값 가져오기
    var mail_receiver = urlParams.get('mail_receiver');
    var mail_subject = urlParams.get('mail_subject');
    var mail_content = urlParams.get('mail_content');

    // 가져온 값 사용 예시
    console.log('Mail Receiver:', mail_receiver);
    console.log('Mail Subject:', mail_subject);
    console.log('Mail Content:', mail_content);
	
	
    var receiverList = $('#receiverList').html();
    var receiver = receiverList.split('<br>');
    
    var receivers = mail_receiver+','+receiver;
    
    console.log('receivers : ' +receivers + 'M_subject : ' + mail_subject + 'M_content : ' + mail_content);
     
    if (window.opener) {
    	window.opener.location.href = '/mail/sendMail?receivers=' + encodeURIComponent(receivers) + '&mail_subject=' + encodeURIComponent(mail_subject) + '&mail_content=' + encodeURIComponent(mail_content);
        window.close();
    } else {
        alert('부모 창이 없습니다.');
    } 
}

function cancelAction() {
    window.close();
}

</script>
</html>
