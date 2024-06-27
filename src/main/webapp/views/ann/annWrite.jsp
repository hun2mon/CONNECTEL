<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

.write-container {
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
}

table th, table td {
    padding: 15px; /* 셀 안 여백 */
    text-align: left; /* 텍스트 왼쪽 정렬 */
}

table th {
    border-bottom: 1px solid #f0f0f0; /* 셀 아래 테두리 */
    color: ffffff;

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
    height: 200px; /* 높이 지정 */
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
margin-top: -30px;
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
    text-align: right;
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




</style>
</head>
<body>
<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>

<div class="write-container">
    <form id="annForm" action="/annwrite.do" method="post" enctype="multipart/form-data">
        <table>
            <tr>
                <th colspan="3" style="background-color:#6076E8; color:white;">
                    공지사항 글쓰기
                </th>
            </tr>
            <tr>
                <th>
                    <input type="text" class="ann_subject" id="ann_subject" name="ann_subject" 
                           placeholder="제목을 입력해주세요." value="${ann_subject}" required>
                </th>
                <td>
                    <select id="ann_division" name="ann_division">
                        <option value="C" ${ann_division == 'C' ? 'selected' : ''}>고객 공지사항</option>
                        <option value="E" ${ann_division == 'E' ? 'selected' : ''}>직원 공지사항</option>
                    </select>
                </td>
                <td>
                    <select id="ann_fixed" name="ann_fixed">
                        <option value="N" ${ann_fixed == 'N' ? 'selected' : ''}>[일반]</option>
                        <option value="Y" ${ann_fixed == 'Y' ? 'selected' : ''}>[상단고정]</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <input type="text" class="textcontent" id="textcontent" name="textcontent" 
                           placeholder="내용을 입력해 주세요" value="${textcontent}" required>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    첨부파일 : <input type="file" name="photos"/>
                </td>    
                <td style="text-align:right; padding-right:30px;">작성자:${name}</td>
            </tr>            
            <tr>
                <td colspan="3">
                    <div class="exit">
                        <a href="ann/annList.go"><i class="fas fa-arrow-left"></i> 뒤로가기</a>
                    </div>
                    <input type="submit" value="등록"> 
                </td>
            </tr>
        </table>
    </form>
</div>

<c:if test="${not empty error}">
    <script>
        alert("${error}");
    </script>
</c:if>
</body>
<script>
</script>
</html>