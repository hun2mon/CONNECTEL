<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최고의 호텔 'The Shilla' 호텔에 오신걸 환영합니다!</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }
    
    .page-item.active .page-link {
    z-index: 3;
    color: #fff;
    background-color: #b76312;
    border-color: #ae520d;
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
        background-color:#9d6314;
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

    .notice {
        margin-bottom: 20px;
        width: 100%;
        border-collapse: collapse;
    }

    .notice .notice-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        border: 1px solid #ddd;
        padding: 10px 0;
        white-space: nowrap; /* 줄 바꿈 방지 */
        overflow: hidden; /* 내용이 넘치면 숨기기 */
        text-overflow: ellipsis; /* 말줄임표 처리 */
    }

    .notice .notice-list-no,
    .notice .notice-list-subject,
    .notice .notice-list-name,
    .notice .notice-list-date,
    .notice .notice-list-hit {
        flex: 1;
        text-align: center;
        
    }

    .notice .notice-list-subject {
        text-align: left;
        flex: 3;
    }

    .notice .ann-notice {
        color: red;
        font-weight: bold;
    }

  .pagination-container {
    text-align: center; /* 페이징 중앙 정렬 */
    margin-top: 20px;
}

.pagination {
    display: inline-block; /* 페이징 중앙 정렬 */
    padding-left: 0;
    list-style: none;
    border-radius: .25rem;
}

.pagination li {
    display: inline-block; /* 각 페이지 번호를 가로로 배열 */
    margin: 0 5px; /* 페이지 번호 간 간격 조정 */
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
    border-top: 1.4px solid #7d3e00;
    padding: 10px 0;
    background-color: #ffe0b6;
    font-weight: bold;
    margin-top: 20px;
    border-bottom: 1px solid #7d3e00;
    color: #7d3e00;
    }

    .list-title div {
        flex: 1;
        text-align: center;
    }

    .list-title .list-subject {
        text-align: left;
        flex: 3;
    }
</style>
</head>
<body>
     <%@ include file="topheader.jsp" %>

    <!-- 메인부분 -->
    <h2 style="margin-top:10px;">공지사항</h2>
    <hr width="50%">
    <!-- 검색 -->
    <div class="search">
        <input type="text" id="searchInput" placeholder=" 제목을 입력하세요">
        <button id="searchButton">검색</button>
    </div>

	<div class="list-title">
		<div class="list-no"><strong>번호</strong></div>
		<div class="list-subject"><strong>제목</strong></div>
		<div class="list-name"><strong>작성자</strong></div>
		<div class="list-date"><strong>작성일</strong></div>
		<div class="list-hit"><strong>조회수</strong></div>
    </div>
    
    <!-- 리스트 -->
    <div class="notice"></div>

    <!-- 페이징 -->
    <div class="pagination-container">
        <nav aria-label="Page navigation">
            <ul class="pagination" id="pagination"></ul>
        </nav>
    </div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js"></script>
<script>
    var showPage = 1;
    var ann_fixed = 'N';
    var ann_division = 'C';
    var register = '';
    var ann_date = '';
    var cnt = 10;

    $(document).ready(function() {
        listCall(showPage);
        
        // 검색 버튼 클릭 이벤트
        $('#searchButton').on('click', function() {
            $('#pagination').twbsPagination('destroy'); // 기존 페이징 제거
            var searchText = $('#searchInput').val().trim();
            if (searchText !== '') {
                search(searchText, 1); // 검색 시 첫 페이지로 초기화
            } else {
                listCall(showPage); // 검색어 없이 검색 버튼 클릭 시 전체 리스트 보여주기
            }
        });
        
        $('#searchInput').on('keydown', function(event) {
            if (event.keyCode === 13) { // Enter 키의 키 코드가 13
                $('#searchButton').click(); // 검색 버튼 클릭 이벤트 트리거
            }
        });
        
        
        // 검색 Ajax
        function search(title, page) {
            $.ajax({
                type: 'GET',
                url: '/customer/noticesearch.ajax',
                data: {
                    'textval': title,
                    'page': page
                },
                dataType: 'json',
                success: function(data) {
                    drawList(data.list);
                    totalPages = data.totalPages;
                    $('#pagination').twbsPagination({
                        totalPages: totalPages,
                        visiblePages: 5,
                        startPage: page,
                        onPageClick: function(event, page) {
                            search(title, page);
                        }
                    });
                },
                error: function(error) {
                    console.log('검색 실패:', error);
                }
            });
        } 
        
        // 리스트 호출 Ajax
        function listCall(page) {
            $.ajax({
                type: 'GET',
                url: '/customer/notice.ajax',
                data: {
                    'page': page,
                    'cnt': cnt,
                    'ann_division': ann_division,
                    'ann_fixed': ann_fixed,
                    'register': register,
                    'ann_date': ann_date
                },
                dataType: 'json',
                success: function(data) {      
                    drawList(data.list);
                    totalPages = data.totalPages;
                    initializePagination(totalPages, page);
                },
                error: function(error) {
                    console.log('리스트 출력 실패:', error);
                }
            });
        }

        // 페이징 초기화
        function initializePagination(totalPages, startPage) {
            $('#pagination').twbsPagination({
                totalPages: totalPages,
                visiblePages: 5,
                startPage: startPage,
                onPageClick: function(event, page) {
                    listCall(page);
                }
            });
        }

        function drawList(data) {
            var content = '';
            for (var i = 0; i < data.length; i++) {
                content += '<div class="notice-item">';
                if (data[i].ann_fixed === 'Y') {
                    content += '<div class="notice-list-no ann-notice">[공지]</div>';
                } else {
                    content += '<div class="notice-list-no" style="">' + data[i].ann_no + '</div>';
                }
                content += '<div class="notice-list-subject"><a style = "color:#7d3e00"href="/customer/noticeDetail.go?ann_no=' + data[i].ann_no + '">' + data[i].ann_subject + '</a></div>';
                
                // updater가 존재할 경우 updater 표시, 그렇지 않으면 register 표시
                var nameToShow = data[i].updater ? data[i].updater : data[i].register;
                content += '<div class="notice-list-name style="color:black">' + nameToShow + '</div>';
                
                // update_date가 존재할 경우 update_date 표시, 그렇지 않으면 ann_date 표시
                var dateToShow = data[i].update_date ? data[i].update_date : data[i].ann_date;
                content += '<div class="notice-list-date">' + dateToShow + '</div>';
                
                content += '<div class="notice-list-hit">' + data[i].ann_bHit + '</div>';
                content += '</div>';
            }
            $('.notice').html(content); // '.notice' 클래스로 데이터를 출력하도록 수정
        }
    });
</script>
</body>
</html>	