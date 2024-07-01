<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최고의 호텔 'The Shilla' 호텔에 오신걸 환영합니다!</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: ;
    margin: 0;
    padding: 0;
}

h2 {
    margin-bottom: -1px;
    color: gray;
    text-align: center;
    white-space: nowrap; /* 줄 바꿈 방지 */
}
hr {
    white-space: nowrap; /* 줄 바꿈 방지 */
}
.search {
    border: 1px solid gray;
    padding-top: 10px;
    padding-bottom: 10px;
    margin-left: 30%;
    margin-right: 30%;
    background-color: #efeff1;
    text-align: center;
}
button {
    background-color: steelblue;
    border: solid 1px black;
    color: white;
    padding: 5px 10px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 12px;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: midnightblue; /* 마우스 오버 시 배경색 변화 */
}

#searchInput {
    width: 300px; /* input 요소의 길이를 300px로 설정 */
    padding-top: 2px;
    padding-bottom: 2px;
    margin-right: 10px;
}

.tab {
    overflow: hidden;
    border-bottom: 1px solid #ccc;
    background-color: #5E94B1;
    margin-top: 20px;
    font-size : 24px;
}
.tab button {
    background-color: inherit;
    float: left;
    border: none;
    outline: none;
    cursor: pointer;
    padding: 10px 20px;
    transition: 0.3s;
   	font-size: 15px;
}

.tab button:hover {
    background-color: #325c7f;
}

.tab button.active {
    background-color: #325c7f;
}

.faq {
    margin-bottom: 20px;
    width: 100%;
    border-collapse: collapse;
}

.faq .faq-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border: 1px solid #ddd;
    padding: 10px 0;
    white-space: nowrap; /* 줄 바꿈 방지 */
    overflow: hidden; /* 내용이 넘치면 숨기기 */
    text-overflow: ellipsis; /* 말줄임표 처리 */
}

.faq .faq-list-no,
.faq .faq-list-subject,
.faq .faq-list-name,
.faq .faq-list-date,
.faq .faq-list-hit {
    flex: 1;
    text-align: center;
}

.faq .faq-list-no {
    flex: 0.5; /* 번호 열의 너비를 줄임 */
}

.faq .faq-list-subject {
    text-align: left;
    flex: 3;
}

.pagination-container {
    text-align: center;
    margin-top: 20px;
}

.pagination li {
    display: inline-block;
    margin: 0 5px;
}

.pagination li a {
    display: block;
    padding: 5px 10px;
    border: 1px solid #ddd;
    color: #333;
    text-decoration: none;
}

.pagination li.active a {
    background-color: steelblue;
    color: white;
    border-color: steelblue;
}

.list-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 5px 0;
    background-color: #f9f9f9;
    border-bottom: 1px solid #9a9a9a;
    font-size: 14px;
}

.list-title div {
    flex: 1;
    text-align: center;
}

.list-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 5px 0;
    background-color: #f9f9f9;
    border-bottom: 1px solid #9a9a9a;
    font-size: 14px;
    width: 100%;
}

.list-title .list-no {
    flex: 0 0 10%;
    text-align: center; /* 왼쪽 정렬 */

}
.list-title .list-subject {
    flex: 0 0 90%;
    text-align: center; /* 가운데 정렬 */
}
</style>
</head>
<body>
    <%@ include file="topheader.jsp" %>

    <h2>FAQ</h2>

    <!-- 검색 -->
    <div class="search">
        <input type="text" id="searchInput" placeholder=" 제목을 입력하세요">
        <button id="searchButton">검색</button>
    </div>

    <!-- 탭 -->
    <div class="tab">
        <button class="tablinks" onclick="openTab(event, '전체')" id="defaultOpen">전체</button>
        <button class="tablinks" onclick="openTab(event, '객실')">객실</button>
        <button class="tablinks" onclick="openTab(event, '예약 및 환불')">예약 및 환불</button>
        <button class="tablinks" onclick="openTab(event, '부대시설')">부대시설</button>
        <button class="tablinks" onclick="openTab(event, '기타')">기타</button>
    </div>

    <!-- FAQ 리스트 -->
    <div class="faq-list" id="faqList">
        <!-- 여기에 FAQ 목록이 동적으로 추가됩니다. -->
    </div>

    <!-- 페이징 -->
    <div class="pagination-container">
        <nav aria-label="Page navigation">
            <ul class="pagination" id="pagination"></ul>
        </nav>
    </div>

<script>
var showPage = 1;
var cnt = 10;
var currentCategory = '전체'; // 현재 선택된 탭 카테고리 저장 변수

$(document).ready(function() {
    listCall(1, '전체'); // 초기 페이지 로드

    $('#searchButton').on('click', function() {
        $('#pagination').twbsPagination('destroy'); // 기존 페이징 제거
        var searchText = $('#searchInput').val().trim();
        if (searchText !== '') {
            search(1, searchText); // 검색 시 첫 페이지로 초기화
        } else {
            listCall(showPage, currentCategory); // 검색어 없이 검색 버튼 클릭 시 현재 탭의 리스트 보여주기
        }
    });

    $('#searchInput').on('keydown', function(event) {
        if (event.keyCode === 13) { // Enter 키 누르면 검색 실행
            $('#searchButton').click();
        }
    });

    // 탭 열기 함수
    window.openTab = function(evt, tabName) {
        var i, tablinks;
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        evt.currentTarget.className += " active";
        currentCategory = tabName; // 현재 탭 카테고리 업데이트
        listCall(1, tabName); // 해당 탭의 데이터 로드
    };

    // 기본 탭 설정
    document.getElementById("defaultOpen").click();
});

function listCall(page, category) {
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

function drawFaqList(data) {
    var content = '';
    for (var i = 0; i < data.length; i++) {
        content += '<div class="faq-item">';
        content += '<div><strong>번호: </strong>' + data[i].faq_no + '</div>';
        content += '<div><strong>제목: </strong><a href="/faqDetail.go?faq_no=' + data[i].faq_no + '">' + data[i].faq_subject + '</a></div>';
        content += '</div>';
    }
    $('#faqList').html(content); // FAQ 목록 업데이트
}

function initializePagination(totalPages, category) {
    $('#pagination').twbsPagination({
        totalPages: totalPages,
        visiblePages: 5,
        onPageClick: function(event, page) {
            listCall(page, category);
        }
    });
}


function search(page, title) {
    $.ajax({
        type: 'GET',
        url: '/faq/search.ajax', // 경로 앞에 슬래시 추가
        data: {
            'textval': title,
            'cnt': cnt,
            'page': page
        },
        dataType: 'json',
        success: function(data) {
            console.log('검색');
            drawFaqList(data.list);
            $('#pagination').twbsPagination('destroy'); // 기존 페이징 제거
            initializePagination(data.totalPages, currentCategory); // 검색 결과에 맞는 페이징 초기화
        },
        error: function(error) {
            console.log('검색 실패:', error);
        }
    });
}
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js"></script>
</body>
</html>