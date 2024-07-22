## 👨‍🏫 프로젝트 소개
기존에 있는 그룹웨어 서비스에 추가로 CONNECTEL만의 특색을 살려 고객 이용 사이트와 실시간 객실 모니터링, 예약 투숙 관리, 객실 관리 서비스를 개발하였습니다.

## ⏲️ 개발 기간 
- 2024년 06월 03일 ~ 2024년 07월 17일

## 💻 개발환경
- **DBMS** : MariaDB
- **Server** : Apache Tomcat 9
- **개발 언어** : Java, JSP, CSS, JavaScript, jQuery, JSTL
- **라이브러리 및 기술** : Servlet, JSP, Spring, MyBatis

## ⚙️ DB 설계
![2조 ERD](https://github.com/user-attachments/assets/8647c110-a499-4105-ab59-4fa9c1643053)


## 📌 주요 기능
📄 전자결재

🛌 실시간 객실 모니터링

🏨 객실 관리

👨‍👩‍👦 예약 및 투숙관리

      
## ✒️ 담당 기능
##### 1. AWS(EC2)를 사용하여 인프라 구축 및 DB서버 생성

##### 2. 공통 기능에 대한 API 개발

- download() / upload() 메서드를 활용하여 파일 다운로드/업로드 기능을 공통적으로 사용할 수 있도록 구현
- treeCall() 메서드를 활용하여 조직도 데이터를 불러올 수 있도록 구현

##### 3. 전자결재 시스템 구현

##### 4. 메신저 시스템 구현


## 👍 구현기능 소개

### ${\textsf{\color{blue}[전자결재] 결재자 지정 팝업}}$
![결재선 지정 2](https://github.com/user-attachments/assets/e5e7213e-a2ff-4d9d-a48f-fa867137037a)
1. 조직도를 활용한 결재자 지정
    - 조직도 API를 활용해 조직도를 불러온 후 클릭시 결재자로 지정할 수 있게 구현
    - 확인 버튼 클릭 시 결재자로 지정된 사원의 정보를 json배열을 통해 부모jsp로 데이터 전송되게 구현
2. 결재 순서 변경
    - 체크 박스 클릭 후 결재 순서 변경
    - 체크 박스 여러개 체크시 modal창 출력
3. 결재자 삭제
    - 결재자 전체 삭제, 선택 삭제 구현
4. 결재선 저장
    - 자주 사용하는 결재선은 결재선 이름 입력 후 저장 기능 구현
    - 결재선 tap에서 확인 가능

### ${\textsf{\color{blue}[전자결재] 기안서 작성}}$
![기안서 작성1](https://github.com/user-attachments/assets/a1bcc1ab-3366-46f4-a897-bdfdb052ef78)
![기안서 작성 2](https://github.com/user-attachments/assets/91b0a57f-0d23-4379-a725-ad66ac156c83)
1. 결재자 참조자 지정
    - 개인 혹은 팀별로 선택 가능
2. 에디터 및 파일첨부
    - RichTextEditor 활용하여 필요에 따라 내용 보충 가능하게 구현
    - 파일첨부 기능 구현
3. 기안서 작성
    - 작성 완료시 기안서의 정보를 복잡한 json 형태로 controller 전달

### ${\textsf{\color{blue}[전자결재] 내 기안서 / 반려문서 재기안}}$
![내 기안서1](https://github.com/user-attachments/assets/c9fb2a51-fece-4695-8ea3-ab7118dbb2c2)
1. 기안서 리스트 출력
    - 자신이 작성한 기안서 리스트 구현
    - 기안서 상태별로 tap구분 구현
    - 검색/페이징 기능 구현
2. 반려 기안서
    - 반려 기안서는 반려 사유 확인 기능 구현
    - 반려문서 재기안시 문서 양식 그대로 사용하여 기안서 작성 기능 구현

### ${\textsf{\color{blue}[전자결재] 결재 문서 / 임시저장 문서}}$
![내 기안서 2](https://github.com/user-attachments/assets/512055be-e2bd-492e-b6b9-0b44e07fe394)
1. 결재 문서
    - 결재문서 상세보기 구현
    - 결재문서 PDF 다운로드 구현
2. 임시저장 문서
    - 임시서장 기능 구현
    - 임시저장 문서의 경우 작성한 양식 을 바탕으로 기안서 작성 가능

### ${\textsf{\color{blue}[전자결재] 결재 요청 문서 / 기안서 결재}}$
![Jul-18-2024 18-19-50](https://github.com/user-attachments/assets/51233f04-5618-4231-ba89-7478149b1b88)
1. 결재 요청 문서
    - 결재자로 지정된 경우 결재 요청 문서 리스트에 출력 구현
    - 반려 사유 입력 후 반려 기능 구현
    - 기안서 결재 기능 구현
2. 기안서 결재
    - 기안서 상세 정보 확인 기능 구현
    - 반려 사유 입력 후 반려 기능 구현
    - 기안서 결재 기능 구현

### ${\textsf{\color{blue}[전자결재] 열람 가능 문서}}$
![열람 가능 문서](https://github.com/user-attachments/assets/fcf4f1fc-6a46-4c03-ad03-79f2211ad029)
1. 열람 가능 문서
    - 참조자인지 조회자인지에 따라 열람 가능한 기안서 리스트 출력 구현
    - 참조자는 결재과정 전체 단계에서 기안서 열람이 가능하도록 구현
    - 조회자는 결재가 완료된 기안서만 열람 가능하도록 구현

### ${\textsf{\color{blue}[메신저] 채팅방 생성}}$
![메신저](https://github.com/user-attachments/assets/d78cecf7-be22-4d4b-9e01-8ac4ceb2da90)
***WebSocket 과 STOMP를 사용하여 구현**
1. 채팅방 목록
    - 참여중인 채팅방 목록 출력
    - 채팅방의 마지막 메세지 확인 가능
    - 읽지 않은 메세지가 있을시 표시
2. 채팅방 생성
    - 채팅 할 직원, 채팅방 이름 선택 후 생성 기능 구현
    - 채팅방 참여인원 확인 가능
    - 자신이 원하는 채팅방 이름 설정 가능
    - 채팅방 인원 추가 가능

### ${\textsf{\color{blue}[메신저] 채팅}}$
![메신저2](https://github.com/user-attachments/assets/6b13b027-c86c-4b7a-8b45-51fb108f4e51)
***WebSocket 과 STOMP를 사용하여 구현**
1. 실시간 채팅 기능
    - 채팅 메세지 전송 시 실시간으로 확인 가능
    - 이미지 전송/다운로드 기능 구현
    - 파일 전송/다운로드 기능 구현

## 😊 프로젝트 참여소감
- 1차때 부족했던 공통적인 기능에 대한 코드 중복을 줄이기 위해 공통 부분에 대해 먼저 API를 개발하여 진행하였고, 보다 깔끔하고 간결하게 코드를 사용할 수 있었다.
- 그룹웨어를 사용해 본적이 없어서 처음엔 막막했지만 개발을 위해 조사를 하면서 개발은 하여 평소에는 생각해보지 못한 로직과 기능들을 개발 할 수 있어서 좋았다.
- WebSocket과 STOMP를 사용하기 위해 찾아보니 당시에 배우지 않은 vue.js를 사용한 예시가 많아서 ajax를 사용해 나의 기술에 맞게 변경하여 사용하는 과정에서 코드 해석 능력에 도움이 되었다.

## 🚨 트러블 슈팅
EC2에 서버를 구성하기 위해 설정하던중, 계속하여 CPU 사용률이 높아져 인스턴스가 멈춤 → 프리티어 EC2 의 t2.micro 의 경우 RAM이 1GB밖에 되지 않아 간단한 작업에도 CPU 사용률이 높아졌음. SWAP 메모리를 할당하여 문제 해결
