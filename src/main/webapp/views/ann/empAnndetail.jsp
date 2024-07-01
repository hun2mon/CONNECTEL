<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세 보기</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
body {
    display: flex;
    margin: 0;
    height: 100vh;
    font-family: 'Arial', sans-serif;
    background-color: #f8f9fa;
}

.sidebar-container {
    flex-shrink: 0;
    width: 250px;
    background-color: #f8f9fa;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    overflow-y: auto;
}

.annnoti-container {
    flex-grow: 1;
    overflow-y: auto;
    margin-top: 100px;
    text-align: right;
}

.detail-table {
	white-space: nowrap;	
    margin: 0 auto;
    border-collapse: collapse;
    width: 100%;
   	max-width: 1400px;
    background-color: #ffffff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

table th, table td {
    padding: 15px;
    text-align: right;
    border-bottom: 1px solid #f0f0f0;
}

table th {
    background-color: #6076E8;
    color: white;
    font-weight: bold;
}

.buttons {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}

.buttons .exit a,
.buttons .update button {
    background-color: #f8f9fa;
    padding: 10px 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    color: #6076E8;
    transition: background-color 0.3s, color 0.3s;
    cursor: pointer;
    font-size: 16px;
    text-decoration: none;
}

.buttons .exit a:hover,
.buttons .update button:hover {
    background-color: #6076E8;
    color: white;
}

.title-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.title {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 10px;
}

.category {
    font-size: 16px;
    color: #999;
}

.content {
    margin-top: 20px;
    white-space: pre-wrap;
    padding-bottom: 400px;
    text-align:left;
}

.image-container {
    margin-top: 20px;
}

.image-container img {
    max-width: 100%;
    height: auto;


}
</style>
</head>
<body>

<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>

<div class="annnoti-container">
    <table class="detail-table">
        <tr>
            <th colspan="3" style= "text-align :left; ">
                공지사항_
            </th>
        </tr>
        <tr>
    		<td>작성자 :</td>
  			<td style="text-align: left;">${not empty dto.updater ? dto.updater : dto.register}</td>
    		<td style="text-align: right; border-bottom: 1px solid #f0f0f0;"> 작성일 : ${not empty dto.update_date ? dto.update_date : dto.ann_date}</td>
		</tr>
		<tr>
        	 <td>제목 : </td>
            <td style="color:#737371; text-align: left; font-size:20px;">
                ${dto.ann_subject}
            </td>
            <td style="border-bottom: 1px solid #f0f0f0">조회수 :  ${dto.ann_bHit}</td>
        </tr>

        <tr>
            <td>내용</td>
            <td colspan="3" class="content">${dto.ann_content}<br><c:if test="${not empty image}"><img src="/photo/${image}" alt="첨부 이미지" style="max-width:800px;"> </c:if></td>
        </tr>
         <tr>
        	 <td>첨부파일</td>
   			 <td colspan="3" class="file">
        	 	<c:if test="${not empty file}">
            		<a href="/download/${file}" target="_blank">${file}</a>
        		</c:if>
    		</td>
        </tr>
        <tr>
            <td colspan="3">
                <div class="buttons">
                    <div class="exit">
                        <a href="ann/empAnnList.go"><i class="fas fa-arrow-left"></i> 뒤로가기</a>
                    </div>
                    <div class="update">
                        <button onclick="location.href='/empannupdate.go?ann_no=${dto.ann_no}'">수정</button>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</div>

</body>
</html>