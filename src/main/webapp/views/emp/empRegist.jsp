<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
    <style>
        .submit {
            margin-right: 30px;
            width: 150px;
            height: 40px;
        }
        .btnParent {
            text-align: right;
        }
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
        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .form-control {
            flex: 1;
        }
        .photo {
            margin-top: 20px;
            border: 1px solid black;
            padding: 10px;
            height: 400px;
            width: 250px;
            text-align: center;
            margin: 0 auto;
        }
        .gender {
            text-align: center;
        }
        .gender input {
            margin: 0 5px; /* 라디오 버튼 사이의 간격 조정 */
        }
        /* 미디어 쿼리: 화면 너비가 작아질 때 입력 상자 너비 조정 */
        @media (max-width: 800px) {
            .form-control {
                max-width: 200px; /* 화면이 작을 때 더 작은 너비로 조정 */
            }
        }
        #postBtn{
        	width: auto;
        }
    </style>
</head>
<body>
<form action="empRegist.do" method="post" onsubmit="return validateForm()">
    <div class="parent">
        <div class="sidebar">
            <jsp:include page="../sideBar.jsp"></jsp:include>
        </div>
        <div class="content">
            <div class="photo">
                <div>중앙에 위치한 사진 또는 콘텐츠</div>
            </div>
            <br><br>
            <div class="form-group">
                <span class="subject">이름</span>
                <input type="text" class="form-control" id="name" name="name" required>
                <span class="subject">성별</span>
                <div class="form-control gender">
                    <input type="radio" name="gender" value="남" required> 남
                    <input type="radio" name="gender" value="여"> 여
                </div>
            </div>
            <div class="form-group">
                <span class="subject">생년월일</span>
                <input type="date" class="form-control" id="dob" name="dob" required>
                <span class="subject">이메일</span>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="form-group">
                <span class="subject">우편번호</span>
                <input type="text" class="form-control" id="sample6_postcode" placeholder="우편번호" required>
                <input type="button" id = "postBtn" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
                <span class="subject">전화번호</span>
                <input type="text" class="form-control" id="phone" name="phone" required>
            </div>
            <div class="form-group">
                <span class="subject">주소</span>
                <input class="form-control" type="text" id="sample6_address" placeholder="주소" required>
                <span class="subject">부서</span>
                <select class="form-control" id="department" name="department" required>
                    <option value="">대기상태</option>            
                    <option value="11">인사팀</option>
                    <option value="22">시설팀</option>
                    <option value="33">고객팀</option>
                </select>
            </div>  
            <div class="form-group">
                <span class="subject">상세주소</span>
                <input class="form-control" type="text" id="sample6_extraAddress" placeholder="상세주소" required>
                <span class="subject">직급</span>
                <select class="form-control" id="position" name="position" required>
                    <option value="">대기상태</option>
                    <option value="6">사원</option>
                    <option value="5">대리</option>
                    <option value="4">과장</option>
                    <option value="3">팀장</option>
                    <option value="2">이사</option>
                    <option value="1">사장</option>
                </select>
            </div>  
            <div class="form-group">
                <span class="subject">은행</span>
                <select class="form-control" id="bank" name="bank" required>
                    <option value=""></option>
                    <option value="하나은행">하나은행</option>
                    <option value="신한은행">신한은행</option>
                    <option value="국민은행">국민은행</option>
                    <option value="카카오뱅크">카카오뱅크</option>
                    <option value="토스뱅크">토스뱅크</option>
                    <option value="농협은행">농협은행</option>
                    <option value="기업은행">기업은행</option>                    
                </select>
                <span class="subject">권한</span>
                <select class="form-control" id="permission" name="permission" required>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                </select>
            </div> 
            <div class="form-group">
                <span class="subject">계좌번호</span>
                <input type="text" class="form-control" id="account" name="account" required>
                <span class="subject">입사일</span>
                <input type="date" class="form-control" id="join_date" name="join_date" required>
            </div> 
            <br><br>
                <div class="btnParent">                             
                    <button class="submit" type="submit" onclick="return validateForm()">사원등록</button>
                </div>                                            
        </div>
    </div>
</form>
<script>
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
        }
    }).open();
}

function validateForm() {
    var name = document.getElementById('name').value;
    var gender = document.querySelector('input[name="gender"]:checked');
    var dob = document.getElementById('dob').value;
    var email = document.getElementById('email').value;
    var postcode = document.getElementById('sample6_postcode').value;
    var phone = document.getElementById('phone').value;
    var address = document.getElementById('sample6_address').value;
    var department = document.getElementById('department').value;
    var detailAddress = document.getElementById('sample6_detailAddress').value;
    var position = document.getElementById('position').value;
    var bank = document.getElementById('bank').value;
    var permission = document.getElementById('permission').value;
    var account = document.getElementById('account').value;
    var joinDate = document.getElementById('join_date').value;

    if (name == "" || !gender || dob == "" || email == "" || postcode == "" || phone == "" || address == "" ||
        department == "" || detailAddress == "" || position == "" || bank == "" || permission == "" || account == "" || joinDate == "") {
        alert("모든 필드를 작성해 주세요.");
        return false;
    }

    var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
        alert("유효한 이메일 주소를 입력해 주세요.");
        return false;
    }

    var phonePattern = /^\d{10,11}$/;
    if (!phonePattern.test(phone)) {
        alert("유효한 전화번호를 입력해 주세요.");
        return false;
    }

    return true;
}
</script>
</body>
</html>
