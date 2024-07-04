<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>직원 기본 정보</title>
<style>
#qq {
	background-color: #FCFAFA;
}

.container {
	margin: 0 auto;
}

.employee-card {
	height: 400px;
    width: 90%;
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

.contentt {
    padding: 20px;
    width: 100%;
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

.btn {
	background-color: #EEEEEE;
}

button {
	margin-left: 10px;
}

.photo {
	text-align : left;
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
	margin: 0 auto;
	border: 1px solid black;
	padding: 10px;
}

.ttt {
	text-align: center;
	margin: 0 auto;
	width: 100px;
	padding: 10px;
	border: 1px solid black;
}

.ddd {
	text-align: center;
	width: 100px;
	margin: 0 auto;
	border: 1px solid black;
}

.titless {
	text-align: center;
}
</style>
</head>
<body>
	<div class="parent">
		<div class="sidebar">
			<jsp:include page="../sideBar.jsp"></jsp:include>
		</div>
		<div class="content-wrapper">
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>

			<h2>기본정보</h2>
			<br>
			<br>
			<br>
			<br>
			<br>
			<div class="contentt">
				<table class="employee-card">
					<tr>
						<td class="photo" rowspan="8" colspan = "1"><c:choose>
								<c:when test="${empty P.pho_name}">
									<div id="photo"
										style="width: 45%; height: 20%; margin-right: 50px; text-align: center;">
										사진 X</div>
								</c:when>
								<c:otherwise>
									<img
										src="${pageContext.request.contextPath}/photo/${P.pho_name}"
										alt="사진" id="photo" style="width: 100%; height: 100%;">
								</c:otherwise>
							</c:choose></td>
						<td class="titles" id="qq">이름</td>
						<td class="photo" style = "text-align : left;">${emp.name}</td>						
						<td class="titles" id="qq">직책</td>
						<td class="photo" style = "text-align : left;">${rank}</td>
					</tr>
					<tr>
						<td class="titles" id="qq">소속</td>
						<td class="subContent2">${dept}</td>
						<td class="titles" id="qq">사번</td>
						<td class="subContent2">${emp.emp_no}</td>
					</tr>
					<tr>
						<td class="titles" id="qq">이메일</td>
						<td class="subContent" colspan="1">${emp.email}</td>
						<td class="titles" id="qq">전화번호</td>
						<td class="subContent" colspan="1">${emp.phone}</td>
					</tr>
					<tr>
						<td class="titles" id="qq">성별</td>
						<td class="subContent2">${emp.gender}</td>
						<td class="titles" id="qq">생년월일</td>
						<td class="subContent2">${emp.birth}</td>
					</tr>
					<tr>
						<td class="titles" id="qq">권한레벨</td>
						<td class="subContent2">${emp.authority}</td>
						<td class="titles" id="qq">재직상태</td>
						<td class="subContent2" colspan="1">${emp.status_division}</td>
					</tr>
					<tr>
						<td class="titles" id="qq">입사일</td>
						<td class="subContent" colspan="1">${emp.join_date}</td>
						<td class="titles" id="qq">우편번호</td>
						<td class="subContent2" colspan="6">${emp.post_no}</td>
					</tr>
					<tr>
						<td class="titles" id="qq">은행</td>
						<td class="subContent" colspan="1">${emp.bank_name}</td>
						<td class="titles" id="qq">주소</td>
						<td class="subContent2" colspan="7">${emp.address}</td>
					</tr>
					<tr>
						<td class="titles" id="qq">계좌번호</td>
						<td class="subContent" colspan="1">${emp.account_no}</td>
						<td class="titles" id="qq">상세주소</td>
						<td class="subContent2" colspan="7">${emp.detail_address}</td>
					</tr>
				</table>
				<br>
				<br>
				<br>
				<br>
					<div class="btns">
					    <button style="margin-right: 30px;" class="btn waves-effect waves-light btn-primary" id="editEmpInfo" onclick="showModal('edit')">사원정보 수정</button>
					    <button onclick="showModal('reset')" class="btn waves-effect waves-light btn-primary">비밀번호 초기화</button>
					
					    <div id="info-alert-modal" class="modal fade over" tabindex="-1" role="dialog" aria-hidden="true">
					        <div class="modal-dialog modal-sm">
					            <div class="modal-content">
					                <div class="modal-body p-4">
					                    <div class="text-center">
					                        <i class="dripicons-information h1 text-info"></i>
					                        <p id="modal-message" class="mt-3"></p>
					                        <button type="button" class="btn btn-primary my-2" id="confirm-btn">확인</button>
					                        <button type="button" class="btn btn-secondary my-2" data-dismiss="modal">취소</button>
					                    </div>
					                </div>
					            </div>
					        </div>
					    </div>
					</div>
			</div>
			<br>
			<br>
			<br>
			<br>
			<div class="subTitle2">
				<div class="subContent2">
					<table class="totalVacancy">
						<tr>
							<td class="ttt" id="qq">총 연차</td>
							<td class="ddd">${leave.total_leave}</td>
							<td class="ttt" id="qq">사용 연차</td>
							<td class="ddd">${leave.use_leave}</td>
							<td class="ttt" id="qq">잔여 연차</td>
							<td class="ddd">${leave.balance_leave}</td>
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
						<br>
						<br>
						<tbody id="list" class="listhead"></tbody>
						<tr>
							<td colspan="5" id="paging">
								<div class="container">
									<nav aria-label="page navigation"
										style="margin: 0 auto; width: 1800px;">
										<ul class="pagination" id="pagination"
											style="margin: 0 auto; width: 1000px;"></ul>
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
<script src="/scss/icons/jquery.twbsPagination.js"
	type="text/javascript"></script>
<script>
	var showPage = 1;
	var searchRemain = false;

	$(document).ready(function() { // html 문서가 모두 읽히면 되면(준비되면) 다음 내용을 실행 해라
		listCall(showPage);
	});

	
    function showModal(action) {
        let message = '';
        let confirmAction = '';

        if (action === 'edit') {
            message = '사원 정보를 수정하시겠습니까?';
            confirmAction = `location.href='empEdit.go?emp_no=${emp.emp_no}'`;
        } else if (action === 'reset') {
            message = '비밀번호를 초기화하시겠습니까?';
            confirmAction = `location.href='resetPw.do?emp_no=${emp.emp_no}'`;
        }

        $('#modal-message').text(message);
        $('#confirm-btn').attr('onclick', confirmAction);
        $('#info-alert-modal').modal('show');
    }

	// dept_code에 해당하는 텍스트를 매핑합니다.
	const deptMap = {
		11 : '인사팀',
		22 : '시설팀',
		33 : '고객팀'
	};

	// dept_code에 해당하는 텍스트를 찾아서 표시합니다.
	const deptDisplay = document.getElementById('dept_display');
	deptDisplay.textContent = deptMap[deptCode] || '대기 상태';

	function listCall(page) {
		$.ajax({
			type : 'get',
			url : '/leaveList.ajax',
			data : {
				'page' : page,
				'emp_no' : '${emp.emp_no}'
			},
			dataType : 'json',
			success : function(data) {
				drawList(data.list);

				var startPage = 1;

				// 플러그인 추가
				$('#pagination').twbsPagination({
					startPage : data.currPage, // 시작 페이지
					totalPages : data.totalPages, // 총 페이지 갯수
					visiblePages : 5, // 보여줄 페이지 수[1][2][3][4][5]
					onPageClick : function(evt, pg) { // 페이지 클릭시 실행 함수
						console.log(evt); // 이벤트 객체
						console.log(pg); // 클릭한 페이지 번호 의미
						showPage = pg;
						listCall(pg);
					}
				});

			},
			error : function(error) {
				console.log(error);
			}
		});
	}

	function drawList(list) {
		var content = '';
		for (var i = 0; i < list.length; i++) {
			var emp = list[i];

			content += '<tr style="border-bottom: 1px solid #ddd; height: 50px;">';
			content += '<td style="text-align: center;">' + emp.leave_start
					+ ' ~ ' + emp.leave_end + '</td>';
			content += '<td style="text-align: center;">' + emp.leave_use
					+ '</td>';
			content += '<td style="text-align: center;">' + emp.app_date
					+ '</td>';
			content += '<td style="text-align: center;">' + emp.register
					+ '</td>';
			content += '</tr>';
		}
		$('#list').html(content);
	}
</script>
</html>
