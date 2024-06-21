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
        flex-shrink: 0; /* 변경: flex-grow를 0으로 설정 */
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
        margin-top: 50px; /* 상단 바의 높이에 맞춰 조정 */
    }

    .card {
        margin: 20px 0;
    }

    .text-right {
        text-align: right;
    }

    .read-content-body {
       
        word-wrap: break-word; /* 글자가 div 영역을 넘어갈 경우 줄 바꿈 처리 */
 
    }

    .read-content-body p {
        margin-bottom: 10px; /* 문단 간격 설정 */
    }
    
       .form-group {
            display: flex;
            gap: 10px; /* 인풋 간의 간격 조정 */
        }
        .form-control {
            flex: 1; /* 인풋의 크기를 균등하게 */
        }
</style>
</head>
<body>
<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>

<div class="content-body">

            <div class="container-fluid">               
                <!-- row -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">                              
                                <div class="email-right-box ml-0 ml-sm-4 ml-sm-0">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="right-box-padding">                                             
                                                <div class="read-content">
                                                    <div class="media pt-3">                                                 
                                                        <div class="media-body">                                                        
                                                        	<form action="#" method="post" enctype="multipart/form-data">								                                
								                                <div class="form-group">
								                                    <input type="text" class="form-control bg-transparent" name="room" readonly="readonly" placeholder="객실호수">
								                                    <input type="text" class="form-control bg-transparent" name="room" readonly="readonly" placeholder="작성자">
								                                      <input type="text" class="form-control bg-transparent" name="room" readonly="readonly" placeholder="날짜">
								                                    <input type="text" class="form-control bg-transparent" name="room" readonly="readonly" placeholder="상태">
								                                </div>
								                                <div class="form-group">
								                                    <textarea id="email-compose-editor" class="textarea_editor form-control bg-transparent" rows="15" name="content" readonly="readonly"></textarea>
								                                </div>								                               
								                                <div class="text-right mt-4 mb-5">
								                                    <button class="btn btn-primary btn-sl-sm mr-3" type="submit"><span class="mr-2"><i class="fas fa-share-square"></i></span>등록 </button>								                        
								                                </div>
								                            </form>
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
                </div>
            </div>

</body>
<script>

</script>
</html>