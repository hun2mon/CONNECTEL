<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="/css/jquery-explr-1.4.css" rel="stylesheet" type="text/css">
<style>
</style>
</head>
<body>
	<div class="parent">
		<div class="sidebar">
			<jsp:include page="../sideBar.jsp"></jsp:include>
		</div>
		<div class="content">
		
			<ul id="tree">
				<li class="card2">
				</li>
				<li class="customers">
				</li>
				<li class="config">
				</li>
			</ul>
		</div>
	</div>
</body>
<script src="/js/jquery-explr-1.4.js"></script> 
<script>

treeCall();

function treeCall() {
	$.ajax({
		url:'/treeCall.ajax',
		method:'get',
		data:{},
		dataType:'JSON',
		success:function(data){
			drawTree(data.list);
			console.log(data);
			$("#tree").explr();
		},
		error:function(e){
			console.log(e);
		}
	})
}

function drawTree(list) {
		var card = '<a href="#">인사팀</a><ul>';
		var customer = '<a href="#">고객팀</a><ul>';
		var config = '<a href="#">시설팀</a><ul>';
		
	for(item of list){
		if (item.dept_name == '인사팀') {
			card += '<li class="user"><a href="#">' + item.name +'</a></li>';
		}
		
		if (item.dept_name == '고객팀') {
			customer += '<li class="user"><a href="#">' + item.name +'</a></li>';
		}
		
		if (item.dept_name == '시설팀') {
			config += '<li class="user"><a href="#">' + item.name +'</a></li>';
		}
	}
	
	card += '</ul>';
	customer += '</ul>';
	config += '</ul>';
	
	$('.customers').html(customer);
	$('.card2').html(card);
	$('.config').html(config);
}


</script>
</html>