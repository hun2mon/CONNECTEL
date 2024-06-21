<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
    display: flex;
    margin: 0;
    height: 100vh;
}
.detail {
    flex-grow: 1;
    padding: 20px;
    overflow-y: auto;
    margin-top: 100px; 
    text-align: center;
    white-space: nowrap;
}

.sidebar-container {
    flex-shrink: 0;
    width: 250px;
    background-color: #f8f9fa;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    overflow-y: auto;
}</style>
</head>
<body>
<!-- 상단 및 사이드 바 기본 -->
<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>

<!-- 디테일 메인 -->
<div class="detail">
		<h2>${dto.FAQ_no}</h2>
		
		<h2>${dto.FAQ_subject}</h2>
		<h2>${dto.FAQ_category}</h2>
		<h2>${dto.FAQ_content}</h2>
<div class="exit">
	<a href="faqList.go">뒤로가기</a>
</div>
</div>

	



</body>
</html>