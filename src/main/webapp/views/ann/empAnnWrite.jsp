<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="richtexteditor/rte_theme_default.css" />
<script type="text/javascript" src="richtexteditor/rte.js"></script>
	<script type="text/javascript" src='richtexteditor/plugins/all_plugins.js'></script>
<style>
body {
    display: flex;
    margin: 0;
    height: 100vh;
}

.sidebar-container {
    flex-shrink: 0;
    width: 250px;
    background-color: #f8f9fa;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    overflow-y: auto;
}

.write-container {
    flex-grow: 1;
    padding: 20px;
    overflow-y: auto;
    margin-top: 100px; 
    text-align: center;
}




</style>
</head>
<body>
<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>

<div class="write-container">
    <form id="empannForm" action="/empannwrite.do" method="post">
        <table>
            <tr>
                <th colspan="2" style="background-color:#6076E8; color:white;">
                    직원 공지사항 글쓰기
                </th>
            </tr>
            <tr>
                <th>
                    <input type="text" class="subject" id="subject" name="subject" placeholder="제목을 입력해주세요." required>
                </th>
                <td>
                    <select id="ann_division" name="ann_division">
                        <option value="E">직원 공지사항</option>
                        <option value="C">고객 공지사항</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="div_editor"></div>
					<input type="hidden" name="content"/>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="exit">
                        <a href="ann/empAnnList.go"><i class="fas fa-arrow-left"></i> 뒤로가기</a>
                    </div>
                   <button type="button" onclick="save()">저장</button> 
                </td>
            </tr>
        </table>
    </form>
</div>







</body>
<script>
var config = {}
config.toolbar = "basic";
config.editorResizeMode="none";
var editor = new RichTextEditor("#div_editor", config);


function save(){
	// 에디터에 작성된 문자열을 가져온다.
	var content = editor.getHTMLCode();
	console.log('에디터에 작성된 문자열 : ',content.length);
	$('input[type="hidden"]').val(content);
	
	if(content.length>(5*1024*1024)){
		alert('컨텐츠의 크기가 너무 큽니다. 이미지의 크기나 갯수를 줄여 주세요');
	}else{
		$('form').submit(); //form 태그를 서브밋 하는 함수
	}	
}




</script>
</html>