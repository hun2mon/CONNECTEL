<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최고의 호텔 'The Shilla' 호텔에 오신걸 환영합니다!</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/topheader.css'/>">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
}
.btn-inpo.active {
    background-color: white;
    color: black;
    border: none;
}

.btn-inpo:focus {
    /* color: #fff; */
    /* background-color: #138496; */
    /* border-color: #117a8b; */
    box-shadow: none
}
.btn-inpo a.active{
	background-color: white;
	color: black;
	border: none;
}

.btn-inpo{
    background-color: white;
    color: #7d3e00;
    border: none;
}

.btn-inpo:hover {
    background-color: white;
    color: #7d3e00;
    border:none;
    text-decoration:none;
}

.collapse.active {
    background-color: white;
    color: #7d3e00;
    border: none;
}

.collapse a.active{
	background-color: white;
	color: #7d3e00;
	border: none;
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
    background-color: #ffefbe;
    text-align: center;
}

button {
    background-color: #9d6314;
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
    background-color: #673d05; /* 마우스 오버 시 배경색 변화 */
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
    background-color: #a9680d;
    margin-top: 20px;
    font-size: 24px;
}

.tab button {
    background-color: #a9680d;
    float: left;
    border: none;
    outline: none;
    cursor: pointer;
    padding: 10px 20px;
    transition: 0.3s;
    font-size: 15px;
}

.tab button:hover {
    background-color:#825111;
}

.tab button.active {
    background-color: #825111;
}

.faq-list {
    width: 100%;
    margin: 10px auto;
    margin-top: 0px;
    border-collapse: collapse;
}

.faq-list th, .faq-list td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: center;
}

.faq-list th {
    background-color: #ffe0b6;
}

.page-item.active .page-link {
    z-index: 3;
    color: #fff;
    background-color: #b76312;
    border-color: #ae520d;
}

.pagination-container {
    margin-top: 20px;
    text-align:center;
}

.pagination {
    display: inline-block; /* 페이징 중앙 정렬 */
    padding-left: 0;
    list-style: none;
    border-radius: .25rem;
}

.pagination li {
    display: inline-block; /* 한 줄로 정렬 */
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
</style>
</head>
<body>
    <%@ include file="topheader.jsp" %>

    <h2 style="margin-top:10px;">FAQ</h2>
    <hr width="50%">

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
    <table class="faq-list">
        <thead>
            <tr>
                <th style="width: 5%; color:#a9680d;">번호</th>
                <th style="width: 80%; color:#a9680d;">제목</th>
            </tr>
        </thead>
        <tbody id="faqList">
            <!-- 여기에 FAQ 목록이 동적으로 추가됩니다. -->
        </tbody>
    </table>
   
    <!-- 페이징 -->
    <div class="pagination-container">
        <nav aria-label="Page navigation">
            <ul class="pagination" id="pagination"></ul>
        </nav>
    </div>

<script>
var showPage = 1;
var cnt = 10;

$(document).ready(function() {
    listCall(1, '전체'); // 초기 페이지 로드

    $('#searchButton').on('click', function() {
        $('#pagination').twbsPagination('destroy'); // 기존 페이징 제거
        var searchText = $('#searchInput').val().trim();
        if (searchText !== '') {
            search(1, searchText); // 검색 시 첫 페이지로 초기화
        } else {
            listCall(showPage, '전체'); // 검색어 없이 검색 버튼 클릭 시 현재 탭의 리스트 보여주기
        }
    });

    $('#searchInput').on('keydown', function(event) {
        if (event.keyCode === 13) { // Enter 키 누르면 검색 실행
            $('#searchButton').click();
        }
    });

    $(document).on('click', '.faq-item .btn-inpo', function() {
        $('.collapse').collapse('hide'); // 모든 FAQ 항목을 닫음
        $('.btn-inpo').removeClass('active'); // 모든 버튼의 active 클래스 제거
        $(this).addClass('active'); // 클릭된 버튼에 active 클래스 추가
        $($(this).attr('href')).collapse('show'); // 클릭한 항목을 엶
    });

    // 기본 탭 설정
    document.getElementById("defaultOpen").click();

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
            var faqId = 'collapse' + i; // 고유 ID 생성
            content += '<tr class="faq-item">';
            content += '<td style= "color:#a9680d;">' + data[i].row_num + '</td>';
            content += '<td><a class="btn-inpo" data-toggle="collapse" href="#' + faqId + '" aria-expanded="false" aria-controls="' + faqId + '">' + data[i].faq_subject + '</a></td>';
            content += '</tr>';
            content += '<tr class="collapse" style="text-align:left" id="' + faqId + '"><td colspan="2" style="text-align:left;">' + data[i].faq_content + '</td></tr>';
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
                $('#pagination').twbsPagination({
                    totalPages: data.totalPages,
                    visiblePages: 5,
                    onPageClick: function(event, page) {
                        search(page, title);
                    }
                });
            },
            error: function(error) {
                console.log('검색 실패:', error);
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
    };
    document.getElementById("defaultOpen").click();
});
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js"></script>
</body>
</html>