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
        align-items: flex-start; /* 세로 정렬을 위해 top으로 정렬 */
        flex-wrap: wrap; /* 필요에 따라 줄 바꿈 처리 */
    }

    .form-control {
        flex: 1;
    }

    .image-container {
        flex: 1; /* 이미지 컨테이너가 남은 공간을 모두 차지하도록 설정 */
        display: flex;
        align-items: center; /* 수직 정렬을 위해 중앙 정렬 */
        justify-content: center; /* 가로 정렬을 위해 중앙 정렬 */
        gap: 10px;
        position: relative; /* 상대 위치 설정 */
        overflow: hidden; /* 내용이 넘칠 경우 숨김 처리 */
    }

    .image-container img {
        width: 100%; /* 이미지의 너비를 자동으로 설정 */
        height: 379px; /* 이미지의 높이를 자동으로 조정 */
        object-fit: contain; /* 이미지가 컨테이너에 맞게 조정되면서 원본 비율 유지 */
        transition: transform 0.3s ease; /* 이미지 전환 효과 설정 */
        margin-top: 50px;
    }

    .image-container .prev, .image-container .next {
        position: absolute; /* 절대 위치 설정 */
        top: 50%; /* 상단에서 중앙 정렬 */
        transform: translateY(-50%); /* 수직으로 중앙 정렬 */
        background-color: rgba(0, 0, 0, 0.5); /* 배경색과 투명도 설정 */
        color: white; /* 텍스트 색상 설정 */
        padding: 10px; /* 내부 여백 설정 */
        cursor: pointer; /* 커서 모양 설정 */
        transition: background-color 0.3s ease; /* 배경색 전환 효과 설정 */
    }

    .image-container .prev:hover, .image-container .next:hover {
        background-color: rgba(0, 0, 0, 0.8); /* 마우스 호버 시 배경색 변경 */
    }

    .image-container .prev {
        left: 0; /* 왼쪽 정렬 */
    }

    .image-container .next {
        right: 0; /* 오른쪽 정렬 */
    }

    .textarea-container {
        flex: 2; /* 텍스트 영역 컨테이너가 남은 공간을 모두 차지하도록 설정 */
        display: flex;
        align-items: flex-start; /* 세로 정렬을 위해 top으로 정렬 */
        gap: 10px;
        margin-left: 20px; /* 사진과 텍스트 영역 사이 여백 설정 */
        margin-top: 50px;
    }

    .textarea_editor {
        overflow-y: auto; /* textarea의 내용이 넘칠 경우 스크롤바를 표시 */
        width: 100%; /* textarea의 너비를 전체로 설정 */
    }

    .textarea_editor textarea {
        resize: none; /* textarea의 크기 조절 비활성화 */
    }
    
    hr {
        margin: 30px 0; /* hr 태그 위아래 여백 설정 */
        border: none;
        border-top: 1px solid #ced4da; /* 수평선 스타일 설정 */
    }
    
    .form-control.bg-transparent {
        text-align: center;
    }
    
     .buttons-container {
        display: flex;
        justify-content: space-between; /* 좌우 여백을 동일하게 설정 */
        align-items: center; /* 세로 정렬을 위해 센터로 정렬 */
        margin-left: 20px; /* 전체 컨텐츠와의 왼쪽 여백 설정 */
        margin-right: 20px; /* 전체 컨텐츠와의 오른쪽 여백 설정 */
    }

    #list {
        margin-right: auto; /* 리스트 버튼이 좌측에 정렬되도록 설정 */
    }

    .btn {
        margin-top: 50px; /* 필요에 따라 버튼의 상단 여백을 조정합니다. */
        margin-right: 10px;
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
                         <div class="form-group">
                             <input type="text" class="form-control bg-transparent" name="room_no" readonly="readonly" value="${item.room_no}">
                             <input type="text" class="form-control bg-transparent" name="name" readonly="readonly" value="${item.name}">
                             <input type="text" class="form-control bg-transparent" name="date" readonly="readonly" value="${item.regist_date}">
                             <input type="hidden" name="room_manage_no" value="${item.room_manage_no}">
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
                                    </div>
                                    <div class="textarea-container">
                                        <textarea id="email-compose-editor" class="textarea_editor form-control bg-transparent" rows="15" name="content" readonly="readonly">${item.content}</textarea>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="textarea-container" style="flex: 1;">
                                        <textarea id="email-compose-editor" class="textarea_editor form-control bg-transparent" rows="15" name="content" readonly="readonly">${item.content}</textarea>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                         </div>								                               
                         <div class="text-right mt-4 mb-5" id="btn">
                              <div class="buttons-container">
                                 <button class="btn btn-info btn-sl-sm" id="list" onclick="goList()">
                                    <span class="mr-2"><i class="fas fa-list"></i></span>리스트
                                </button>
                                <c:if test="${item.register eq loginInfo.emp_no && item.status eq 'N'}">
                                    <button class="btn btn-primary btn-sl-sm" type="button" onclick="roomManageUpdate('${item.room_manage_no}')">
                                        <span class="mr-2"><i class="fas fa-undo"></i></span>수정
                                    </button>	
                                </c:if>                         
                                <c:if test="${item.status eq 'N' && (loginInfo.authority eq '2' || loginInfo.authority eq '3')}">
								    <button class="btn btn-success btn-sl-sm" onclick="successBtn()">
								        <span class="mr-2"><i class="fas fa-check-circle"></i></span>처리완료
								    </button>	
								</c:if>                               
                            </div>			    
                         </div>
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
    
    function roomManageUpdate(room_manage_no){
    	console.log(room_manage_no);
        location.href="/room/roomManageUpdate.go?room_manage_no="+room_manage_no;
    }
    
    function goList() {
    	location.href="/room/roomManageList.go";
	}
    
    function successBtn() {
		console.log(${item.room_manage_no});
		location.href="/room/room_manage_status_update.do?room_manage_no="+${item.room_manage_no}+"&room_no="+${item.room_no};
	}
</script>
</html>
