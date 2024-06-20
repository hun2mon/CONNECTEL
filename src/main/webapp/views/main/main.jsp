<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>페이지 제목</title>
    <style>
        #userName {
            border: 1px solid #dee2e6;
        }
        #sidebar {
            width: 250px; /* 사이드바 너비 지정 */
            background-color: #f0f0f0; /* 사이드바 배경색 */
            position: fixed; /* 페이지 스크롤에 따라 고정 */
            top: 0; /* 페이지 상단에서 고정 위치 */
            left: 0; /* 페이지 왼쪽에서 고정 위치 */
            bottom: 0; /* 페이지 하단까지 사이드바 길이 */
            overflow-y: auto; /* 사이드바 길이가 초과하면 스크롤 */
            z-index: 100; /* 다른 요소 위에 사이드바 위치 */
        }
        #content {
            width: 75%;
            height: 90%;
            margin-left: 300px;
            margin-right: 150px;
            margin-top: 102px;
            margin-bottom: 250px;
        }
        #userName {
            background-color: white;
            border: 1px solid white;
            font-size: 13px;
        }
        .user {
            margin-left: 10px;
        }
        #user {
            font-size: 16px;
            font-weight: bold;
        }
        #mySchedule {
            background-color: white;
            border: 1px solid white;
            font-size: 13px;
            width: 40%;
            height: auto;
        }
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 10px; /* 셀 간격 조정 */
        }
        th, td {
            padding: 10px; /* 셀 내부 여백 조정 */
            border: 1px solid #ddd;
        }
        th {
            background-color: #f4f4f4;
        }
       .cate{                                                                  
             border : none;                                                                                       
             background-color:white;                                                         
             text-align:center;                                                                           
             padding:15px;                                                               
             margin-right:25px;
             margin-left: 25px;                                                                                                        
             font-size : 18px;
   	  }
   	  	#setBtn{
   	  		width:100%;
   	  		text-align:center;
   	  	}
    </style>
</head>
<body onload="setDays('오늘')">
<header>
    <div id="wrapper">
        <div id="sidebar">
            <jsp:include page="../sideBar.jsp"></jsp:include>
        </div>

        <div id="content">
            <div id="userName">
                <span class="user" id="user">안녕하세요, 김광중님!</span>
                <br>
                <span class="user">시설 관리팀 대리</span>
            </div>
            <br>
            <section>
                <div id="mySchedule">
                    <div id = "setBtn">
                        <button class="cate" value="금주" onclick="setDays('금주')">금주</button>
                        <button class="cate" value="오늘" onclick="setDays('오늘')">오늘</button>
                        <button class="cate" value="내일" onclick="setDays('내일')">내일</button>
                    </div>
                    <br><br>
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
                </div>
            </section>
        </div>
    </div>
</header>

<script>





    function setDays(category) {
        console.log("Selected category:", category); // 카테고리 값 확인
        const xhr = new XMLHttpRequest();
        const url = `/filterEventsByCategory?category=` + encodeURIComponent(category); // URL 인코딩
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
            titleCell.textContent = event.cal_content;
            row.appendChild(titleCell);
			
            
            const startCell = document.createElement('td');
            startCell.textContent = event.cal_start.slice(0,16);
            row.appendChild(startCell);

            const endCell = document.createElement('td');
            endCell.textContent = event.cal_end.slice(0,16);
            row.appendChild(endCell);

            tableBody.appendChild(row);
        });
    }
</script>
</body>
</html>