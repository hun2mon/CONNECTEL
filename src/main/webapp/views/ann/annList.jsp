<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>고객 공지사항</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
body {
    display: flex;
    margin: 0;
    height: 100vh;
}
.ann-notice{
	color: red;
}



.sidebar-container {
    flex-shrink: 0;
    width: 250px;
    background-color: #f8f9fa;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    overflow-y: auto;
}

.commonstext {
    flex-grow: 1;
    padding: 20px;
    overflow-y: auto;
    margin-top: 100px;
}

.title {
    text-align: center;
    margin-bottom: 20px;
}

.search-container {
    position: relative; /* absolute positioning을 위해 부모 요소에 position: relative 추가 */
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}

.nav-right {
    display: flex;
    align-items: center;
}

.unfix-container {
    position: absolute;
    right: 0;
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

.freetextbox {
    border: 2px solid #6076E8;
    border-radius: 4px;
    padding: 3px;
    font-size: 14px;
    color: #333;
    outline: none;
    width: 30vh;
    margin-right: 15px;
}

.freetextbox {
    border: 2px solid #6076E8; 
    border-radius: 4px; 
    padding: 3px; 
    font-size: 14px; 
    color: #333;
    outline: none; 
    width: 30vh;
    margin-right: 15px;
}

.freetextbox:focus {
    border-color: #4056A1;
}

#freebutton {
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

#freebutton:hover {
    background-color: #4056A1;
}

.list-title, .ann-list {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 10px 0;
    padding: 10px 0;
    border-bottom: 1px solid #ccc;
}

.list-title div {
    flex-basis: 16.67%; /* 각 항목이 6개이므로 100%를 6으로 나눈 값 */
    text-align: center;
    font-weight: bold;
}

.ann-list {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 10px 0;
    padding: 10px 0;
    border-bottom: 1px solid #f0f0f0;
}

.ann-list-no, .ann-list-subject, .ann-list-name, .ann-list-date, .ann-list-hit, .ann-list-check {
    flex-basis: 16.67%; /* 각 항목이 6개이므로 100%를 6으로 나눈 값 */
    text-align: center;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.ann-list-subject {
    flex-grow: 1;
    text-align: left;
    padding-left: 20px;
}

.ann-list-check {
    display: flex;
    justify-content: center;
    align-items: center;
}

.freecheckbox {
    margin-left: 5px; /* 체크박스와 텍스트 사이 여백 설정 */
}

.pagination {
    margin-top: 10px;
    margin-bottom: 10px;
    display: flex;
    justify-content: center;
}
</style>
</head>
<body>
<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>

<div class="commonstext">
    <div class="title">
        <h2>- 고객 공지사항 -</h2>
    </div>
<div class="search-container">
    <input type="text" class="freetextbox" id="freetextbox" placeholder=" 제목을 입력해주세요.">
    <button id="freebutton">검색</button>
    
    
    <span class="unfix-container">
        <button id="writebutton" onclick="writeAnn()">글쓰기</button>
        <button id="deletebutton" style="margin-left: 5px; margin-right:20px">삭제</button>
        <button id="unfixbutton">고정상태변경</button>
    </span>
</div>

    <div class="annContent">
        <div class="list-title"style="background-color:#6076E8; color:white;">
            <div class="list-no"><strong>번호</strong></div>
            <div class="list-subject"><strong>제목</strong></div>
            <div class="list-name"><strong>작성자</strong></div>
            <div class="list-date"><strong>작성일</strong></div>
            <div class="list-hit"><strong>조회수</strong></div>
            <div class="list-check"><strong>선택</strong></div>
        </div>
    </div>
    <div id="list"></div>
    
    <div class="pagination">
        <nav aria-label="Page navigation" style="text-align:center">
            <ul class="pagination" id="pagination"></ul>
        </nav>
    </div>
</div>
<hr>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js"></script>
<script>
var showPage = 1;
var ann_fixed = 'N';
var ann_division = 'C';
var register = '';
var ann_date = '';
var cnt = 10;
var totalPages = 1;

$(document).ready(function() {
    // 초기 페이지 로드
    listCall(showPage);

    // 검색 버튼 클릭 이벤트
    $('#freebutton').on('click', function() {
    	$('#pagination').twbsPagination('destroy'); // 기존 페이징 제거
        var searchText = $('#freetextbox').val().trim();
        if (searchText !== '') {
            search(searchText, 1); // 검색 시 첫 페이지로 초기화
        } else {
            listCall(showPage); // 검색어 없이 검색 버튼 클릭 시 전체 리스트 보여주기
        }
    });

    // 리스트 호출 함수
    function listCall(page) {
        $.ajax({
            type: 'GET',
            url: '/ann/annList.ajax',
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

    // 검색 함수
   function search(title, page) {
    	
        $.ajax({
            type: 'GET',
            url: '/ann/annsearch.ajax',
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
                        search(title,page);
                    }
                });
            },
            error: function(error) {
                console.log('검색 실패:', error);
            }
        });
    }

    // 페이징 초기화 함수
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

    // 리스트 그리기 함수
    function drawList(data) {
        var content = '';
        for (var i = 0; i < data.length; i++) {
            content += '<div class="ann-list">';
            if (data[i].ann_fixed === 'Y') {
                content += '<div class="ann-list-no ann-notice">[공지]</div>';
            } else {
                content += '<div class="ann-list-no">' + data[i].ann_no + '</div>';
            }
            content += '<div class="ann-list-subject"><a href="/annDetail.go?ann_no=' + data[i].ann_no + '">' + data[i].ann_subject + '</a></div>';
            content += '<div class="ann-list-name">' + data[i].register + '</div>';
            content += '<div class="ann-list-date">' + data[i].ann_date + '</div>';
            content += '<div class="ann-list-hit">' + data[i].ann_bHit + '</div>';
            content += '<div class="ann-list-check"><input type="checkbox" class="freecheckbox" id="checkbox_' + data[i].ann_no + '"></div>';
            content += '</div>';
        }
        $('#list').html(content);
    }


    // 삭제 버튼 클릭 이벤트
    $('#deletebutton').click(function() {
        var checkedItems = $('.freecheckbox:checked');
        var annNos = checkedItems.map(function() {
            return parseInt($(this).attr('id').split('_')[1]);
        }).get();
        
        if (annNos.length > 0) {
            $.ajax({
                type: 'POST',
                url: '/ann/deleteann.ajax',
                contentType: 'application/json',
                data: JSON.stringify(annNos),
                success: function(response) {
                    console.log('삭제 성공:', response);
                    alert('삭제에 성공하였습니다.');
                    listCall(1);
                },
                error: function(error) {
                    console.log('삭제 실패:', error);
                    alert('삭제 중 오류가 발생했습니다.');
                }
            });
        } else {
            alert('삭제할 공지사항을 선택해주세요.');
        }
    });

    // 고정상태 변경 버튼 클릭 이벤트
    $('#unfixbutton').click(function() {
        $.ajax({
            type: 'GET',
            url: '/ann/fixedCount.ajax',
            success: function(response) {
                var currentFixedCount = response.fixedCount;
                var checkedItems = $('.freecheckbox:checked');
                var annNos = [];
                var willBeFixedCount = currentFixedCount;
                checkedItems.each(function() {
                    var annNo = $(this).attr('id').split('_')[1];
                    annNos.push(parseInt(annNo));
                    var isFixed = $(this).closest('.ann-list').find('.ann-list-no').hasClass('ann-notice');
                    if (isFixed) {
                        willBeFixedCount--;
                    } else {
                        willBeFixedCount++;
                    }
                });
                if (currentFixedCount >= 5 && willBeFixedCount > currentFixedCount) {
                    alert('상단 고정된 공지사항이 5개 이상이 될 수 없습니다.');
                    return;
                }
                if (annNos.length > 0) {
                    $.ajax({
                        type: 'POST',
                        url: '/ann/unfixann.ajax',
                        contentType: 'application/json',
                        data: JSON.stringify(annNos),
                        success: function(response) {
                            if (response === 'success') {
                                alert('상단 고정 상태 변경에 성공하였습니다.');
                                listCall(1);
                            } else {
                                alert('상단 고정 상태 변경에 실패하였습니다.');
                            }
                        },
                        error: function(error) {
                            console.log('상단 고정 해제 실패:', error);
                            alert('상단 고정 상태 변경 중 오류가 발생했습니다.');
                        }
                    });
                } else {
                    alert('상단 고정 상태 변경할 공지사항을 선택해주세요.');
                }
            },
            error: function(error) {
                console.log('현재 고정된 공지사항 개수 확인 실패:', error);
            }
        });
    });

    // 글쓰기 버튼 클릭 이벤트
    $('#writebutton').click(function() {
        window.location.href = '/annwrite.go';
    });
});
</script>
</body>
</html>