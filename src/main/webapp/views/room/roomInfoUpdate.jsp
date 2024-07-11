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

    .text-right {
        text-align: right;
    }
    
    table {
        text-align: center;
    }
    
    input, textarea {
        width: 100%;
    }
    
    .tabs {
        display: flex;
        cursor: pointer;
    }

    .tab {
        flex: 1;
        padding: 10px;
        background-color: #f1f1f1;
        text-align: center;
        border: 1px solid #ccc;
        transition: background-color 0.3s;
    }

    .tab.active {
        background-color: #007bff;
        color: white;
        border-color: #007bff;
    }

    #room_image {
        width: 100%;
        height: 700px;
        object-fit: contain;
    }

    .image-container {
        width: 100%;
        height: auto; 
        overflow: hidden; /* 이미지가 요소를 벗어나지 않도록 설정 */
    }
    
    .button-container {
        text-align: right;
    }
</style>
</head>
<body>
<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>

<div class="content-body">
    <div class="container-fluid">
        <div class="tabs">
            <div class="tab" data-tab="standard" onclick="listCall('1001')">스탠다드룸</div>
            <div class="tab" data-tab="superior" onclick="listCall('1002')">슈페리어룸</div>
            <div class="tab" data-tab="deluxe" onclick="listCall('1003')">디럭스룸</div>
            <div class="tab" data-tab="suite" onclick="listCall('1004')">스위트룸</div>
        </div>
        
        <div class="tab-content" id="tab-standard">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="table-responsive">
                                <form action="/room/roomInfoUpdate.do" method="post" enctype="multipart/form-data">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th scope="col" colspan="2">
                                                    <div class="image-container">
                                                        <img src="#" id="room_image">
                                                    </div>                                               
                                                    <input type="file" id="image_upload" name="photo" accept="image/*" /> 
                                                    <input type="text" value="" id="room_type_code" name="room_type_code" hidden>                                               
                                                </th>                                      
                                            </tr>                                      
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th scope="row">상세설명</th>
                                                <td><textarea rows="3" class="form-control" id="room_detail" name="room_detail"></textarea></td>
                                            </tr>
                                            <tr>
                                                <th scope="row">평수</th>
                                                <td><input type="text" class="form-control" id="room_extent" name="room_extent"></td>
                                            </tr>
                                            <tr>
                                                <th scope="row">침대</th>
                                                <td><input type="text" class="form-control" id="room_bed" name="room_bed"></td>
                                            </tr>
                                            <tr>
                                                <th scope="row">수용인원</th>
                                                <td><input type="text" class="form-control" id="room_capacity" name="room_capacity"></td>
                                            </tr>
                                            <tr>
                                                <th scope="row">어메니티</th>
                                                <td><input type="text" class="form-control" id="room_amenities" name="room_amenities"></td>
                                            </tr>
                                        </tbody>
                                   
                                    </table>
                                    <div class="button-container">
                                        <button type="submit" class="btn btn-primary">수정</button>
                                    </div>
                                 </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add other room types similarly -->

    </div>
</div>

<div id="loadingSpinner" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(255,255,255,0.8); z-index:1000; text-align:center;">
    <img src="/assets/images/mailSending.gif" alt="Loading..." style="width: 300px; height: 300px; position:relative; top:50%; transform:translateY(-50%);">
    <div style="margin-top: 20px; font-size: 24px;">메일을 전송 중입니다...</div>
</div>


</body>
<script>
var num;

$(document).ready(function(){

    var room_type = "${room_type}";
    
    if (room_type) {
        listCall(room_type);
        setActiveTab(room_type); // 페이지 로드 시 해당 room_type에 맞는 탭을 활성화
    } else {
        listCall('1001');
        setActiveTab('1001'); // 기본값으로 스탠다드룸 탭을 활성화
    }

    $('.tab').on('click', function() {
        var tabId = $(this).data('tab');
        $('.tab').removeClass('active');
        $(this).addClass('active');
        $('.tab-content').removeClass('active');
        $('#tab-' + tabId).addClass('active');
    });

    $('#image_upload').on('change', function(event) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#room_image').attr('src', e.target.result);
        }
        reader.readAsDataURL(event.target.files[0]);
    });

    
});




function setActiveTab(room_type) {
    $('.tab').removeClass('active'); // 모든 탭의 활성화 클래스 제거
    // room_type에 따라 해당 탭에 active 클래스 추가
    if (room_type === '1001') {
        $('.tab[data-tab="standard"]').addClass('active');
    } else if (room_type === '1002') {
        $('.tab[data-tab="superior"]').addClass('active');
    } else if (room_type === '1003') {
        $('.tab[data-tab="deluxe"]').addClass('active');
    } else if (room_type === '1004') {
        $('.tab[data-tab="suite"]').addClass('active');
    }
}


function listCall(type_code) {
    num = type_code;
    console.log('type_code : ' + type_code);

    $.ajax({
        type:'POST',
        url:'/room/roomInfoList.ajax',
        data:{
            type_code:type_code
        },
        dataType:'JSON',
        success:function(data){
            console.log(data);                
            $('#room_image').attr('src','/photo/'+data.pho_name);
            $('#room_extent').val(data.list.room_extent);
            $('#room_bed').val(data.list.room_bed);
            $('#room_capacity').val(data.list.room_capacity);
            $('#room_amenities').val(data.list.room_amenities);
            $('#room_detail').val(data.list.room_detail);
            $('#room_type_code').val(type_code);

        },
        error:function(e){
            console.log(e);
        }
    })
}
</script>
</html>
