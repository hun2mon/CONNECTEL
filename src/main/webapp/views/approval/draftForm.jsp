<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="/assets/extra-libs/datatables.net-bs4/css/dataTables.bootstrap4.css" rel="stylesheet">
<style>
.thWidth{
	width: 10%;
}

td{
	cursor: pointer;
}

</style>
</head>
<body>
<div class="parent">
	<div class="sideBar">
		<jsp:include page="../sideBar.jsp"></jsp:include>
	</div>
	<div class="content">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h2 class="card-title">기안서 양식</h2>
                                <div class="table-responsive">
                                    <table id="zero_config" class="table table-striped table-bordered">
                                        <thead>
                                            <tr>
                                                <th class="thWidth">번호</th>
                                                <th>기안서 양식</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>1</td>
                                                <td><a href="/approval/draftWrite.go">휴가신청서</a></td>
                                            </tr>
                                            <tr>
                                                <td>2</td>
                                                <td><a href="#">인사 정보 변경 신청서</a></td>
                                            </tr>
                                            <tr>
                                                <td>3</td>
                                                <td><a href="#">지출결의서</a></td>
                                            </tr>
                                            <tr>
                                                <td>4</td>
                                                <td><a href="#">경조금 지급 신청서</a></td>
                                            </tr>
                                            <tr>
                                                <td>5</td>
                                                <td><a href="#">사원증 발급 신청서</a></td>
                                            </tr>
                                            <tr>
                                                <td>6</td>
                                                <td><a href="#">사무용품 신청서</a></td>
                                            </tr>
                                            <tr>
                                                <td>7</td>
                                                <td><a href="#">교통비 지출서</a></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
	</div>
</div>
    <script src="/assets/extra-libs/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="/dist/js/pages/datatable/datatable-basic.init.js"></script>
</body>
<script>


	$(".table").DataTable({
		destroy: true,
 		lengthChange: false,    
		ordering: false,    
		info: false,
		paging:false
	})

</script>
</html>