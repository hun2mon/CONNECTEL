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
        display: flex;
        flex-direction: column;
        width: 250px;
        background-color: #f8f9fa;
        box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }

 
    .sidebar {
        flex-grow: 1;
        overflow-y: auto;
        padding: 20px;
    }

    .content-body {
        flex-grow: 1;
        padding: 20px;
        overflow-y: auto;
        margin-left: 100px; /* 사이드바의 너비에 맞춰 조정 */
        margin-right: 100px;
        margin-top: 50px; /* 상단 바의 높이에 맞춰 조정 */
    }

    .card {
        margin: 20px 0;
    }

    .text-right {
        text-align: right;
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
                        <div class="compose-content">
                            <form id="emailForm" action="/mail/mail.do" method="post" enctype="multipart/form-data">
                                <div class="form-group">
                                    <input type="text" id="email" class="form-control bg-transparent" name="mail_receiver" placeholder="받는사람">
                                </div>
                                <div class="form-group">
                                    <input type="text" id="subject" class="form-control bg-transparent" name="mail_subject" placeholder="제목">
                                </div>
                                <div class="form-group">
                                    <textarea id="content" class="textarea_editor form-control bg-transparent" rows="15" name="mail_content" placeholder="내용"></textarea>
                                </div>
                                <div class="fallback w-100">
                                    <input type="file" class="dropify" multiple="multiple" name="multipartFiles" />
                                </div>
                                <div class="text-right mt-4 mb-5">
                                    <button class="btn btn-primary btn-sl-sm mr-3" type="submit"><span class="mr-2"><i class="fa fa-paper-plane"></i></span> 전송</button>
                                    <button class="btn btn-dark btn-sl-sm" onclick="temp_save()" type="button"><span class="mr-2"><i
                                                    class="fas fa-archive" aria-hidden="true"></i></span> 임시저장</button>
                                </div>
                            </form>                         
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>    
</body>
<script>
$(document).ready(function() {
    $('#emailForm').on('submit', function(event) {
        var email = $('#email').val().trim();
        var subject = $('#subject').val().trim();
        var content = $('#content').val().trim();
		

        
        if (email ==="") {
        	alert("받는사람을 입력하세요.");
            $('#email').focus();  
            event.preventDefault();
    	} else if (subject === "") {
            alert("제목을 입력하세요.");
            $('#subject').focus();
            event.preventDefault();
        } else if (content === "") {
            alert("내용을 입력하세요.");
            $('#content').focus();
            event.preventDefault();
        }
    });
});

	function temp_save(){
		if (!confirm('임시 저장시 파일 저장은 불가능합니다. 임시저장 하시겠습니까?')) {
	        return; // 사용자가 취소를 선택하면 함수 종료
	    }
		var mail_receiver = $('#email').val();
		var mail_subject = $('#subject').val();
		var mail_content = $('#content').val();
		
		console.log(mail_receiver,mail_subject,mail_content);
		$.ajax({
			type:'POST',
			url:'/mail/mailTempSave.ajax',
			data:{
				mail_receiver:mail_receiver,
				mail_subject:mail_subject,
				mail_content:mail_content
			},
			dataType:'JSON',
			success:function(data){
				location.href='/mail/mailTempSave.go';
			},
			error:function(e){
				console.log(e);
				alert('임시저장에 실패하였습니다.');
			}
			
		});
	}
</script>
</html>
