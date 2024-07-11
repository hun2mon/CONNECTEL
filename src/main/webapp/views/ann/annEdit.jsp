<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
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

.edit-container {
    flex-grow: 1;
    padding: 20px;
    overflow-y: auto;
    margin-top: 100px; 
    text-align: center;
}

table {
    margin: 0 auto; /* 가운데 정렬 */
    border-collapse: collapse; /* 테이블 간격 없애기 */
    width: 1000px; /* 테이블 너비 지정 */
    background-color: #ffffff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    border-radius: 8px; /* 모서리 둥글게 */
        white-space: nowrap;
}

table th, table td {
    padding: 15px; /* 셀 안 여백 */
    text-align: left; /* 텍스트 왼쪽 정렬 */
}

table th {
    border-bottom: 1px solid #f0f0f0; /* 셀 아래 테두리 */
    background-color: #6076E8; /* 배경색 */
    color: white; /* 글자색 */
    font-weight: bold; /* 글자 굵기 */
}

table td {
    border-bottom: 1px solid #f0f0f0; /* 셀 아래 테두리 */
}

table tr:last-child td {
    border-bottom: none; /* 마지막 행의 아래 테두리 없애기 */
}

.ann_subject {
    width: 100%; /* 너비 100%로 채우기 */
    padding: 10px; /* 내부 여백 */
    border: 1px solid #ccc; /* 테두리 */
    border-radius: 4px; /* 모서리 둥글게 */
    box-sizing: border-box; /* 테두리와 안쪽 여백 포함 */
    font-size: 16px; /* 글자 크기 */
}

.textcontent {
    width: 100%; /* 너비 100%로 채우기 */
    padding: 10px; /* 내부 여백 */
    border: 1px solid #ccc; /* 테두리 */
    border-radius: 4px; /* 모서리 둥글게 */
    box-sizing: border-box; /* 테두리와 안쪽 여백 포함 */
    font-size: 16px; /* 글자 크기 */
    height: 600px; /* 높이 지정 */
}

select {
    width: 100%; /* 너비 100%로 채우기 */
    padding: 10px; /* 내부 여백 */
    border: 1px solid #ccc; /* 테두리 */
    border-radius: 4px; /* 모서리 둥글게 */
    box-sizing: border-box; /* 테두리와 안쪽 여백 포함 */
    font-size: 16px; /* 글자 크기 */
}

input[type="submit"] {
    margin-top: 20px; /* 위쪽 여백 */
    background-color: #6076E8; /* 배경색 */
    color: white; /* 글자색 */
    padding: 10px 20px; /* 내부 여백 */
    border: none; /* 테두리 없음 */
    border-radius: 4px; /* 모서리 둥글게 */
    cursor: pointer; /* 커서 포인터 */
    font-size: 16px; /* 글자 크기 */
    transition: background-color 0.3s; /* 배경색 변경 애니메이션 */
}

input[type="submit"]:hover {
    background-color: #4056A1; /* 마우스 호버 시 배경색 변경 */
}

a {
    text-decoration: none; /* 링크 밑줄 제거 */
    color: #6076E8; /* 링크 색상 */
    font-size: 16px; /* 글자 크기 */
    transition: color 0.3s; /* 색상 변경 애니메이션 */
}

a:hover {
    color: #4056A1; /* 마우스 호버 시 링크 색상 변경 */
}

.exit {
    text-align: left;
    margin-top: 20px;
}

.exit a {
    background-color: #f8f9fa;
    padding: 10px 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    color: #6076E8;
    transition: background-color 0.3s, color 0.3s;
}

.exit a:hover {
    background-color: #6076E8;
    color: white;
}
.image-container{
display:flex;
justify-content: space-between;
}

</style>
</head>
<body>
<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>

<div class="edit-container">
    <form id="annForm" action="/annupdate.do" method="post" enctype="multipart/form-data">
        <table>
            <tr>
                <th colspan="3">
                    공지사항 수정
                </th>
            </tr>
            <tr>
                <td>번호</td>
                <td colspan="2">
                    <input type="hidden" id="ann_no" name="ann_no" value="${dto.ann_no}">
                    ${dto.ann_no}
                </td>
            </tr>
            <tr>
                <td>제목</td>
                <td colspan="2">
                    <input type="text" class="ann_subject" id="ann_subject" name="ann_subject" 
                           placeholder="제목을 입력해주세요." value="${dto.ann_subject}" required>
                </td>
            </tr>
            <tr>
                <td>내용</td>
                <td colspan="2">
                    <input type="text" class="textcontent" id="ann_content" name="ann_content" 
                           placeholder="내용을 입력해 주세요" value="${dto.ann_content}" required>
                </td>
            </tr>
            <tr>
                <td>기존 사진</td>
                <td>
                    <c:if test="${not empty image}">
                        <div class="image-container" id="image-container">
                            <img src="/photo/${image}" alt="첨부 이미지" style="max-width:800px;" id="existing-photo">
                        </div>
                    </c:if>
                    <c:if test="${empty image}">
                        <div class="image-container">
                            <p>기존 사진 없음</p>
                        </div>
                    </c:if>
                </td>
                <td style="text-align:right; padding-right:40px;">
                         <button type="button" style=" background-color: #f8f9fa;
    padding: 10px 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    color: gray;
    transition: background-color 0.3s, color 0.3s;" onclick="photodelete('${dto.ann_no}')"> 삭제 </button>                
                </td>
            </tr>
            <tr>
                <td>기존 파일</td>
                <td>
                    <c:if test="${not empty file}">
                    <div class="file-container" id="file-container">
                        <a href="/download/${file}" target="_blank">${file}</a>
                    </div>
                    </c:if>
                    <c:if test="${empty file}">
                        <p>기존 파일 없음</p>
                    </c:if>
                </td>
                <td style="text-align:right; padding-right:40px;">
                         <button type="button" style=" background-color: #f8f9fa;
    padding: 10px 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    color: gray;
    transition: background-color 0.3s, color 0.3s;" onclick="filedelete('${dto.ann_no}')"> 삭제 </button>                
                </td>
            </tr>
            <tr>
                <td>새 사진 업로드</td>
                <td colspan="2">
                    <input type="file" name="new_photo">
                </td>
            </tr>
            <tr>
                <td>새 첨부파일 업로드</td>
                <td colspan="2">
                    <input type="file" name="new_file">
                </td>
            </tr>
            <tr>
                <td colspan="">
                    <div class="exit">
                          <a href="/annDetail.go?ann_no=${dto.ann_no}"><i class="fas fa-arrow-left"></i> 뒤로가기</a>
                    </div>
                </td>
                <td></td>
                <td style="text-align:right;">
                        <input type="submit" value="저장">                
                </td>
            </tr>
        </table>
    </form>
</div>

<script>
    function photodelete(ann_no){
        $.ajax({
            type: 'POST',
            url: '/ann/editdeletephoto.ajax',
            data: {
                'ann_no': ann_no
            },
            dataType: 'json',
            success: function(response) {
                console.log('삭제 성공:', response);
                // 삭제 성공 시 이미지를 DOM에서 제거
                $('#existing-photo').remove();
                $('#image-container').append('<p>기존 사진 없음</p>');
            },
            error: function(error) {
                console.log('삭제 실패:', error);
            }
        });
    }

    $(document).ready(function() {
        $('button[type="button"]').on('click', function(event) {
            event.preventDefault(); // 기본 동작 방지
        });
    });
    
    
    function filedelete(ann_no){
        $.ajax({
            type: 'POST',
            url: '/ann/editdeletefile.ajax',
            data: {
                'ann_no': ann_no
            },
            dataType: 'json',
            success: function(response) {
                console.log('삭제 성공:', response);
                $('#existing-file').remove();
                $('#file-container').append('<p>기존 사진 없음</p>');
            },
            error: function(error) {
                console.log('삭제 실패:', error);
            }
        });
    }

    $(document).ready(function() {
        $('button[type="button"]').on('click', function(event) {
            event.preventDefault(); // 기본 동작 방지
        });
    });
    
</script>
</body>
</html>