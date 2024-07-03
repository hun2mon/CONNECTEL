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
    .text-right {
        text-align: right;
    }
    .read-content-body {
        word-wrap: break-word;
        height: 430px;
        margin: 20px;
    }
    .mb-0 {
        margin-top: 20px;
        margin-bottom: 10px;
    }
    .mail-actions {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        margin-bottom: 20px;
    }
    #goList {
        margin-right: 10px;
        color: white;
    }
    #footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    #trash {
        color: #6c757d;
    }
    #reWrite {
        flex-shrink: 0; /* 추가된 부분 */
        width: 100px; /* 원하는 고정 너비 */
        height: 40px; /* 원하는 고정 높이 */
        margin-left: auto; /* 버튼을 오른쪽으로 정렬 */
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
                                    <div class="media-body">                                                        
                                    	<!-- 받는사람 -->
                                        <h5 class="text-primary">수신자 : ${info.mail_receiver}</h5>
                                        
                                        <!-- 날짜 -->
                                        <p class="mb-0">발신 날짜 : ${info.send_date} </p>
                                    </div>                                                                                                            
                                     <!-- 삭제 -->
                                    <div class="mail-actions">
									    <a type="button" id="goList" href="/mail/sendMailList.go" class="btn btn-sm waves-effect waves-light btn-primary">
									        <i class="fa fa-list"></i> 메일 목록
									    </a>
									    <a href="#" onclick="delete_mail(${info.mail_no})" class="text-muted" id="trash">
									        <i class="fa fa-trash"></i>
									    </a>
									</div>
                                <hr>
                                <div class="media mb-4 mt-5">                                                   
                           
                                       <!-- 제목 -->
                                        <h3 class="my-1 text-primary">제목 : ${info.mail_subject} </h3>
                                        
                                </div>
                                </div>
                                
                                <!-- 메일 내용 -->
                                <div class="read-content-body">
                                  ${info.mail_content}
                                </div>
                          
                                </div>
                                
                                <!-- 첨부된 파일 받기 -->
                                <div  id="footer">
                                 <c:if test="${not empty list}">
                                <div class="read-content-attachment">
							    <h6><i class="fa fa-download mb-2"></i>첨부파일
							        <span>(${list.size()})</span></h6>
							    <div class="row attachment">
							        <c:forEach var="file" items="${list}">
							            <div class="col-auto">
							                <a href="/download/${file.file_name}" class="text-muted">${file.ori_file_name}</a>
							            </div>
							        </c:forEach>
							    </div>							   
							</div>
							</c:if>
							 <c:if test="${info.status eq 'T' }">
							    <button class="btn btn-primary btn-sl-sm mr-3" id="reWrite" type="button">재작성</button>
							    </c:if>
							 </div>   
                        </div>
                    </div>
                </div>
            </div>
</body>
<script>
	function delete_mail(mail_no){
		console.log('mail_no : ' + mail_no);
		location.href='/mail/mail_delete.do?mail_no='+mail_no;
	}
</script>
</html>