<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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

    .text-right {
        text-align: right;
    }

    .read-content-body {
        word-wrap: break-word;
    }

    .read-content-body p {
        margin-bottom: 10px;
    }

    .floor {
        margin-bottom: 20px;
    }

    .room-row {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        margin-bottom: 10px;
    }

    .room {
   		flex: 1 1 calc(10% - 4px);
        display: inline-block;
        aspect-ratio: 1;
        width: 80px;
        height: 80px;
        border: 1px solid black;
        margin: 2px;
        text-align: center;
        line-height: 80px;
    }

    .occupied {
        background-color: red;
    }

    .available {
        background-color: green;
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
                        <div class="email-right-box ml-0 ml-sm-4 ml-sm-0">
                            <div class="row">
                                <div class="col-12">
                                    <div class="right-box-padding">                                             
                                        <div class="read-content">
                                            <!-- 3층부터 7층까지의 객실 UI 생성 -->
                                            <%
                                                for (int floor = 3; floor <= 7; floor++) {
                                                    out.print("<div class='floor' id='floor-" + floor + "'>");
                                                    out.print("<h2>" + floor + "층</h2>");
                                                    for (int row = 0; row < 2; row++) {
                                                        out.print("<div class='room-row'>");
                                                        for (int room = 1 + row * 10; room <= 10 + row * 10; room++) {
                                                            int roomNumber = floor * 100 + room;
                                                            out.print("<div class='room available' id='room-" + roomNumber + "'>" + roomNumber + "</div>");
                                                        }
                                                        out.print("</div>");
                                                    }
                                                    out.print("</div>");
                                                }
                                            %>
                                        </div>
                                    </div>                                             
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
	$(document).ready(function(){ // html 문서가 모두 읽히면 되면(준비되면) 다음 내용을 실행 해라    
	    listCall();   
	 });
	
	function listCall() {
		$.ajax({
			type:'get',
			url:'/room/liveRoomManage.ajax',
			data:{},
			dataType:'json',
			success:function(data){
				console.log(data.list);
				
			},
			error:function(e){
				console.log(e);
			}
		})
	}
	
	
</script>
</html>