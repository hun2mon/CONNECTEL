<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link href="/dist/css/style.min.css" rel="stylesheet">
<style>

</style>
</head>
<body>
<div class="main-wrapper">
        <!-- ============================================================== -->
        <!-- Preloader - style you can find in spinners.css -->
        <!-- ============================================================== -->
        <div class="preloader">
            <div class="lds-ripple">
                <div class="lds-pos"></div>
                <div class="lds-pos"></div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- Preloader - style you can find in spinners.css -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Login box.scss -->
        <!-- ============================================================== -->
        <div class="auth-wrapper d-flex no-block justify-content-center align-items-center position-relative"
            style="background:url(/assets/images/big/auth-bg.jpg) no-repeat center center;">
            <div class="auth-box row">
                <div class="col-lg-7 col-md-5 modal-bg-img" style="background-image: url(/assets/images/hotel.png);">
                </div>
                <div class="col-lg-5 col-md-7 bg-white">
                    <div class="p-3">
                        <div class="text-center">
                            <img src="/assets/images/CONNECTEL-logo.png" alt="wrapkit" style="width: 200px">
                        </div>
                        <form class="mt-4" action="/login.do" method="post">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label class="text-dark" for="uname">아이디</label>
                                        <input class="form-control" id="uname" type="text" name="id"
                                            placeholder="아이디를 입력해 주세요.">
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <label class="text-dark" for="pwd">비밀번호</label>
                                        <input class="form-control" id="pwd" type="password" name="pw"
                                            placeholder="비밀번호를 입력해 주세요.">
                                    </div>
                                </div>
                                <div class="custom-control custom-checkbox mr-sm-2">
									<input type="checkbox" class="custom-control-input" id="saveId">
									<label class="custom-control-label" for="checkbox1">아이디 저장</label>
                                </div>
                                <div class="col-lg-12 text-center">
                                   	<input type="button" class="btn btn-block btn-dark" onclick="loginCheck()" value="로그인">
                                </div>
                            </div>
                        </form>
                    </div>
<!--                     <form action="join.do" method="post">
		<p>비밀번호 <input type="text" name="pw"></p>

		<p><button>회원가입</button></p>
	</form> -->
                </div>
            </div>
        </div>
    </div>
</body>
<script src="/assets/libs/jquery/dist/jquery.min.js "></script>
<script src="/assets/libs/popper.js/dist/umd/popper.min.js "></script>
<script src="/assets/libs/bootstrap/dist/js/bootstrap.min.js "></script>
<script>
	$(".preloader ").fadeOut();
	
	function loginCheck() {
		if ($('#uname').val() == '') {
			alert('아이디를 입력해 주세요.');
		} else if($('#pwd').val() == ''){
			alert('비밀번호를 입력해 주세요.');
		} else {
			$('form').submit();
		}
	}
	
	$(document).ready(function(){
		  
	     
	    var key = getCookie("key");
	    $("#uname").val(key); 
	      
	    if($("#uname").val() != ""){
	        $("#saveId").attr("checked", true); 
	    }
	      
	    $("#saveId").change(function(){ 
	        if($("#saveId").is(":checked")){ 
	            setCookie("key", $("#uname").val(), 7); 
	        }else{ 
	            deleteCookie("key");
	        }
	    });
	      
	    
	    $("#uname").keyup(function(){ 
	        if($("#saveId").is(":checked")){ 
	            setCookie("key", $("#uname").val(), 7); 
	        }
	    });
	});
	  
	function setCookie(cookieName, value, exdays){
	    var exdate = new Date();
	    exdate.setDate(exdate.getDate() + exdays);
	    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	    document.cookie = cookieName + "=" + cookieValue;
	}
	  
	function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	  
	function getCookie(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1)end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	}
	
	
</script>
</html>