<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>페이지 제목</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>


#list{
	background-color : white;
}
.list-hit{
	margin-right:33px;
}
.list-no{
	margin-left:50px;
}
.list-title{
	width: 100%;
	margin-left : 10px;
}
.annContent{
	margin-top :200px;
	background-color:white;
}
.list-title, .ann-list {
   flex-basis: 20%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 30px 40px 10px -6px;
    padding: 10px 0;
    border-bottom: 1px solid #ccc;
}

.ann-list {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 10px 0;
    padding: 10px 0;
    border-bottom: 1px solid #f0f0f0;
}

.ann-list-no, .ann-list-subject, .ann-list-name, .ann-list-date, .ann-list-hit, .ann-list-check {
    flex-basis: 20%; /* 각 항목이 5개이므로 100%를 5로 나눈 값 */
    text-align: center;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.ann-list-subject {
    flex-grow: 1;
    text-align: left;
    padding-left: 20px;
}

.ann-list-check {
    display: flex;
    justify-content: center;
    align-items: center;
}



.card-card{
	display : flex;
	width: 70%;
}
.card-link{
	width: 500px;
	text-align : center;
}
.card-date{
	font-size : 12px;width: 40%;
	text-align : center;
}


#container3 {
	background-color: white;
}

#myChart {
	width: 550px;
	height: 230px;
}

#chart {
	background-color: white;
	height: auto;
	text-align: center;
	width: 81%;
	margin-left: 30px;
}

#chart-container {
	background-color: white;
	height: 700px;
}

#approvalImg {
	width: 50px;
	height: 50px;
}

body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}

#wrapper {
	display: flex;
	flex-direction: column;
}

.arrr {
	text-align: left;
	margin-right: 120px;
}

#sidebar {
	width: 250px;
	background-color: #f0f0f0;
	position: fixed;
	top: 0;
	left: 0;
	bottom: 0;
	overflow-y: auto;
	z-index: 100;
}

#content-wrapper {
	display: flex;
	flex: 1;
	margin-left: 250px;
	padding: 20px;
	justify-content: space-between;
}

#userName {
	width: 80%;
	margin-left: 270px;
	margin-top: 100px;
	background-color: white;
	padding: 10px;
	border: 1px solid #ddd;
	font-size: 13px;
	text-align: left;
	font-size: 20px;
	font-weight: bold;
}

.user {
	margin-left: 10px;
	font-size: 18px;
	color: blue;
}

.user2 {
	font-size: 14px;
	margin-left: 10px;
}

#mySchedule {
	width: 100%;
	background-color: #fff;
	border: 1px solid #ddd;
	padding: 20px;
	margin-bottom: 50px;
}

#setBtn {
	text-align: center;
}

.cate {
	border: none;
	background-color: white;
	text-align: center;
	padding: 15px;
	margin-right: 25px;
	margin-left: 25px;
	font-size: 18px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	padding: 10px;
	border: 1px solid #ddd;
}

th {
	background-color: #f4f4f4;
}

#approval {
	background-color : white;
	margin-bottom:30px;
	margin-left: 30px;
	width: 80%;
	border: 1px solid #ddd;
	padding: 20px;
	text-align: center;
}

#wait, #refer {
	margin-bottom: 10px;
}

#left {
	width: 48%;
	margin-right: 20px;
}

#right {
	background-color: #F9FBFD;
	border: none;
	width: 48%;
}

#chart-container {
	width: 100%;
	height: 200px;
	margin-top: 20px; /* 필요에 따라 조정 */
}

#content-wrapper {
	background-color: #F9FBFD;
}
#scraped-content{
	overflow-y : scroll;
	height : 700px;
}

</style>
</head>
<body>
	<header>
		<div id="wrapper">
			<div id="sidebar">
				<jsp:include page="../sideBar.jsp"></jsp:include>
			</div>
			<input type ="hidden" value = "${sessionScope.loginInfo.emp_no}" id = "emp_no">
			<div id="userName">
				<span class="user" id="user">안녕하세요,
					${sessionScope.loginInfo.name}님!</span><br>
				<span class="user2">${sessionScope.loginInfo.dept_name}
					${sessionScope.loginInfo.rank_name}</span>
			</div>
			<div id="content-wrapper">
				<section id="left">
					<div id="mySchedule">
						<div id="setBtn">
							<button class="cate" value="금주" onclick="setDays('금주')">금주</button>
							<button class="cate" value="오늘" onclick="setDays('오늘')">오늘</button>
							<button class="cate" value="내일" onclick="setDays('내일')">내일</button>
						</div>
						<br> <br>
						<table>
							<thead>
								<tr>
									<th>제목</th>
									<th>시작일</th>
									<th>종료일</th>
								</tr>
							</thead>
							<tbody id="table-body">
								<!-- 필터링된 이벤트가 여기에 추가될 것입니다 -->
							</tbody>
						</table>
						<br>
						<br>
					</div>
					<div id="chart2">
						<div class="container3"
							style="background-color: white; height: 250px;">
							<canvas id="myChart"></canvas>
						</div>
					</div>
					<br><br>
				    <div class="annContent">
				        <div class="list-title"style="background-color:#6076E8; color:white;">
				            <div class="list-no"><strong>&nbsp;번호</strong></div>
				            <div class="list-subject"><strong>제목</strong></div>
				            <div class="list-name"><strong>작성자</strong></div>
				            <div class="list-date"><strong>작성일</strong></div>
				            <div class="list-hit"><strong>조회수</strong></div>
				        </div>
				    </div>
				    <div id="list"></div>					
					
				</section>
				<section id="right">
					<div id="approval">
					<span style = "font-size: 20px; font-weight:bold;">전자결재</span>
					<br><br>
						<div id="wait">
							<span class="arrr"><img id="approvalImg"
								src="/scss/icons/approve.png"> 전자결재(대기)</span> 0건
						</div><br><br>
						<div id="refer">
							<span class="arrr"><img id="approvalImg"
								src="/scss/icons/approve.png"> 전자결재(참조)</span> 0건
						</div>
					</div>
					<br>
					<div id="chart">
						<div id="chart-container">
							<canvas id="reservationChart"></canvas>
							<br>
							<br>
						</div>
						<span>오늘의 예약자수 ${total}명</span><br>
						<br>
					</div>
					<br>
					<br>
					<div id="scraped-content">
						<h1>News List</h1>
						<c:forEach var="article" items="${scrapedContent}">
							<table class="card">
								<thead class="card-title">
									<tr>
										<td class = "card-card" style = "display : flex; width: 100%;"><a class="card-link" href="${article.link}"
											target="_blank">${article.title}</a></td>
											<td class="card-date">${article.date}</td>
											
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="card-desc">${article.desc}</td>
									</tr>
									<tr>
									</tr>
								</tbody>
							</table>
						</c:forEach>
					</div>
				</section>
			</div>
		</div>
	</header>

	<!-- 차트 링크 -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>

	<script>
	var showPage = 1;
	var ann_fixed = 'N';
	var ann_division = 'E';
	var register = ''; // register 변수 정의
	var ann_date = ''; // regist_date 변수 정의
	var cnt = 10;
	var data = [];
	
	
	$(document).ready(function(){
	    listCall(showPage);
	    setDays('오늘');
	    
	    
	    function listCall(page) {
	        var cnt = 10;
	        $.ajax({
	            type: 'GET',
	            url: '/empann/annList.ajax',
	            data: {
	                'page': page,
	                'cnt': cnt,
	                'ann_division': ann_division,
	                'ann_fixed': ann_fixed,
	                'register': register,
	                'ann_date': ann_date
	            },
	            dataType: 'json',
	            success: function(data) {
	          
	                drawList(data.list);
	                totalPages = data.totalPages;
	            },
	            error: function(error) {
	                console.log('리스트 출력 실패:', error);
	            }
	        });
	    }

	    function drawList(data) {
	        var content = '';
	        for (var i = 0; i < data.length; i++) {
	            content += '<div class="ann-list">';
	            if (data[i].ann_fixed === 'Y') {
	                content += '<div class="ann-list-no ann-notice">[공지]</div>';
	            } else {
	                content += '<div class="ann-list-no">' + data[i].ann_no + '</div>';
	            }
	            content += '<div class="ann-list-subject"><a href="/empannDetail.go?ann_no=' + data[i].ann_no + '">' + data[i].ann_subject + '</a></div>';
	            
	            // updater가 존재할 경우 updater 표시, 그렇지 않으면 register 표시
	            var nameToShow = data[i].updater ? data[i].updater : data[i].register;
	            content += '<div class="ann-list-name">' + nameToShow + '</div>';
	            
	            // update_date가 존재할 경우 update_date 표시, 그렇지 않으면 ann_date 표시
	            var dateToShow = data[i].update_date ? data[i].update_date : data[i].ann_date;
	            content += '<div class="ann-list-date">' + dateToShow + '</div>';
	            
	            content += '<div class="ann-list-hit">' + data[i].ann_bHit + '</div>';
	            content += '</div>';
	        }
	        $('#list').html(content);
	    }
	});
	    
	    
	    
	
	function getDates() {
	    const dates = [];
	    const today = new Date(); // 현재 날짜

	    for (let i = 5; i >= 0; i--) {
	        const date = new Date(today);
	        date.setDate(today.getDate() - i);
	        dates.push(date.toLocaleDateString('ko-KR'));
	    }

	    return dates;
	}
	
	
	function setDays(category) {
	    var emp_no = document.getElementById('emp_no').value; // emp_no 값 가져오기
	    console.log("Selected category:", category); // 카테고리 값 확인
	    console.log("Selected emp_no:", emp_no); // emp_no 값 확인

	    const xhr = new XMLHttpRequest();
	    const url = `/filterEventsByCategory?category=` + encodeURIComponent(category) + `&emp_no=` + encodeURIComponent(emp_no); // URL 인코딩
	    xhr.open('GET', url, true);
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState === XMLHttpRequest.DONE) {
	            if (xhr.status === 200) {
	                try {
	                    const responseText = xhr.responseText;
	                    console.log("Response Text:", responseText);
	                    const filteredEvents = JSON.parse(responseText);
	                    drawList(filteredEvents);
	                } catch (e) {
	                    console.error("JSON parsing error:", e);
	                }
	            } else {
	                console.error('Error filtering events:', xhr.status);
	            }
	        }
	    };
	    xhr.send();
	}

	function drawList(events) {
	    const tableBody = document.getElementById('table-body');
	    tableBody.innerHTML = ''; // 기존 내용을 초기화

	    if (events.length === 0) {
	        tableBody.innerHTML = '<tr><td colspan="3">No events found</td></tr>';
	        return;
	    }

	    events.forEach(event => {
	        const row = document.createElement('tr');

	        const titleCell = document.createElement('td');
	        const titleLink = document.createElement('a');
	        titleLink.href = '/calendar/calendar.go'; // 이 부분을 원하는 URL로 변경하세요
	        titleLink.textContent = event.cal_content;
	        titleCell.appendChild(titleLink);
	        row.appendChild(titleCell);

	        const startCell = document.createElement('td');
	        startCell.textContent = formatDateTime(event.cal_start);
	        row.appendChild(startCell);

	        const endCell = document.createElement('td');
	        endCell.textContent = formatDateTime(event.cal_end);
	        row.appendChild(endCell);

	        tableBody.appendChild(row);
	    });
	}

	function formatDateTime(dateTimeString) {
	    // T를 공백 두 개로 변경
	    const dateTimeFormatted = dateTimeString.replace('T', '  ');
	    return dateTimeFormatted;
	}

        document.addEventListener('DOMContentLoaded', function() {
            const maxCapacity = 100;
            const reservedGuests = ${total}; // 예약된 손님 수 (예시로 75명을 사용)

			            
            
            const data = {
                labels: ['이용중', '예약가능'],
                datasets: [{
                    label: 'Reservations',
                    data: [reservedGuests, maxCapacity - reservedGuests],
                    backgroundColor: ['#FF6384', '#36A2EB'],
                    hoverBackgroundColor: ['#FF6384', '#36A2EB']
                }]
            };

            const config = {
                type: 'doughnut',
                data: data,
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    const label = context.label || '';
                                    const value = context.raw;
                                    const percentage = (value / maxCapacity * 100).toFixed(2);
                                    return `${label}: ${value} (${percentage}%)`;
                                }
                            }
                        }
                    }
                }
            };

            const reservationChart = new Chart(
                document.getElementById('reservationChart'),
                config
            );
        });
        
     // 차트를 그릴 canvas 요소 가져오기
        var ctx = document.getElementById('myChart');

        // AJAX로 날짜별 예약 건수 데이터 가져오기
        $.ajax({
          url: '/reservation/count',
          type: 'GET',
          dataType: 'json',
          success: function(data) {
            // 가져온 데이터를 차트 데이터로 변환
            var labels = data.map(function(item) {
              return item.date_str;
            });
            var counts = data.map(function(item) {
              return item.count;
            });

            // 차트 생성
            var myChart = new Chart(ctx, {
              type: 'bar',
              data: {
                labels: labels,
                datasets: [{
                  label: '일일 예약 손님',
                  data: counts,
                  backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                  ],
                  borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                  ],
                  borderWidth: 1
                }]
              },
              options: {
                scales: {
                  yAxes: [{
                    ticks: {
                      beginAtZero: true
                    }
                  }]
                }
              }
            });
          },
          error: function() {
            console.error('데이터를 가져오는 데 실패했습니다.');
          }
        });
    </script>
</body>
</html>
