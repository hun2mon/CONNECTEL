<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="../jquery.twbsPagination.js" type="text/javascript"></script>
<style>

body {
    display: flex;
    margin: 0;
    height: 100vh;
}

.sidebar-container {
    flex-shrink: 0;
    width: 250px;
    background-color: #f8f9fa;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    overflow-y: auto;
}

/* 텍스트 박스 */
input[type="text"].freetextbox {
    border: 2px solid #6076E8; 
    border-radius: 4px; 
    padding: 3px; 
    font-size: 14px; 
    color: #333;
    outline: none; 
    width: 30vh;
    margin-right: 15px;
}

/* 텍스트 박스 포커스 시 */
input[type="text"].freetextbox:focus {
    border-color: #4056A1;
}

/* **전체** */
.commonstext {
    flex-grow: 1;
    padding: 20px;
    overflow-y: auto;
    margin-top: 100px; 
    text-align: center;
    white-space: nowrap;
}

/* 검색 영역 */
.search-container {
    display: inline-block;
    border: 2px solid #6076E8;
    border-radius: 8px;
    padding: 5px 40px;
    margin: 10px;
    background-color: whitegray;
}

/* 버튼 공통 스타일 */
button {
    background-color: #6076E8; 
    border: none; 
    color: white; 
    padding: 5px 10px;
    text-align: center; 
    text-decoration: none; 
    display: inline-block; 
    font-size: 14px; 
    margin: 4px 2px;
    cursor: pointer; 
    border-radius: 4px;
    transition-duration: 0.2s;
}

/* 버튼에 마우스 갖다 대면 */
button:hover {
    background-color: #4056A1;
}

/* 삭제 버튼 스타일 */
button#deletebutton {
    background-color: #6076E8;
}

button#deletebutton:hover {
    background-color: #4056A1;
}

/* 탭 스타일 */
.tab {
    overflow: hidden;
    border-bottom: 1px solid #ccc;
    background-color: #6076E8;
}

.tab button {
    background-color: inherit;
    float: left;
    border: none;
    outline: none;
    cursor: pointer;
    padding: 10px 20px;
    transition: 0.3s;
}

.tab button:hover {
    background-color: #4056A1;
}

.tab button.active {
    background-color: #4056A1;
}

.tabcontent {
    display: none;
    padding: 20px;
}



</style>
</head>
<body>
<!-- 상단 및 사이드 바 기본 -->
<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>


<!-- 검색 라인 -->
<div class="commonstext">
 <div class="faq-title">
        <h2>- FAQ -</h2>
    </div>
    <span class="search-container">
        <input type="text" class="freetextbox" id="customtextbox" placeholder=" 제목을 입력해주세요.">
        <button id="freebutton">검색</button>
    </span>
    <span class="nav-right">
        <button id="writebutton">글쓰기</button>
        <button id="deletebutton" style="margin-left:10px;">삭제</button>
    </span>
    
    <hr>

    <!-- 탭 -->
    <div class="tab">
        <button class="tablinks" onclick="openTab(event, '전체')" id="defaultOpen">전체</button>
        <button class="tablinks" onclick="openTab(event, '객실')">객실</button>
        <button class="tablinks" onclick="openTab(event, '예약')">예약 및 환불</button>
        <button class="tablinks" onclick="openTab(event, '부대시설')">부대시설</button>
        <button class="tablinks" onclick="openTab(event, '기타')">기타</button>
    </div>

    <!-- 탭 내용 -->
    <div id="전체" class="tabcontent">
    </div>
    <div id="객실" class="tabcontent">
    </div>
    <div id="예약" class="tabcontent">
    </div>
    <div id="부대시설" class="tabcontent">
    </div>
    <div id="기타" class="tabcontent">
    </div>
</div>

<hr>

<div id="faqList">

</div>
</body>

<script>
// -------------------------탭 기능 구현----------------------------
function openTab(evt, tabName) {
    var i, tabcontent, tablinks;
    
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    
    document.getElementById(tabName).style.display = "block";
    evt.currentTarget.className += " active";
    
    // AJAX 호출을 통해 탭 내용을 동적으로 로드
    listCall(tabName);
}

// 기본 탭 설정
document.getElementById("defaultOpen").click();

// ------------------------- 여기까지 탭 -----------------------------



// ------------------------ 아작스 랑 페이징  -----------------------------
// AJAX로 탭 내용을 가져오는 함수
var showPage = 1; // 현재 페이지를 저장할 변수

listCall(1);

$('#pagePerNum').on('change', function() {
    $('#pagination').twbsPagination('destroy');
    listCall(showPage);
});


function listCall(page) {
    $.ajax({
        type: 'GET',
        url: '/faq/faqList.ajax',
        data: {
        },
        dataType: 'json',
        success: function(data) {
            // 서버로부터 받은 데이터로 탭 내용을 업데이트
            console.log(data.list);
            drawFaqList(data.list); // FAQ 목록을 화면에 출력하는 함수 호출
            
        },
        error: function(error) {
            console.log('FAQ 리스트 출력 실패:', error);
        }
    });
}

// FAQ 목록을 화면에 출력하는 함수
function drawFaqList(data) {
	
	for(item of data){
    var content = '';
        content += '<div class="faq-list">';
        content += '<div class="faq-list_no">' + item.faq_no + '</div>';
        content += '<div class="faq-list_subject"' + item.faq_subject + '</div>';
        content += '<input type="checkbox" class="freecheckbox" id="customCheck2">';
        content += '</div>';

    }
    $('#faqList').append(content);
}



</script>
</html>