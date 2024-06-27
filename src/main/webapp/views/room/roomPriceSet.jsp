<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
		 body {
        font-family: Arial, sans-serif; 
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
    
     .table-responsive {
            display: flex;
            flex-direction: column;
            align-items: center; /* 가운데 정렬 */
            margin-top: 5px; /* 위쪽 간격 */
        }
        .select-container {
            display: flex;
            justify-content: center;
            gap: 30px; /* 두 선택 요소 사이의 간격 */
            margin-top: 20px;
            
        }
        label {
            font-weight: bold;
		    color: #0277bd; /* 파란색 글자 */
		    margin-bottom: 0px;
		    font-size: x-large;
        }
        
        dd, h1, h2, h3, h4, h5, h6, label {
		    margin-bottom: 0; /* 기본 속성을 0으로 설정하여 제거 */
		}
		
		table{
			 margin-top: 20px;
		    width: 100%;
		    border-collapse: collapse;
		    text-align: center;
		    background-color: #ffffff; /* 테이블 배경 흰색 */
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 테이블 그림자 */
		}
		
		input{
			width: 100%;
		    border: 1px solid;
		    background-color: #e1f5fe; /* 아주 연한 하늘색 배경 */
		    text-align: center;
		    border-radius: 3px;
		    
		    padding: 8px;
		    transition: background-color 0.3s ease; /* 배경색 전환 부드럽게 */
		}
		
		th, td {
		    padding: 12px;
    		border: 1px solid #e0e0e0; /* 연한 회색 테두리 */
		}
		
		th {
		    background-color: #6076E8; /* 진한 파란색 배경 */
    		color: #ffffff; /* 흰색 글자 */
		}
		
		td {
		    background-color: #e3f2fd; /* 연한 하늘색 배경 */
		}
				
		input:focus {
		    background-color: #ffffff;
		}
		
		#yearSelect ,#monthSelect{
			width:7%;
		}

</style>
</head>
<body>
<div class="sidebar-container">
    <jsp:include page="../sideBar.jsp"></jsp:include>
</div>

<div class="content-body">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                          	     <div class="select-container">
						            <label for="yearSelect">연도 선택</label>
						            <select class="form-control" id="yearSelect">
						                <option value="">연도를 선택하세요</option>
						            </select>
						
						            <label for="monthSelect">월 선택</label>
						            <select class="form-control" id="monthSelect">
						                <option value="">연도를 먼저 선택하세요</option>
						            </select>
						        </div>
						        <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th scope="col">요일</th>
                                            <th scope="col">스탠다드룸</th>
                                            <th scope="col">슈페리어룸</th>
                                            <th scope="col">디럭스룸</th>
                                            <th scope="col">스위트룸</th>
                                        </tr>
                                    </thead>
                                    <tbody id="roomPirceList">
                                    
                                    </tbody>
                                </table>
                                                     
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
    populateYears();
    populateMonth();
    
    $('#yearSelect').on('change', function() {
    	populateMonth();
        listCall(); 
    });

    $('#monthSelect').on('change', function() {
        listCall(); 
    });
    
    listCall();
    
});


function populateYears() {
	var currentYear = new Date().getFullYear();
    var nextYear = currentYear + 1;

    var select = $('#yearSelect');
    select.empty();

    var option1 = $('<option></option>').val(currentYear).text(currentYear);
    var option2 = $('<option></option>').val(nextYear).text(nextYear);
    select.append(option1, option2);

    
}


function populateMonth(selectedYear) {
    var currentYear = new Date().getFullYear();
    var currentMonth = new Date().getMonth() + 1;

    var select = $('#monthSelect');
    select.empty();

    if ($('#yearSelect').val() == currentYear) {
        // 현재 연도인 경우 현재 월부터 12월까지 추가
        for (var month = currentMonth; month <= 12; month++) {
            var option = $('<option></option>').val(month).text(month);
            select.append(option);
        }
    } else {
        // 현재 연도가 아닌 경우 모든 월 추가
        for (var month = 1; month <= 12; month++) {
            var option = $('<option></option>').val(month).text(month);
            select.append(option);
        }
    }
    
}



function listCall() {
	
	var selectedYear = $('#yearSelect').val();
    var selectedMonth = $('#monthSelect').val();
	
    var formattedMonth = selectedMonth.padStart(2, '0')
    
    var year_month = selectedYear+'-'+formattedMonth;
   
	
	 $.ajax({
	        type: 'POST',
	        url: '/room/roomPirceList.ajax',
	        data:{
	        	year_month : year_month,
	        },
	        dataType: 'json',
	        success: function(data) {
	        	console.log(data);
	        	drawList(data.list);
	        },
	        error:function(e){
	        	console.log(e);
	        }
	 }) 
	 
	 
}	 

function drawList(list) {
    var roomContainer = $('#roomPirceList');
    roomContainer.empty();

    var content = '';

    content += '<tr>';
    content += '<th scope="row" style="background-color:#e3f2fd;"><input type="text" style="border:0px;" name="dd_division" value="Mon ~ Thu" readonly></th>';
    content += '<td><input type="text" class="A standard" id="standardA" value=""></td>';
    content += '<td><input type="text" class="A superior" id="superiorA" value=""></td>';
    content += '<td><input type="text" class="A delux" id="deluxA" value=""></td>';
    content += '<td><input type="text" class="A suite" id="suiteA" value=""></td>';
    content += '</tr>';

    // 금~토
    content += '<tr>';
    content += '<th scope="row" style="background-color:#e3f2fd;"><input type="text" style="border:0px;" name="dd_division" value="Fri ~ Sat" readonly></th>';
    content += '<td><input type="text" class="B standard" id="standardB" value=""></td>';
    content += '<td><input type="text" class="B superior" id="superiorB" value=""></td>';
    content += '<td><input type="text" class="B delux" id="deluxB" value=""></td>';
    content += '<td><input type="text" class="B suite" id="suiteB" value=""></td>';
    content += '</tr>';

    // 일욜
    content += '<tr>';
    content += '<th scope="row" style="background-color:#e3f2fd;"><input type="text" style="border:0px;" name="dd_division" value="Sun" readonly></th>';
    content += '<td><input type="text" class="C standard" id="standardC" value=""></td>';
    content += '<td><input type="text" class="C superior" id="superiorC" value=""></td>';
    content += '<td><input type="text" class="C delux" id="deluxC" value=""></td>';
    content += '<td><input type="text" class="C suite" id="suiteC" value=""></td>'; 
    content += '</tr>';
	
    $('#roomPirceList').html(content);
    // 리스트 데이터 채우기
    for (var item of list) {
        if (item.dd_division === 'A') {
            $('#standardA').val(item.standard);
            $('#superiorA').val(item.superior);
            $('#deluxA').val(item.delux);
            $('#suiteA').val(item.suite);
        } else if (item.dd_division === 'B') {
            $('#standardB').val(item.standard);
            $('#superiorB').val(item.superior);
            $('#deluxB').val(item.delux);
            $('#suiteB').val(item.suite);
        } else if (item.dd_division === 'C') {
            $('#standardC').val(item.standard);
            $('#superiorC').val(item.superior);
            $('#deluxC').val(item.delux);
            $('#suiteC').val(item.suite);
        }
    }
    $('input[type="text"]').focusin(function(){
		$(this).css({"background-color":"white"});
	});
    

    $('input[type="text"]').focusout(handleChange);
    $('input[type="text"]').keydown(function(e) {
        if (e.key === 'Enter') {
            handleChange.call(this, e);
        }
    });

    function handleChange(e) {
        $(this).css({"background-color": "lightgray"});
        console.log(e.target.defaultValue, ' -> ', e.target.value);

        var ddDivision = $(this).attr('class').split(' ')[0];
        var column = $(this).attr('class').split(' ')[1];
        var value = $(this).val();
        var pk = ddDivision + '-' + column;

        console.log('서버에 변경 요청', $(this));

        if (e.target.defaultValue != e.target.value) {
            reqUpdate(column, value, ddDivision);
        }
    }
   
}

function reqUpdate(col, val, ddDivision) {
	console.log('column ' + col + '/value ' + val + ' /ddDivision ' + ddDivision);
	
	var selectedYear = $('#yearSelect').val();
    var selectedMonth = $('#monthSelect').val();
    var formattedMonth = selectedMonth.padStart(2, '0');
    var year_month = selectedYear + '-' + formattedMonth;
	
    var data = {
            dd_division: ddDivision,
            column: col,
            value: val,
            year_month: year_month
        };
	console.log('보낼 데이터 : '+data);
    
         $.ajax({
            type: 'POST',
            url: '/room/saveRoomPriceList.ajax',
            data: data,
            dataType: 'json',
            success: function(data) {
                
                listCall();
            },
            error: function(e) {
                console.error(e);
            }
        }); 
    }

//drawList 끝 지점

/* function saveRoomPrice(ddDivision) {
	
	var selectedYear = $('#yearSelect').val();
    var selectedMonth = $('#monthSelect').val();
	
    var formattedMonth = selectedMonth.padStart(2, '0')
    
    var year_month = selectedYear+'-'+formattedMonth;
	
    var standard = $('#standard' + ddDivision).val();
    var superior = $('#superior' + ddDivision).val();
    var delux = $('#delux' + ddDivision).val();
    var suite = $('#suite' + ddDivision).val();

    var data = {
        dd_division: ddDivision,
        standard: standard,
        superior: superior,
        delux: delux,
        suite: suite,
        year_month:year_month
    };

    $.ajax({
        type: 'POST',
        url: '/room/saveRoomPriceList.ajax',
        data: data,
        dataType:'JSON',
        success: function(data) {
			listCall();
        },
        error: function(e) {
            console.error(e);
        }
    });
} */





</script>
</html>