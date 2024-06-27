<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>프로필</title>
<style>


#qq{
	background-color : #FCFAFA;
}
.container{
	margin : 0 auto;
}
.employee-card{
	margin-left:100px;
}
.parent {
    display: flex;
    width: 100%;
    height: auto;
}

.sidebar {
    width: 250px;
    background-color: #f0f0f0;
    padding: 10px;
}

.content-wrapper {
    flex: 1;
    display: flex;
    flex-direction: column;
    padding: 20px;
}

.content {
    flex: 1;
    padding: 20px;
    width: 700px;
}

.subTitle2 {
    flex: 1;
    padding: 20px;
    width: 100%;
    box-sizing: border-box; 
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

.btn{
	background-color : #EEEEEE;

}

button {
    margin-left: 10px;
}

.photo {
    width: 150px;
}

h2 {
    text-align: center;
    margin-top: 350px;
}

.subContent2 {
    text-align: center;
}

.totalVacancy {
    width: auto;
    text-align: center;
    margin : 0 auto;
    border : 1px solid black;
    padding : 10px;
}

.ttt {
    text-align: center;
        margin: 0 auto;
        width : 100px;
        padding : 10px;
        border : 1px solid black;
    
}

.ddd {
    text-align: center;
    width : 100px;
        margin: 0 auto;
    	border : 1px solid black;
}
.titless{
	text-align : center;
}

</style>
</head>
<body>
    <div class="parent">
        <div class="sidebar">
            <jsp:include page="../sideBar.jsp"></jsp:include>
        </div>
        <div class="content-wrapper">
            <br><br><br><br><br>
            
            <h2>${sessionScope.loginInfo.name}님의 프로필</h2>
            <br><br>
            <div class="content">
                <table class="employee-card">
                    <tr>
                        <td class="photo" rowspan="5">
                            <c:choose>
                                <c:when test="${empty sessionScope.loginInfo.pho_name}">
                                    <div id="photo" style="width: 45%; height: 20%; margin-right: 50px; text-align:center;">
										사진 X
	                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/photo/${sessionScope.loginInfo.pho_name}" alt="사진" id="photo" style="width: 100%; height: auto;">
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="photo" id = "qq">이름</td>
                        <td class="photo" id = "qq">직책</td>
                        <td class="titles" id = "qq">소속</td>
                        <td class="subContent2" id="dept_display"></td>
                        <td class="titles" id = "qq">사번</td>
                        <td class="subContent2">${sessionScope.loginInfo.emp_no}</td>
                    </tr>
                    <tr>
                        <td class="photo" rowspan="3">${sessionScope.loginInfo.name}</td>
                        <td class="photo" rowspan="3" id="rank_display"></td>
                        <td class="titles" id = "qq">이메일</td>
                        <td class="subContent" colspan="6">${sessionScope.loginInfo.email}</td>
                    </tr>
                    <tr>
                        <td class="titles" id = "qq">전화번호</td>
                        <td class="subContent" colspan="5">${sessionScope.loginInfo.phone}</td>
                    </tr>
                    <tr>
                        <td class="titles" id = "qq">입사일</td>
                        <td class="subContent" colspan="5">${sessionScope.loginInfo.join_date}</td>
					</tr>
                </table>
                <br><br>
                <div class="btns">
					    <button id = "editBtn" class="btn waves-effect waves-light btn-primary">비밀번호 변경</button>					
							<div id="info-alert-modal" class="modal fade over" tabindex="-1" role="dialog" aria-hidden="true">
							    <div class="modal-dialog modal-sm">
							        <div class="modal-content">
							            <div class="modal-body p-4">
							                <div class="text-center">
							                    <i class="dripicons-information h1 text-info"></i>
							                    <p id="modal-message" class="mt-3"></p>
							                    
							                    <!-- 비밀번호 입력 -->
							                    <input type="password" id="new-password" class="form-control mb-3" placeholder="새로운 비밀번호 입력">
							                    
							                    <!-- 비밀번호 확인 -->
							                    <input type="password" id="confirm-password" class="form-control mb-3" placeholder="비밀번호 확인">
							                    
							                    <!-- 확인 버튼 -->
							                    <button type="button" class="btn btn-primary my-2" id="confirm-btn">확인</button>
							                    
							                    <!-- 취소 버튼 -->
							                    <button type="button" class="btn btn-secondary my-2" data-dismiss="modal">취소</button>
							                </div>
							            </div>
							        </div>
							    </div>
							</div>                
            </div>
            <br>
            <div class="subTitle2">
                <div class="subContent2">
                    <table class="totalVacancy">
                        <tr>
                            <td class="ttt" id = "qq">총 연차</td>
                            <td class="ddd" >${leave.total_leave}</td>
                            <td class="ttt" id = "qq">사용 연차</td>
                            <td class="ddd"  >${leave.use_leave}</td>
                            <td class="ttt" id = "qq">잔여 연차</td>
                            <td class="ddd" >${leave.balance_leave}</td>
                        </tr>
                    </table>
                    
			<table id="showlist" class="table">
				<thead>
					<tr class="listhead">
						<th class="titless">시작날짜</th>
						<th class="titless">사용연차</th>
						<th class="titless">결재날짜</th>
						<th class="titless">결재자</th>
					</tr>
				</thead>
				<br><br>
				<tbody id="list" class="listhead"></tbody>
				<tr>
					<td colspan="5" id="paging">
						<div class="container">
							<nav aria-label="page navigation" style="margin:0 auto; width: 1800px;">
								<ul class="pagination" id="pagination" style="margin:0 auto; width: 1000px;"></ul>
							</nav>
							<hr>
						</div>
					</td>
				</tr>
			</table>
                </div>
            </div>
        </div>
    </div>
</body>
<script src="/scss/icons/jquery.twbsPagination.js" type="text/javascript"></script>
<script>
	var showPage = 1;

    $(document).ready(function () {
        listCall(showPage);

        $('#confirm-btn').click(function () {
            var newPassword = $('#new-password').val();
            var confirmPassword = $('#confirm-password').val();

            // 비밀번호 일치 여부 확인
            if (newPassword !== confirmPassword) {
                $('#modal-message').text('비밀번호가 일치하지 않습니다.');
                return; // 일치하지 않으면 여기서 종료
            }

            // 비밀번호 변경 요청 데이터
            var requestData = {
                emp_no: '${sessionScope.loginInfo.emp_no}',
                new_password: newPassword
            };

            // 비밀번호 변경 AJAX 요청
            $.ajax({
                type: 'POST',
                url: '/changePassword', // 비밀번호 변경을 처리할 서버 URL
                data: requestData,
                dataType: 'json',
                success: function (response) {
                    // 서버 응답 처리
                    if (response.success) {
                        $('#modal-message').text('비밀번호 변경이 완료되었습니다.');
                    } else {
                        $('#modal-message').text('비밀번호 변경에 실패하였습니다.');
                    }
                },
                error: function (error) {
                    console.log(error);
                    $('#modal-message').text('서버 오류로 비밀번호 변경에 실패하였습니다.');
                }
            });

            // 모달 닫기
            $('#info-alert-modal').modal('hide');
        });

        $('#editBtn').click(function () {
            $('#info-alert-modal').modal('show');
        });

        // rank_code에 해당하는 텍스트를 매핑합니다.
        const rankMap = {
            6: '사원',
            5: '대리',
            4: '과장',
            3: '팀장',
            2: '이사',
            1: '사장'
        };

        // rank_code에 해당하는 텍스트를 찾아서 표시합니다.
        const rankDisplay = document.getElementById('rank_display');
        const rankCode = ${sessionScope.loginInfo.rank_code};
        rankDisplay.textContent = rankMap[rankCode] || '대기 상태';

        // dept_code에 해당하는 텍스트를 매핑합니다.
        const deptMap = {
            11: '인사팀',
            22: '시설팀',
            33: '고객팀'
        };

        // dept_code에 해당하는 텍스트를 찾아서 표시합니다.
        const deptDisplay = document.getElementById('dept_display');
        const deptCode = ${sessionScope.loginInfo.dept_code};
        deptDisplay.textContent = deptMap[deptCode] || '대기 상태';

        // 초기화면 목록 호출
        listCall(showPage);
    });

    function listCall(page) {
        $.ajax({
            type: 'get',
            url: '/leaveList.ajax',
            data: {
                'page': page,
                'emp_no': '${sessionScope.loginInfo.emp_no}' // emp_no를 추가하여 전송
            },
            dataType: 'json',
            success: function (data) {
                drawList(data.list);
                $('#total_leave').text(data.total_leave);
                $('#use_leave').text(data.use_leave);
                $('#balance_leave').text(data.balance_leave);

                // 플러그인 추가
                $('#pagination').twbsPagination({
                    startPage: data.currPage, // 시작 페이지
                    totalPages: data.totalPages, // 총 페이지 갯수
                    visiblePages: 5,  // 보여줄 페이지 수[1][2][3][4][5]
                    onPageClick: function (evt, pg) { // 페이지 클릭시 실행 함수
                        console.log(evt); // 이벤트 객체
                        console.log(pg); // 클릭한 페이지 번호 의미
                        showPage = pg;
                        listCall(pg);
                    }
                });

            },
            error: function (error) {
                console.log(error);
            }
        });
    }

    function drawList(list) {
        var content = '';
        for (var i = 0; i < list.length; i++) {
            var emp = list[i];

            content += '<tr style="border-bottom: 1px solid #ddd; height: 50px;">';
            content += '<td style="text-align: center;">' + emp.leave_start + ' ~ ' + emp.leave_end + '</td>';
            content += '<td style="text-align: center;">' + emp.leave_use + '</td>';
            content += '<td style="text-align: center;">' + emp.regist_date + '</td>';
            content += '<td style="text-align: center;">' + emp.register + '</td>';
            content += '</tr>';
        }
        $('#list').html(content);
    }
</script>
</html>