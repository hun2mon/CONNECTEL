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
        .form-groups {
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
            width: 320px;
            text-align: center;
            margin: 0 auto;
        }
        .photo img {
            max-width: 100%;
            height: auto;
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
        	width: 30px;
        }
        .upload{
        	text-align : center;
        	margin-left : 130px;
        }
        img#imgPreview {
		    width: 100%;
		    height: 100%;
		}
	    .input-container {
	      position: relative;
	      display: inline-block;
	    }
	    .input-container input {
	      padding-right: 40px; /* 이미지의 크기만큼 여유 공간 추가 */
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
<form action="/empRegist.do" method="post" onsubmit="return validateForm()" enctype="multipart/form-data">
    <div class="parent">
        <div class="sidebar">
            <jsp:include page="../sideBar.jsp"></jsp:include>
        </div>
        <div class="content">
		    <input type="hidden" name="pho_division" value="P">
		    <div class="photo">
		        <img id="imgPreview" src="/assets/images/photoexp.jpg" alt="이미지를 업로드하세요">
		    </div>
		    <br>
		    <div class="upload">
		        <input type="file" name="photos" id="imgUpload" accept="image/*"/>
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
                <input type="date" class="form-control" id="birth" name="birth" required>
                <span class="subject">이메일</span>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
				<div class="form-group">
					<span class="subject">우편번호</span>
					 <input type="text" name="post_no" class="form-control" id="sample6_postcode"
               			placeholder="우편번호" value="${emp.post_no}"  required onclick="sample6execDaumPostcode()" readonly="readonly">
					
					<span class="subject">전화번호</span> <input type="text"
						class="form-control" id="phone" name="phone" value="${emp.phone}"
						required>
				</div>
            <div class="form-group">
                <span class="subject">주소</span>
                <input class="form-control" name = "address" type="text" id="sample6_address" placeholder="주소" required onclick="sample6execDaumPostcode()" readonly="readonly">
                <span class="subject">부서</span>
                <select class="form-control" id="dept_code" name="dept_code" required>
                    <option value="">대기상태</option>            
                    <option value="11">인사팀</option>
                    <option value="22">시설팀</option>
                    <option value="33">고객팀</option>
                </select>
            </div>  
            <div class="form-group">
                <span class="subject">상세주소</span>
                <input class="form-control" name = "detail_address" type="text" id="sample6_extraAddress" placeholder="상세주소" required>
                <span class="subject">직급</span>
                <select class="form-control" id="rank_code" name="rank_code" required>
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
                <select class="form-control" id="bank_name" name="bank_name" required>
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
                <select class="form-control" id="authority" name="authority" required>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                </select>
            </div> 
            <div class="form-group">
                <span class="subject">계좌번호</span>
                <input type="text" class="form-control" id="account_no" name="account_no" required>
                <span class="subject">입사일</span>
                <input type="date" class="form-control" id="join_date" name="join_date" required>
            </div> 
            <br><br>
                <div class="btnParent">                             
                    <button class="btn waves-effect waves-light btn-primary" type="submit" onclick="return validateForm()">사원등록</button>
                </div>                                            
        </div>
    </div>
</form>
<script>

function validateForm() {
    var name = document.getElementById('name').value;
    var gender = document.querySelector('input[name="gender"]:checked');
    var dob = document.getElementById('birth').value;
    var email = document.getElementById('email').value;
    var postcode = document.getElementById('sample6_postcode').value;
    var phone = document.getElementById('phone').value;
    var address = document.getElementById('sample6_address').value;
    var department = document.getElementById('dept_code').value;
    var detailAddress = document.getElementById('sample6_extraAddress').value;
    var position = document.getElementById('rank_code').value;
    var bank = document.getElementById('bank_name').value;
    var permission = document.getElementById('authority').value;
    var account = document.getElementById('account_no').value;
    var joinDate = document.getElementById('join_date').value;

    // 정규식 패턴 설정 (010-xxxx-xxxx 형식)
    if (name == "" || !gender || dob == "" || email == "" || postcode == "" || phone == "" || address == "" ||
        department == "" || detailAddress == "" || position == "" || bank == "" || permission == "" || account == "" || joinDate == "") {
        alert("모든 필드를 작성해 주세요.");
        return false;
    }

    var phonePattern = /\d{3}-\d{3,4}-\d{4}/;
    if (!phonePattern.test(phone)) {
        alert("유효한 전화번호를 입력해주세요 ex) 010-xxxx-xxxx.");
        return false;
    }
    
    var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
        alert("유효한 이메일 주소를 입력해 주세요. ex) xxxx@naver.com");
        return false;
    }

    return true;
}

document.addEventListener('DOMContentLoaded', function() {
    // 전화번호 입력 필드에 입력되는 값을 xxx-xxxx-xxxx 형식으로 제한하기
    var phoneInput = document.getElementById('phone');

    phoneInput.addEventListener('input', function() {
        // 입력된 내용에서 숫자만 남기기
        var cleaned = phoneInput.value.replace(/\D/g, '');
        
        // xxx-xxxx-xxxx 형식으로 포맷팅
        var formatted = '';
        if (cleaned.length > 0) {
            formatted = cleaned.substring(0, 3);
        }
        if (cleaned.length > 3) {
            formatted += '-' + cleaned.substring(3, 7);
        }
        if (cleaned.length > 7) {
            formatted += '-' + cleaned.substring(7, 11);
        }

        // 형식에 맞는 전화번호를 입력 필드에 설정
        phoneInput.value = formatted;
    });
});


function sample6execDaumPostcode() {
	new daum.Postcode(
			{
				oncomplete : function(data) {
					var addr = ''; // 주소 변수
					var extraAddr = ''; // 참고항목 변수

					//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						addr = data.roadAddress;
					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						addr = data.jibunAddress;
					}

					// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
					if (data.userSelectedType === 'R') {
						if (data.bname !== ''
								&& /[동|로|가]$/g.test(data.bname)) {
							extraAddr += data.bname;
						}
						if (data.buildingName !== ''
								&& data.apartment === 'Y') {
							extraAddr += (extraAddr !== '' ? ', '
									+ data.buildingName
									: data.buildingName);
						}
						if (extraAddr !== '') {
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

document.getElementById('imgUpload').onchange = function(e) {
    var input = e.target;
    var reader = new FileReader();
    reader.onload = function() {
        var dataURL = reader.result;
        var output = document.getElementById('imgPreview');
        output.src = dataURL;
    };
    reader.readAsDataURL(input.files[0]);
}

    
</script>
</body>
</html>
