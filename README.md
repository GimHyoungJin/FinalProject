# Movio(영화 예매 웹 서비스)
## 프로젝트 소개
영화 예매 서비스를 제공하기 위해 필요한 기능들을 JSP와 스프링부트를 <br>사용하여 구현했습니다.
+ 프로젝트 미리보기
<img src="https://github.com/user-attachments/assets/85a27c6b-9493-438a-ad8a-100c7cff2375" alt="메인화면" width="600" height="300" />

## 주요 페이지
메인페이지 : 현재 상영중인 영화의 순위를 실시간으로 보여주며, 다양한 메뉴 등을 <br>제공합니다.

마이페이지 : 예매 내역과 상품 구매내역 및 현재 보유한 교환권 등 개인 정보를 <br>확인하고 수정할 수 있습니다

영화 페이지 : 현재 상영중인 영화의 평점과 리뷰, 트레일러를 확인 할 수 있습니다.

상품 페이지 : 영화 교환권, 팝콘 및 콜라 등 다양한 상품 등을 구매하여 교환권 형태로<br>
제공합니다.

예매 페이지 : 실제 영화 예매와 동일하게 영화,상영관,날짜 등을 선택 후 좌석 선택을 하여<br> 구매까지 가능합니다.

결제 페이지 : 실제 신용카드 및 카카오 페이와 네이버 페이등 다양한 결제 수단으로<br>결제가 가능합니다.
## 기여한 파트
+ ERD 설계
+ 메인페이지 및 공통 프레임 구현

  + 각종 메뉴 및 정보를 보여주는 메인 페이지의 기능과 공통 프레임으로 사용되는 <br>메뉴바 및 top버튼을 구현
+ 로그인 및 회원 가입

  + 로그인과 회원가입은 구현된 검증 절차가 완료된 이후에 동작합니다.
  + 로그인은 DB에 저장된 ID와 비밀번호가 존재하고 값이 일치할 경우에만 로그인이<br>가능합니다.
  + 회원 가입은 ajax를 이용해 서버와 비동기 방식으로 통신하면서 이름, 비밀번호<br> 이메일 형식이 모두 올바른 지 검증하고 DB에 이미 존재하는 값이라면<br> 숨겨진 텍스트 박스를 통해 중복된 값임을 알려주는 메세지를 출력합니다.
+ 예매

  + 영화 리스트를 관람 연령대와 함께 출력
  + 리스트에서 영화를 선택하면 DB에 저장된 해당 영화에 대한 상영관데이터를 받아옵니다.
  + 영화리스트 선택, 상영관 선택, 날짜 선택, 상영 시간 선택으로 이루어진 4단계를<br> 모두 선택 후 로그인 시 좌석 페이지로 이동
  + 4단계 중 1개라도 선택되지 않으면 좌석 선택 버튼이 비활성화 되어 선택이 불가능
  + 로그인 하지 않았다면 좌석 선택 버튼시 로그인 모달창이 표시됨
 
+ 좌석

  +  성인, 청소년, 아동을 포함해 최대 6명까지 선택 가능
  +  선택한 인원 및 좌석 정보는 왼쪽과 하단에서 실시간으로 확인 가능
  +  좌석 색상을 구분하여 좌석 상태등을 쉽게 파악할 수 있게함
  +  예매 완료된 좌석은 흑색으로 처리되어 클릭되지 않도록 함
  +  최대 인원을 초과할 시 경고창을 표시하며 좌석 선택이 불가능
  +  남은 좌석 등을 ajax를 이용한 비동기 통신으로 실시간으로 업데이트함
  +  이전 페이지의 데이터는 세션에 저장되어 다음페이지에서도 유지됨
  +  결제가 완료되면 결제 성공 페이지에서 성공적으로 결제/예매가 완료 되었는지<br> 확인할 수 있으며 자세한 예매내역은 마이페이지에서도 확인이 가능
+ 결제

  + 아임포트를 사용하여 이니시스 및 카카오, 네이버 페이 결제 구현
  + Session을 사용하여 로그인된 유저가 선택한 정보를 가져와 결제 정보로 사용
  + 결제 완료 시 예매 내역등을 출력해주고 메인페이지로 이동함
+ 통합 문의

  + 1:1 문의와 분실물 문의 별 확인이 가능하고 전체 문의에서 문의 리스트를 보여줌
  + 통합 문의버튼 선택시 로그인 되어있지 않은 상태라면 로그인창 표시
  + 이름과 이메일 등 개인정보 수집 동의 후, 스마트 에디터를 이용하여<br> 문의글을 작성하며 이미지 업로드가 가능함
  + 문의 유형을 통해 문의를 나누고 비밀번호를 통해 게시글을 관리함<br>(확인은 작성자 본인과 관리자만 가능)
  + 관리자가 답변을 달면 작성과 동시에 답변 상태가 변경됨(진행중, 답변완료)
 
<img src="https://github.com/user-attachments/assets/83a400e9-c940-4869-a6e4-71ec4c44bc47" alt="로그인" width="700" height="500"/>

<img src="https://github.com/user-attachments/assets/862a024f-e384-4d99-b1c6-2a4f55524b9e" alt="토글 메뉴로 접근" width="700" height="500"/>

<img src="https://github.com/user-attachments/assets/9f67f729-7648-4a01-abd0-98d16fd275da" alt="회원가입" width="400" height="400"/>

<img src="https://github.com/user-attachments/assets/1acfa6b8-4370-426b-8a03-dd9f4710d10f" alt="회원가입2" width="400" height="400"/>

<img src="https://github.com/user-attachments/assets/a876d046-8b56-4cc9-a700-dbf9bd2160d5" alt="가입완료" width="800" height="600"/>

<img src="https://github.com/user-attachments/assets/c03bb7e4-2eee-442c-b69e-46fab2323ad6" alt="이미지 1" width="500" height="400"/>

<img src="https://github.com/user-attachments/assets/c908c3ca-6b3f-41d5-8f49-00c0fdb02dd1" alt="이미지" width="500" height="400"/>

<img src="https://github.com/user-attachments/assets/ab8e5c9f-07c5-4289-a628-20380681f299" alt="통합문의 통합본" width="900" height="500"/>



## 프로젝트 일정 및 참여 인원
+ 개발기간 : 2024.06.12 ~ 2024.07.24
+ 인원 : 5명

## 팀원
<img src="https://github.com/user-attachments/assets/fcd7acc0-c9d9-4027-b8a8-14ca3cb32718" alt="팀원소개" width="600" height="400"/>

<img src="https://github.com/user-attachments/assets/159f6733-5e96-40ce-975d-bb50cf6c5e06" alt="팀원소개2" width="600" height="400"/>

## 개발환경 
<img src="https://github.com/user-attachments/assets/d871431e-b7f5-492c-9795-3124ed7a02b1" alt="개발환경" width="500">

## 주요 화면구성
<img src="https://github.com/user-attachments/assets/bc912d91-97fc-4689-a801-e6c4e8f1c12f" alt="주요화면구성1" width="800" height="500"/>
<img src="https://github.com/user-attachments/assets/596596b7-6129-4852-aad8-e236a410835f" alt="주요화면구성2" width="800" height="500"/>
<img src="https://github.com/user-attachments/assets/8cad1416-42d8-423e-87dd-f4bcc2a8bbb1" alt="주요화면구성3" width="800" height="500"/>
<img src="https://github.com/user-attachments/assets/6455b01c-8eb1-4b6e-b6c4-0b3a49dfc439" alt="주요화면구성4" width="800" height="500"/>
<img src="https://github.com/user-attachments/assets/658c0f0f-f944-46b9-bb2b-6279b375adf1" alt="주요화면구성5" width="800" height="500"/>
<img src="https://github.com/user-attachments/assets/624c00c4-06e7-4aeb-815b-b848b36aa1e8" alt="주요화면구성6" width="800" height="500"/>
<img src="https://github.com/user-attachments/assets/ce83cbce-dd6f-4241-8393-84bda55eb70b" alt="주요화면구성7" width="800" height="500"/>
<img src="https://github.com/user-attachments/assets/39d79be2-6321-4159-8ad2-344422f048c3" alt="주요화면구성8" width="800" height="500"/>

## ERD
<img src="https://github.com/user-attachments/assets/1505a759-f973-4a33-9d7d-da0ecee7354e" alt="이미지" width="800" height="500"/>
