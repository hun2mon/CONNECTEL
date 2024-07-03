<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>임시저장 완료</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<style>
    body {
        margin: 0;
        padding: 0;
        display: flex;
        height: 100vh;
        overflow: hidden;
    }

    .sidebar-container {
        flex-shrink: 0;
        width: 250px;
        background-color: #f8f9fa;
        box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        overflow-y: auto;
    }

    .sidebar {
        padding: 20px;
    }

    .content-body {
        flex-grow: 1;
        padding: 20px;
        overflow-y: auto;
        margin-top: 50px;
    }

    .card {
        margin: 20px 0;
    }

    .success-message {
        text-align: center;
        margin-top: 200px;
        margin-bottom: 300px;
    }

    .success-icon {
        font-size: 100px;
        color: #28a745;
    }

    .success-text {
        font-size: 24px;
        margin-top: 20px;
    }

    .list-button {
        margin-top: 30px;
    }
</style>
</head>
<body>
<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>

<div class="content-body">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <div class="success-message">
                            <i class="fas fa-save success-icon"></i>
                            <div class="success-text">메일을 임시저장 하였습니다.</div>
                            <a href="/mail/tempMailList.go" class="btn btn-primary list-button">임시보관함 가기</a>
                            <a href="/mail/sendMail.go" class="btn btn-primary list-button">새메일 보내기</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<script></script>
</html>
