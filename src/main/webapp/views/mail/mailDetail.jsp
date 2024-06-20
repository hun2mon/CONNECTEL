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
                                                        	<!-- 받는사람 -->
                                                            <h5 class="text-primary">Ingredia Nutrisha</h5>
                                                            
                                                            <!-- 날짜 -->
                                                            <p class="mb-0">20 May 2018</p>
                                                        </div>                                                                                                            
                                                         <!-- 삭제 -->
                                                        <a href="javascript:void()" class="text-muted ml-3"><i
                                                                class="fa fa-trash"></i></a>
                                                    </div>
                                                    <hr>
                                                    <div class="media mb-4 mt-5">                                                   
                                               
                                                           <!-- 제목 -->
                                                            <h3 class="my-1 text-primary"> 제목입니다 제목제목제목!!!</h3>
                                                            
                                                    </div>
                                                    </div>
                                                    
                                                    <!-- 메일 내용 -->
                                                    <div class="read-content-body">
                                                      안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다.
                                            안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다.                
                                            안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다.                                                       안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다.
                                            안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다.                                                       안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다.
                                            안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다.                                                       안녕하세요 저는 김진호입니다. 안녕하세요 저는 김진호입니다.
                                                    </div>
                                                    
                                                    <!-- 첨부된 파일 받기 -->
                                                    <div class="read-content-attachment">
                                                        <h6><i class="fa fa-download mb-2"></i>첨부파일
                                                            <span>(3)</span></h6>
                                                        <div class="row attachment">
                                                            <div class="col-auto">
                                                                <a href="javascript:void()" class="text-muted">My-Photo.png</a>
                                                            </div>
                                                            <div class="col-auto">
                                                                <a href="javascript:void()" class="text-muted">My-File.docx</a>
                                                            </div>
                                                            <div class="col-auto">
                                                                <a href="javascript:void()" class="text-muted">My-Resume.pdf</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <hr> 
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