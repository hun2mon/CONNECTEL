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
    flex-wrap: wrap; /* 줄 바꿈을 하도록 설정 */
}

.col-xl-6 {
    padding: 10px;
}

.card {
    width: 100%;
}

.table-responsive {
    max-height: 400px;
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

/* 취소 및 확인 버튼을 가운데 정렬 */
.col.text-center {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px; /* 버튼과의 간격을 조정 */
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

         <div class="col-xl-6">
            <!-- 받는사람 목록은 그대로 유지 -->
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
    
    
    var urlParams = new URLSearchParams(window.location.search);
    var mail_receiver = urlParams.get('mail_receiver');
    var mail_subject = urlParams.get('mail_subject');
    var mail_content = urlParams.get('mail_content');

    console.log('mail_receiver : ' + mail_receiver);

    if (mail_receiver) {
        // 쉼표(,)로 구분된 이메일들을 배열로 변환
        var emails = mail_receiver.split(',');

        // 각 이메일을 <li> 태그로 변환하여 #receiverList에 추가
        emails.forEach(function(email) {
            var trimmedEmail = email.trim(); // 앞뒤 공백 제거
            if (trimmedEmail !== '') {
                $('#receiverList').append('<li>' + trimmedEmail + '</li>');
            }
        });
    }
   
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
        },
        error: function(e) {
            console.log(e);
        }
    });
}

function selectRow(row, listId) {
    var name = $(row).find('td:eq(0)').text(); // 첫 번째 셀에서 이름 가져오기
    var email = $(row).find('td:eq(1)').text(); // 두 번째 셀에서 이메일 가져오기

    var recipient = name + ' "' + email + '"';
    var $receiverList = $('#receiverList');

    // 받는사람 목록에서 수신자가 이미 존재하는지 확인
    var exists = false;
    $receiverList.find('li').each(function() {
        if ($(this).text().trim() === recipient) {
            exists = true;
            $(this).remove(); // 이미 존재하면 제거
            return false; // 반복문 종료
        }
    });

    // 수신자가 목록에 존재하지 않으면 추가
    if (!exists) {
        $receiverList.append('<li>' + recipient + '</li>');
    }
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

    // receiverList에서 <li> 태그를 포함한 모든 내용을 가져오기
    var receiverListHTML = $('#receiverList').html();
    
    // <li> 태그로 나누어진 배열 생성
    var receiversHTMLArray = receiverListHTML.split('</li>');
    
    // 배열의 각 항목에서 이름과 이메일 추출
    var receivers = [];
    receiversHTMLArray.forEach(function(item) {
        if (item.trim() !== '') { // 빈 항목은 무시
            var nameAndEmail = item.substring(item.lastIndexOf('>') + 1).trim();
            receivers.push(nameAndEmail);
        }
    });
    
    console.log('Receivers:', receivers);

    if (window.opener && window.opener.receiveMailData) {
        window.opener.receiveMailData(receivers.join(','), mail_subject, mail_content);
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
