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

.pagination {
    margin-top: 10px; /* 적절한 상단 마진 추가 */
    margin-bottom: 10px; /* 적절한 하단 마진 추가 */
    display: flex;
    justify-content: center; /* 수평 중앙 정렬 */
}

.commonstext {
    flex-grow: 1;
    padding: 20px;
    overflow-y: auto;
    margin-top: 100px; 
    text-align: center;
}

.search-container {
    display: flex;
    align-items: center;
    border-radius: 8px;
    padding: 5px 40px;
    margin: 10px;
    background-color: #f8f9fa;
}

input[type="text"].freetextbox {
    border: 2px solid #6076E8; 
    border-radius: 4px; 
    padding: 3px; 
    font-size: 14px; 
    color: #333;
    outline: none; 
    width: 30vh;
    margin-right: 15px;
    margin-left: -50px;
}

input[type="text"].freetextbox:focus {
    border-color: #4056A1;
}

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

button:hover {
    background-color: #4056A1;
}

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

.faq-list {
    padding-left: 200px;
	width:80%;	
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 10px 0;
}

.faq-list_no, .faq-list_subject {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.faq-list_no {
    flex-basis: 50px;
}

.faq-list_subject {
    flex-grow: 1;
    margin: 0 10px;
}

.freecheckbox {
    margin-left: 10px;
}

.button-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.search-container {
    flex-grow: 1;
    display: flex;
    justify-content: flex-start;
}

.nav-right {
    display: flex;
    justify-content: flex-end;
}

</style>
</head>
<body>
<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>

<div class="commonstext">
    <div class="faq-title">
        <h2>- FAQ -</h2>
    </div>
    <div class="button-container">
        <div class="search-container">
            <input type="text" class="freetextbox" id="freetextbox" placeholder=" 제목을 입력해주세요.">
            <button id="freebutton">검색</button>
        </div>
        <div class="nav-right">
            <button id="writebutton" onclick="faqwrite()">글쓰기</button>
            <button id="deletebutton" style="margin-left: 10px;">삭제</button>
        </div>
    </div>
    
    <div class="faqContent">
        <div class="tab">
            <button class="tablinks" onclick="openTab(event, '전체')" id="defaultOpen">전체</button>
            <button class="tablinks" onclick="openTab(event, '객실')">객실</button>
            <button class="tablinks" onclick="openTab(event, '예약 및 환불')">예약 및 환불</button>
            <button class="tablinks" onclick="openTab(event, '부대시설')">부대시설</button>
            <button class="tablinks" onclick="openTab(event, '기타')">기타</button>
        </div>
        
        <div class="faq-list">
            <div class="faq-list_no"><strong>번호</strong></div>
            <div class="faq-list_subject"><strong>제목</strong></div>
            <div class="freecheckbox"><strong>선택</strong></div>
        </div>
    </div>
    <hr>
    <div id="faqList"></div>
    
    <div class="pagination">                           
        <nav aria-label="Page navigation" style="text-align:center">
            <ul class="pagination" id="pagination"></ul>
        </nav>               
    </div>
    <hr>
</div>
<hr>
<script>
var showPage = 1;

$(document).ready(function(){
    // 기본적으로 첫 번째 페이지를 '전체' 탭으로 호출
    listCall(1, '전체');
    
    $('#freebutton').on('click', function() {
	    var searchText = $('#freetextbox').val(); // 검색 입력란의 값 가져오기
	    // 검색어가 비어있는지 확인
	    if (searchText.trim() !== '') {
	        // 검색어가 비어있지 않으면 검색 실행
	        search(searchText, showPage); // 현재 페이지 번호를 함께 전달
	    } else {
	        // 검색어가 비어있으면 현재 페이지를 기준으로 공지사항을 다시 불러옴
	        listCall(showPage);
	    }
	});
    
    function search(title, page) {
        $.ajax({
            type: 'GET',
            url: '/faq/search.ajax', // 경로 앞에 슬래시 추가
            data: {
                'textval': title,
                'page': page.toString() // 페이지 번호를 문자열로 변환하여 전달
            },
            dataType: 'json', // 대소문자 구분에 주의해야 함
            success: function(data) {
                drawFaqList(data.list);
            },
            error: function(error) {
                console.log('검색 실패:', error);
            }
        });
    }
    
  
    
    
    
    
    // 페이지 이동 시 호출될 함수
    function listCall(page, category) {
        var cnt = 10; // 페이지당 항목 수, 필요에 따라 변경 가능
        $.ajax({
            type: 'GET',
            url: '/faq/faqList.ajax',
            data: {
                'page': page,
                'cnt': cnt,
                'category': category
            },
            dataType: 'json',
            success: function(data) {
                console.log('AJAX 요청 성공');
                console.log(data.list);
                drawFaqList(data.list); // FAQ 리스트 그리기 함수 호출
                initializePagination(data.totalPages, category); // 페이징 초기화
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
            content += '<div class="faq-list_subject"><a href="/faqDetail.go?faq_no=' + data[i].faq_no + '">' + data[i].faq_subject + '</a></div>';
            content += '<input type="checkbox" class="freecheckbox" id="checkbox_' + data[i].faq_no + '">';
            content += '</div>';
        }
        $('#faqList').html(content); // 기존 데이터를 초기화하고 새로운 데이터로 대체
    }

    // 페이징을 초기화하는 함수
    function initializePagination(totalPages, category) {
        $('#pagination').twbsPagination({
            totalPages: totalPages, // 전체 페이지 수
            visiblePages: 5, // 보여줄 페이지 수
            onPageClick: function(event, page) { 
                console.log('페이지 클릭 이벤트 발생:', page);
                listCall(page, category); // 페이지 클릭 시 해당 페이지의 데이터를 호출하는 함수 호출
            }
        });
    }

    // 탭 열기 함수
    window.openTab = function(evt, tabName) {
        var i, tablinks;
        // 모든 탭 버튼의 active 클래스 제거
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        // 클릭된 탭의 콘텐츠를 표시하고, 버튼에 active 클래스 추가
        evt.currentTarget.className += " active";
        listCall(1, tabName); // 해당 탭의 첫 번째 페이지 데이터를 호출
        $('#pagination').twbsPagination('destroy');
    }

    // 기본으로 열리는 탭 설정
    document.getElementById("defaultOpen").click();

    // 삭제 기능
    $('#deletebutton').click(function() {
        var checkedItems = $('.freecheckbox:checked');
        var faqNos = [];

        checkedItems.each(function() {
            var faqNo = $(this).attr('id').split('_')[1];
            faqNos.push(parseInt(faqNo));
        });

        if (faqNos.length > 0) {
            $.ajax({
                type: 'POST',
                url: '/faq/deleteFaq.ajax',
                contentType: 'application/json',
                data: JSON.stringify(faqNos),
                success: function(response) {
                    console.log('삭제 성공:', response);
                    alert('삭제에 성공하였습니다.');
                    listCall(1, '전체'); // 삭제 후 전체 리스트 다시 호출
                },
                error: function(error) {
                    console.log('삭제 실패:', error);
                    alert('삭제 중 오류가 발생했습니다.');
                }
            });
        } else {
            alert('삭제할 FAQ를 선택해주세요.');
        }
    });

    // 작성 폼으로 이동
    $('#writebutton').click(function() {
        window.location.href = '/faqwrite.go';
    });
});
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js"></script>
</body>
</html>