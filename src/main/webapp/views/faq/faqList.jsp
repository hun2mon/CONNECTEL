<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

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

/* FAQ 리스트 스타일 */
.faq-list {
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 10px 0;
}

.faq-list_no, .faq-list_subject {
    margin: 0 10px;
}

.faq-list_no, .faq-list_subject, .freecheckbox {
    align-self: center;
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
        <button id="writebutton" onclick="faqwrite()">글쓰기</button>
        <button id="deletebutton" style="margin-left:10px;">삭제</button>
    </span>
    
    <hr>
    <div class="faqContent">
        <!-- 탭 -->
        <div class="tab">
            <button class="tablinks" onclick="openTab(event, '전체')" id="defaultOpen">전체</button>
            <button class="tablinks" onclick="openTab(event, '객실')">객실</button>
            <button class="tablinks" onclick="openTab(event, '예약')">예약 및 환불</button>
            <button class="tablinks" onclick="openTab(event, '부대시설')">부대시설</button>
            <button class="tablinks" onclick="openTab(event, '기타')">기타</button>
        </div>
    </div>
    <!-- 리스트 라인 -->
    <div id="faqList">
    </div>
    
    <div class="pagination">                           
        <nav aria-label="Page navigation" style="text-align:center">
            <ul class="pagination" id="pagination"></ul>
        </nav>               
    </div>
    <hr>
</div>
<hr>
<script>
// JavaScript 코드는 body 태그 하단에 위치시키는 것이 좋습니다.
$(document).ready(function(){
    // 페이지가 로드되면 FAQ 리스트를 초기화하고, 첫 번째 페이지를 호출합니다.
    listCall(1);
    
 
    // 페이지 이동 시 호출될 함수
    function listCall(page) {
        var cnt = 10; // 페이지당 항목 수, 필요에 따라 변경 가능
        $.ajax({
            type: 'GET',
            url: '/faq/faqList.ajax',
            data: {
                'page': page,
                'cnt': cnt
            },
            dataType: 'json',
            success: function(data) {
                console.log('AJAX 요청 성공');
                console.log(data.list);
                drawFaqList(data.list); // FAQ 리스트 그리기 함수 호출
                initializePagination(data.totalPages); // 페이징 초기화
            },
            error: function(error) {
                console.log('FAQ 리스트 출력 실패:', error);
            }
        });
    }

    // FAQ 리스트를 그리는 함수
    function drawFaqList(data) {
        var content = '';  
        for (var i = 0; i < data.length; i++) {
            content += '<div class="faq-list">';
            content += '<div class="faq-list_no">' + data[i].faq_no + '</div>';
            content += '<div class="faq-list_subject"><a href="faqDetail.go?faq_no=' + data[i].faq_no + '">' + data[i].faq_subject + '</a></div>';
            content += '<input type="checkbox" class="freecheckbox" id="checkbox_' + data[i].faq_no + '">';
            content += '</div>';
        }
        $('#faqList').html(content); // 기존 데이터를 초기화하고 새로운 데이터로 대체
    }

    // 페이징을 초기화하는 함수
    function initializePagination(totalPages) {
        $('#pagination').twbsPagination({
            totalPages: totalPages, // 전체 페이지 수
            visiblePages: 5, // 보여줄 페이지 수
            onPageClick: function(event, page) { 
                console.log('페이지 클릭 이벤트 발생:', page);
                listCall(page); // 페이지 클릭 시 해당 페이지의 데이터를 호출하는 함수 호출
            }
        });
    }

    
   //삭제하기
    // FAQ 삭제 버튼 클릭 이벤트 처리
    $('#deletebutton').click(function() {
        var checkedItems = $('.freecheckbox:checked'); // 선택된 체크박스들을 가져옴
        var faqNos = []; // 삭제할 FAQ 번호들을 담을 배열

        // 선택된 체크박스들의 FAQ 번호를 배열에 추가
        checkedItems.each(function() {
            var faqNo = $(this).attr('id').split('_')[1]; // 체크박스 ID에서 FAQ 번호 추출
            faqNos.push(parseInt(faqNo)); // FAQ 번호를 정수로 변환하여 배열에 추가
        });

        // 최소한 하나의 체크박스가 선택되었는지 확인
        if (faqNos.length > 0) {
            // 삭제할 FAQ 번호들을 서버로 전송하여 삭제 요청
            $.ajax({
                type: 'POST',
                url: '/faq/deleteFaq.ajax',
                contentType: 'application/json',
                data: JSON.stringify(faqNos), // JSON 형식으로 데이터 전송
                success: function(response) {
                    console.log('삭제 성공:', response);
                    alert('삭제에 성공하였습니다.');
                    listCall(1); // 삭제 후 리스트 다시 호출
                },
                error: function(error) {
                    console.log('삭제 실패:', error);
                    alert('삭제 중 오류가 발생했습니다.'); // 오류 메시지 표시
                }
            });
        } else {
            alert('삭제할 FAQ를 선택해주세요.');
        }
    });
});







//작성 폼으로가기
function faqwrite() {
    window.location.href = '/faqwrite.go';
}
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js"></script>
</body>
</html>