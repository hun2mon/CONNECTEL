<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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

    .read-content-body {
        word-wrap: break-word;
    }

    .read-content-body p {
        margin-bottom: 10px;
    }

    .file-upload-wrapper {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .room-input-wrapper {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .room-input-wrapper select {
        flex-grow: 1;
        width: 60%;
        margin-right: 10px;
    }

    .checkbox-wrapper {
        display: flex;
        align-items: center;
        margin-left: 10px;
    }

    .checkbox-wrapper input {
        margin-right: 5px;
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
                        <form id="roomForm" action="/room/roomManageWrite.do" method="post" enctype="multipart/form-data">
                            <div class="form-group room-input-wrapper">
                                <select class="form-control bg-transparent" name="room_no" id="roomSelect">
                                    <option value="">객실호수 선택</option>
                                </select>
                                <div class="checkbox-wrapper">
                                    <input type="checkbox" id="unavailable" name="unavailable">
                                    <label for="unavailable">이용불가</label>
                                </div>
                            </div>
                            <div class="form-group">
                                <textarea id="email-compose-editor" class="textarea_editor form-control bg-transparent" rows="15" name="content" placeholder="특이사항을 입력해주세요."></textarea>
                            </div>
                            <div class="form-group file-upload-wrapper">
                                <input type="file" class="dropify" multiple="multiple" name="multipartFiles" accept="image/*" />
                                <p>작성자 : ${loginInfo.name}</p>
                            </div>
                            <div class="text-right mt-4 mb-5">
                                <button class="btn btn-primary btn-sl-sm mr-3" type="submit">
                                    <span class="mr-2"><i class="fas fa-share-square"></i></span>등록
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<script>
$(document).ready(function(){
    listCall();

    // 유효성 검사
    $('#roomForm').submit(function(event) {
        var room = $('#roomSelect').val();
        var content = $('#email-compose-editor').val();

        if (room === "") {
            alert("객실호수를 선택해주세요.");
            event.preventDefault();
            return false;
        }

        if (content.trim() === "") {
            alert("내용을 입력해주세요.");
            event.preventDefault();
            return false;
        }
    });
});

function listCall() {
    $.ajax({
        type: 'POST',
        url: '/room/roomList.ajax',
        dataType: 'json',
        success: function(data) {
            console.log(data);
            populateRoomSelect(data.list);
        },
        error: function(e) {
            console.log(e);
        }
    });
}

function populateRoomSelect(roomList) {
    var roomSelect = $('#roomSelect');
    roomSelect.empty(); // 기존 옵션 제거
    roomSelect.append('<option value="">객실호수 선택</option>'); // 기본 옵션 추가

    // 객실 리스트를 순회하며 옵션 추가
    $.each(roomList, function(index, room) {
        roomSelect.append('<option value="' + room + '">' + room + '</option>'); // 수정: room 사용
    });
}
</script>
</html>
