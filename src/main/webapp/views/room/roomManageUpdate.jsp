<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Room Detail</title>
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

    .content-body {
        flex-grow: 1;
        padding: 20px;
        overflow-y: auto;
        margin-top: 50px;
    }

    .card {
        margin: 20px 0;
    }

    .form-group {
        display: flex;
        gap: 10px;
        align-items: flex-start;
        flex-wrap: wrap;
    }

    .form-control {
        flex: 1;
    }

    .image-container {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        position: relative;
        overflow: hidden;
        flex-direction: column;
    }

    .image-container img {
        width: 100%;
        height: 379px;
        object-fit: contain;
        transition: transform 0.3s ease;
        margin-top: 50px;
    }

    .image-container .prev, .image-container .next {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        background-color: rgba(0, 0, 0, 0.5);
        color: white;
        padding: 10px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .image-container .prev:hover, .image-container .next:hover {
        background-color: rgba(0, 0, 0, 0.8);
    }

    .image-container .prev {
        left: 0;
    }

    .image-container .next {
        right: 0;
    }

    .delete-button {
        margin-top: 10px;
    }

    .textarea-container {
        flex: 2;
        display: flex;
        align-items: flex-start;
        gap: 10px;
        margin-left: 20px;
        margin-top: 50px;
    }

    .textarea_editor {
        overflow-y: auto;
        width: 100%;
    }

    .textarea_editor textarea {
        resize: none;
    }
    
    hr {
        margin: 30px 0;
        border: none;
        border-top: 1px solid #ced4da;
    }
    
    .form-control.bg-transparent {
        text-align: center;
    }
    
    #list {
        margin-right: 80%;
    }
    
    .btn {
        margin-top: 50px;
    }

    .file-upload-container {
        margin-top: 20px;
    }

    .file-upload-container input[type="file"] {
        display: block;
        margin-bottom: 10px; /* 각 입력 필드 사이의 여백 설정 */
    }

    .file-upload-container button {
        margin-top: 10px;
    }
    
    #email-compose-editor{
    	text-align: left;
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
                         <form action="/room/roomManageUpdate.do" method="post" enctype="multipart/form-data">
                             <div class="form-group">
                                 <input type="text" class="form-control bg-transparent" name="room_no" readonly="readonly" value="${item.room_no}">
                                 <input type="text" class="form-control bg-transparent" name="name" readonly="readonly" value="${item.name}">
                                 <input type="text" class="form-control bg-transparent" name="date" readonly="readonly" value="${item.regist_date}">
                                 <c:choose>
                                     <c:when test="${item.status eq 'N'}">
                                         <input type="text" class="form-control bg-transparent" style="color: red;" name="updater" readonly="readonly" value="미처리">
                                     </c:when>
                                     <c:when test="${item.status eq 'Y'}">
                                         <input type="text" class="form-control bg-transparent" style="color: green;" name="updater" readonly="readonly" value="처리완료">
                                     </c:when>
                                 </c:choose>
                             </div>
                             <hr>
                             <div class="form-group">
                                 <c:choose>
                                    <c:when test="${not empty photo}">
                                        <div class="image-container">
                                            <c:forEach var="photo" items="${photo}">
                                                <img src="/photo/${photo}" alt="Image">
                                            </c:forEach>
                                            <div class="prev" onclick="plusSlides(-1)">&#10094;</div>
                                            <div class="next" onclick="plusSlides(1)">&#10095;</div>
                                            <button type="button" class="btn btn-danger delete-button" onclick="photoDelete()">삭제</button>
                                        </div>
                                        <div class="textarea-container">
                                            <textarea id="email-compose-editor" class="textarea_editor form-control bg-transparent" rows="15" name="content">${item.content}</textarea>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="textarea-container" style="flex: 1;">
                                            <textarea id="email-compose-editor" class="textarea_editor form-control bg-transparent" rows="15" name="content">${item.content}</textarea>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                             </div>								                               
                             <div class="file-upload-container">
                                <input type="file" class="dropify" multiple="multiple" name="multipartFiles" accept="image/*" />
                                <input type="hidden" name="room_manage_no" value="${item.room_manage_no}">                                
                             </div>                        
                         <div class="text-right mt-4 mb-5" id="btn">             
                               <button type="button" class="btn btn-secondary btn-sl-sm" onclick="goBack()">
                               <span class="mr-2"><i class="fas fa-arrow-left"></i></span>취소
                                </button>  
                            <button type="submit" class="btn btn-success btn-sl-sm">
                                <span class="mr-2"><i class="fas fa-check-circle"></i></span>수정완료
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
    var slideIndex = 1; // 이미지 슬라이드의 초기 위치 설정
    showSlides(slideIndex); // 페이지 로드 시 첫 번째 슬라이드 보여주기

    // 이전/다음 슬라이드로 이동하는 함수
    function plusSlides(n) {
        showSlides(slideIndex += n);
    }

    // 현재 슬라이드를 보여주는 함수
    function showSlides(n) {
        var i;
        var slides = document.getElementsByClassName("image-container")[0].getElementsByTagName("img");
        if (n > slides.length) { slideIndex = 1 } // 처음으로 돌아가기
        if (n < 1) { slideIndex = slides.length } // 마지막으로 돌아가기
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none"; // 모든 이미지 숨기기
        }
        slides[slideIndex - 1].style.display = "block"; // 현재 슬라이드만 보이기
    }

    function photoDelete() {
        var slides = document.getElementsByClassName("image-container")[0].getElementsByTagName("img");
        var currentSlide = slides[slideIndex - 1];
        var photoName = currentSlide.src.split('/').pop(); // Extract the photo name from the src attribute
        var roomManageNo = "${item.room_manage_no}";
        console.log("Photo delete button clicked. Current photo:", photoName);
        location.href="/room/phoDelete.do?pho_name=" + photoName + "&room_manage_no=" + roomManageNo;
    }

    function roomManageUpdate(room_manage_no){
        location.href="/room/ManageUpdate.go?room_manage_no=" + room_manage_no;
    }
    
    function goBack() {
        history.back(); // 브라우저의 뒤로 가기 기능을 수행합니다.
    } 
</script>
</html>
