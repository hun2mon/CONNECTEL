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
    <input type="text" id="" class="form-control bg-transparent" name="mail_receiver" placeholder="이름 또는 이메일을 입력해주세요">
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

        $(document).on('change', '.check', function(){
            updateReceiverList();
        });

        $(document).on('click', 'tbody tr', function(e) {
            if (e.target.type !== 'checkbox') {
                const checkbox = $(this).find('.check');
                checkbox.prop('checked', !checkbox.prop('checked'));
                updateReceiverList();
            }
        });

        clientAddListCall();
    });

    function clientAddListCall(){
        $.ajax({
            type: 'POST',
            url: '/mail/clientAddListCall.ajax',
            data: {},
            dataType: 'JSON',
            success: function(data){
                console.log(data);

                var content = '';
                for(let item of data.list){
                    content += '<tr>';
                    content += '<td><input type="checkbox" class="check" value="' + item.client_add_no + '"></td>';
                    content += '<td>' + item.client_name + '</td>';
                    content += '<td>' + item.client_email + '</td>';
                    content += '</tr>';
                }
                $('#clientAddList').html(content);
            },
            error: function(e){
                console.log(e);
            }
        });
    }

    function updateReceiverList(){
        var selected = [];
        $('.check:checked').each(function(){
            var row = $(this).closest('tr');
            var name = row.find('td').eq(1).text();
            var email = row.find('td').eq(2).text();
            selected.push('' + name + '"' + email + '"');
        });
        $('#receiverList').html(selected.join('<br>'));
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
        // 취소 동작 정의
        alert('취소 버튼이 클릭되었습니다.');
        window.close(); // 팝업 창 닫기
    }
</script>
</html>
