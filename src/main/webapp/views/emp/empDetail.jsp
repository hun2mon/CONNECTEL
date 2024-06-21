<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>직원 기본 정보</title>
<style>
/* 스타일 정의 */
.parent {
    display: flex;
}
.sidebar {
    width: 250px;
    background-color: #f0f0f0;
    padding: 10px;
}
.content {
    flex: 1;
    padding: 20px;
    display: flex;
    flex-direction: column;
}
.subject {
    border: 1px solid black;
    padding: 5px;
    display: inline-block;
    width: 100px;
    text-align: center;
}
.employee-card {
    border-collapse: collapse;
    width: 100%;
}
.employee-card th, .employee-card td {
    border: 1px solid black;
    padding: 10px;
    text-align: center;
}
.employee-card .titles {
    width: 120px;
    font-weight: bold;
}
.employee-card .subContent, .employee-card .subContent2 {
    text-align: left;
}
.hiddenTitle {
    border: none;
}
.btns {
    text-align: right;
}
.btn {
    margin-left: 10px;
}
.photo {
    width: 150px;
}
h2 {
    text-align: center;
    margin-top: 200px;
}
</style>
</head>
<body>
    <div class="parent">
        <div class="sidebar">
            <jsp:include page="../sideBar.jsp"></jsp:include>
        </div>
        <div class="content">
            <br><br>
            <h2>기본정보</h2>
            <br><br><br><br><br>
            <table class="employee-card">
                <tr>
                    <td class="photo" rowspan="5">
                        <c:choose>
                            <c:when test="${empty P.pho_name}">
                                <div id="photo" style="width: 15%; height: 20%; margin-right: 50px;">
                                    등록된 사진이 없습니다.
                                </div>
                            </c:when>
                            <c:otherwise>
        						<img src="${pageContext.request.contextPath}/photo/${P.pho_name}" alt="사진" id="photo" style="width: 100%; height: auto;">
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="photo">이름</td>
                    <td class="photo">직책</td>
                    <td class="titles">소속</td>
                    <td class="subContent2">${emp.dept_code}</td>
                    <td class="titles">사번</td>
                    <td class="subContent2">${emp.emp_no}</td>
                </tr>
                <tr>
                    <td class="photo" rowspan="4">${emp.name}</td>
                    <td class="photo" rowspan="4">${emp.rank_code}</td>
                    <td class="titles">이메일</td>
                    <td class="subContent" colspan="6">${emp.email}</td>
                </tr>
                <tr>
                    <td class="titles">전화번호</td>
                    <td class="subContent" colspan="6">${emp.phone}</td>                    
                </tr>
                <tr>
                    <td class="titles">성별</td>
                    <td class="subContent2">${emp.gender}</td>                    
                    <td class="titles">생년월일</td>
                    <td class="subContent2">${emp.birth}</td> 
                </tr> 
                <tr>
                    <td class="titles">권한레벨</td>
                    <td class="subContent2">${emp.authority}</td>      
                    <td class="titles">재직상태</td>
                    <td class="subContent2" colspan="6">${emp.status_division}</td>                           
                </tr>
                <tr>
                    <td class="titles">입사일</td>
                    <td class="subContent" colspan="2">${emp.join_date}</td>    
                    <td class="titles">우편번호</td>
                    <td class="subContent2" colspan="6">${emp.post_no}</td>                     
                </tr>
                <tr>
                    <td class="titles">은행</td>
                    <td class="subContent" colspan="2">${emp.bank_name}</td> 
                    <td class="titles">주소</td>
                    <td class="subContent2" colspan="6">${emp.address}</td>                     
                </tr>
                <tr>
                    <td class="titles">계좌번호</td>
                    <td class="subContent" colspan="2">${emp.account_no}</td>                    
                    <td class="titles">상세주소</td>
                    <td class="subContent2" colspan="6">${emp.detail_address}</td>                     
                </tr>                   
            </table>
            <br><br><br><br>
            <div class="btns">
                <button  class="btn" id = "editEmpInfo">사원정보 수정</button>
                <button onclick = "location.href='resetPw.do'" class="btn">비밀번호 초기화</button>
            </div>
        </div>
    </div>
</body>
<script>





</script>
</html>
