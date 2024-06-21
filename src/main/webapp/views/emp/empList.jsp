<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
	<script src="scss/icons/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
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
	.filterTab{
		margin: 0 auto;
	}
	.input-container {
		position: relative;
		display: inline-block;
		width: 100%;
	}
	.input-container input {
		width: calc(100% - 40px); /* 이미지의 크기만큼 여유 공간 추가 */
		padding-right: 40px; /* 이미지의 크기만큼 여유 공간 추가 */
		box-sizing: border-box;
	}
	.input-container img {
		position: absolute;
		right: 10px; /* 입력 필드의 오른쪽 끝에서 10px 떨어진 위치 */
		top: 50%;
		transform: translateY(-50%);
		cursor: pointer;
	}
</style>
</head>
<body>
	<div class="parent">
		<div class="sidebar">
			<jsp:include page="../sideBar.jsp"></jsp:include>
		</div>
		<div id="content">
			<!-- 구분기능  -->
			<div class="filterTab">
				<button class="cate" value="1" onclick="setCategory(1)">전체</button>
				<button class="cate" value="2" onclick="setCategory(2)">인사팀</button>
				<button class="cate" value="3" onclick="setCategory(3)">시설팀</button>
				<button class="cate" value="4" onclick="setCategory(4)">고객팀</button>
			</div>

			<br> <br>
			<hr>
			<hr>
			<table id="showlist">
				<tbody id="list" class="listhead"></tbody>
				<tr>
					<td colspan="7" id="paging">
						<div class="container">
							<nav aria-label="page navigation" style="text-align: center">
								<ul class="pagination" id="pagination"></ul>
							</nav>
							<hr>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<script>
		var category = 1;
		var showPage = 1;
		var searchRemain = false;

		$(document).ready(function() {
			listCall(showPage);
		});

		function setCategory(num) {
			console.log(num);
			category = num;
			$('#pagination').twbsPagination('destroy');
			showPage = 1;

			$('.cate').removeClass('selected');
			$('.cate[value="' + num + '"]').addClass('selected');

			listCall(showPage);
		}

		function listCall(page) {
			$.ajax({
				type: 'get',
				url: '/empList.ajax',
				data: {
					'page': page,
					'categoryNum': category
				},
				dataType: 'json',
				success: function(data) {
					drawList(data.list);

					$('#pagination').twbsPagination({
						startPage: data.currPage,
						totalPages: data.totalPages,
						visiblePages: 5,
						onPageClick: function(evt, pg) {
							showPage = pg;
							listCall(pg);
						}
					});
				},
				error: function(error) {
					console.log(error)
				}
			});
		}

		function drawList(list) {
			var content = '';
			for (var i = 0; i < Math.min(10, list.length); i++) {
				var emp = list[i];
				if (emp.dept_code == 11) {
					emp.dept_code = "인사팀";
				} else if (emp.dept_code == 22) {
					emp.dept_code = "시설팀";
				} else if (emp.dept_code == 33) {
					emp.dept_code = "고객팀";
				}

				if (emp.rank_code == 1) {
					emp.rank_code = "사장";
				} else if (emp.rank_code == 2) {
					emp.rank_code = "이사";
				} else if (emp.rank_code == 3) {
					emp.rank_code = "팀장";
				} else if (emp.rank_code == 4) {
					emp.rank_code = "과장";
				} else if (emp.rank_code == 5) {
					emp.rank_code = "대리";
				} else if (emp.rank_code == 6) {
					emp.rank_code = "사원";
				}

				content += '<tr style="border-bottom: 1px solid #ddd; height: 50px;">';
				content += '<td style="text-align: center;">' + emp.emp_no + '</td>';
				content += '<td style="text-align: center;">'
						+ '<a href="/empDetail.go?emp_no=' + emp.emp_no + '">'
						+ emp.name + '</a>' + '</td>';
				content += '<td style="text-align: center;">' + emp.dept_code + '</td>';
				content += '<td style="text-align: center;">' + emp.rank_code + '</td>';

				content += '</tr>';
			}
			$('#list').html(content);
		}
	</script>
</body>
</html>
