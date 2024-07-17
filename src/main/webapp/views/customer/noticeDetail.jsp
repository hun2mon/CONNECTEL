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
        background-color: #f5f5f5;
        margin: 0;
        padding: 0;
    }
    .annnoti-container {
        padding: 20px;
        background-color: white;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .detail-table {
        width: 100%;
        border-collapse: collapse;
    }
    .detail-table th {
        text-align: left;
        font-size: 24px;
        padding-bottom: 10px;
        border-bottom: 2px solid #123f67;
        color: #235177;
    }
    .detail-table td {
        padding-top: 10px;
        padding-right: 10px;
        padding-bottom: 10px;
        color: gray;
    }
    .detail-table td:first-child {
        font-weight: bold;
    }
    .detail-table .content {
        padding-top: 20px;
        line-height: 1.6;
        text-align: left;
        vertical-align: top;
    }
    .detail-table img {
        max-width: 100%;
        margin-top: 20px;
        border-radius: 8px;
    }
    .info-row {
        display: flex;
        justify-content: space-between;
        white-space: nowrap;
        width: 50px;
    }
    .buttons {
        margin-top: 20px;
        text-align: right;
    }
    .buttons .exit a {
        text-decoration: none;
        color: #123f67;
        padding: 10px 20px;
        border: 1px solid #123f67;
        border-radius: 4px;
        transition: background-color 0.3s, color 0.3s;
    }
    .buttons .exit a:hover {
        background-color: #123f67;
        color: white;
    }
</style>
</head>
<body>
    <%@ include file="topheader.jsp" %>

    <!-- 메인부분 -->
    <div class="annnoti-container">
        <table class="detail-table">
            <tr>
                <th colspan="3">공지사항</th>
            </tr>
            <tr>
                <td><span style="font-size:28px; color:black;">${dto.ann_subject}</span></td>
                <td colspan="2">
                </td>
            </tr>
            <tr class="info-row">
                <td>작성자 :</td>
                <td>${not empty dto.updater ? dto.updater : dto.register}</td>
                <td>작성일 :</td>
                <td>${not empty dto.update_date ? dto.update_date : dto.ann_date}</td>
                <td>조회수 :</td>
                <td>${dto.ann_bHit}</td>
            </tr>
            <tr style="border-top: 1px solid #f0f0f0;">
                <td colspan="2" class="content" style="height:600px;text-align:center;">
                    ${dto.ann_content}<br>
                    <c:if test="${not empty image}">
                        <img src="/photo/${image}" alt="첨부 이미지">
                    </c:if>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="buttons">
                        <div class="exit">
                            <a href="/customer/customernotice.go"><i class="fas fa-arrow-left"></i> 뒤로가기</a>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>

<script>
   
</script>
</body>
</html>
