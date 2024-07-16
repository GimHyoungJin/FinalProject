<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>이용약관</title>
  <meta charset="utf-8">
  <!-- 공통 시작 -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
  <!-- 공통 끝 -->	
  
  <link href="<c:url value='/css/customer/customer_sidebar.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/terms.css' />" rel="stylesheet" type="text/css">
  <script src="<c:url value='/js/terms.js' />"></script>
</head>
<body>
	<%@ include file="../../header.jsp"%>
	<!-- 사이드바 포함 부분 -->
	<div id="container">
  <!-- row 클래스를 이용하여 행을 생성 -->
  <div class="row">
    <!-- 사이드바를 포함하는 div 요소 -->
    <div id="sidebar">
      <%@ include file="customer_sidebar.jsp"%>
      <!-- customer_sidebar.jsp 파일을 포함하여 사이드바를 로드 -->
    </div>
    <!-- 이용약관 내용을 포함하는 div 요소 -->
    <div id="terms-content" class="col-md-9">
      <!-- col-md-9 클래스를 이용하여 Bootstrap 그리드 시스템에서 9개의 컬럼을 차지 -->
      <!-- terms-wrapper 클래스의 div 요소로 약관 내용 감싸기 -->
      <div class="terms-wrapper">
        <!-- 중앙 정렬된 제목을 표시 -->
        <h1 class="text-center">이용약관</h1>
        <!-- 약관 항목 리스트를 포함하는 div 요소 -->
        <div id="terms-list" class="terms-list mb-4 text-center">
          <!-- mb-4 클래스를 이용하여 하단 마진을 추가, text-center 클래스를 이용하여 텍스트 중앙 정렬 -->
          <!-- 첫 번째 컬럼을 포함하는 div 요소 -->
          <div class="column">
            <!-- nav flex-column 클래스를 이용하여 세로 방향 네비게이션 메뉴 생성 -->
            <ul class="nav flex-column">
            <li class="nav-item"><a class="nav-link" href="#article1">제1조. 목적</a></li>
            <li class="nav-item"><a class="nav-link" href="#article2">제2조. 약관의 효력 및 변경</a></li>
            <li class="nav-item"><a class="nav-link" href="#article3">제3조. 약관의 준수</a></li>
            <li class="nav-item"><a class="nav-link" href="#article4">제4조. 이용자의 의무</a></li>
            <li class="nav-item"><a class="nav-link" href="#article5">제5조. 이용 계약의 성립</a></li>
            <li class="nav-item"><a class="nav-link" href="#article6">제6조. 이용신청</a></li>
            <li class="nav-item"><a class="nav-link" href="#article7">제7조. 이용신청의 승낙</a></li>
            <li class="nav-item"><a class="nav-link" href="#article8">제8조. 개인정보의 보호</a></li>
            <li class="nav-item"><a class="nav-link" href="#article9">제9조. 개인정보의 이용</a></li>
            <li class="nav-item"><a class="nav-link" href="#article10">제10조. 계약사항의 변경</a></li>
            <li class="nav-item"><a class="nav-link" href="#article11">제11조. 회사의 의무</a></li>
            <li class="nav-item"><a class="nav-link" href="#article12">제12조. 회원의 의무</a></li>
            <li class="nav-item"><a class="nav-link" href="#article13">제13조. 회원의 특전</a></li>
        </ul>
    </div>
    <div class="column">
        <ul class="nav flex-column">
            <li class="nav-item"><a class="nav-link" href="#article14">제14조. 정보의 제공</a></li>
            <li class="nav-item"><a class="nav-link" href="#article15">제15조. 자격 상실 및 회원 서비스 혜택 제한</a></li>
            <li class="nav-item"><a class="nav-link" href="#article16">제16조. 회원의 게시물</a></li>
            <li class="nav-item"><a class="nav-link" href="#article17">제17조. 게시물의 저작원</a></li>
            <li class="nav-item"><a class="nav-link" href="#article18">제18조. 저작권의 보호</a></li>
            <li class="nav-item"><a class="nav-link" href="#article19">제19조. 광고게재 및 광고주와의 거래</a></li>
            <li class="nav-item"><a class="nav-link" href="#article20">제20조. 서비스 이용 책임</a></li>
            <li class="nav-item"><a class="nav-link" href="#article21">제21조. 서비스 제공의 중지 등</a></li>
            <li class="nav-item"><a class="nav-link" href="#article22">제22조. 계약 해지 및 이용 제한</a></li>
            <li class="nav-item"><a class="nav-link" href="#article23">제23조. 손해배상</a></li>
            <li class="nav-item"><a class="nav-link" href="#article24">제24조. 면책조항</a></li>
            <li class="nav-item"><a class="nav-link" href="#article25">제25조. 약관변경</a></li>
            <li class="nav-item"><a class="nav-link" href="#article26">제26조. 관할법원</a></li>
            <li class="nav-item"><a class="nav-link" href="#article27">기타. 부칙</a></li>
        </ul>
    </div>
</div>

					<div id="terms-article" class="terms-content">
						<div class="article-box">
							<h2 id="article1" class="terms-article-title">제1조. 목적</h2>
							<p class="terms-article-text">본 약관은 무비오(주)(이하 "회사"라 합니다)가
								제공하는 온라인, 오프라인 서비스(이하 "서비스"라 합니다) 이용과 관련하여 회사와 이용자의 권리, 의무 및
								책임사항을 규정함을 목적으로 합니다.</p>

							<h2 id="article2" class="terms-article-title">제2조. 약관의 효력 및
								변경</h2>
							<p class="terms-article-text">
								1. 본 약관은 서비스를 이용하고자 본 약관에 동의한 모든 회원에 대하여 그 효력을 발생합니다.<br>
								2. 본 약관의 내용은 회원(서비스)가입 시 게재되거나 공지된 내용에 회원이 동의함으로써 그 효력이 발생합니다.<br>
								3. 회사는 합리적인 사유가 발생될 경우 본 약관을 변경(수정 또는 개정)할 수 있으며, 약관을 개정할 경우 회사는
								시행일 및 개정 사유를 명시하여 현행 약관과 함께 시행일로부터 최소 7일 전, 고객에게 불리하게 변경되거나 중요한
								내용인 경우에는 최소 30일 전에 회사의 웹사이트 또는 전자메일 등을 통해 공지합니다.<br> 4. 회원은
								변경된 약관에 동의하지 않을 경우 회원 탈퇴를 요청할 수 있으며, 변경된 약관의 효력 발생일 이후 탈퇴 요청을 하지
								않을 경우 약관의 변경 사항에 동의한 것으로 간주됩니다.
							</p>

							<h2 id="article3" class="terms-article-title">제3조. 약관외 준수</h2>
							<p class="terms-article-text">
								1. 본 약관에 명시되지 아니한 사항에 대해서는 전자상거래 등에서의 소비자보호에 관한 법률, 정보통신망 이용촉진 및
								정보보호 등에 관한 법률 및 기타 관련 법령의 규정에 따릅니다.<br> 2. 본 약관에 명시되지 않은
								서비스에 대한 사항은 당사 홈페이지, 모바일 또는 영화관 현장을 통한 해당 서비스 공지사항에 따릅니다.
							</p>

							<h2 id="article4" class="terms-article-title">제4조. 용어의 정의</h2>
							<p class="terms-article-text">
								본 약관에서 사용하는 주요한 용어의 정의는 다음과 같습니다.<br> 1. "사이트" : 회사가
								재화·용역·정보를 회사에게 제공하기 위하여 컴퓨터 등 정보통신 설비를 이용하여 재화·용역을 거래할 수 있도록 설정한
								가상의 영업장 또는 회사가 운영하는 웹사이트(홈페이지, 모바일 웹/어플리케이션, SNS 등)를 말하며, 아울러
								사이트를 운영하는 사업자의 의미로도 사용합니다.<br> 2. "회원" : 본 약관을 인지하고,
								본인인증절차를 거쳐 회사에 개인정보를 제공하여 회원으로서 등록하여 회사 아이디(ID)와 멤버십 카드를 부여 받은
								자로서, 정상적으로 무비오 서비스를 이용할 수 있는 권한을 부여 받은 고객을 말합니다.<br> 3.
								"아이디" : 회원의 식별과 회원의 서비스 이용을 위하여 회원이 선정하고 회사가 승인하는 문자나 숫자 혹은 그
								조합을 말합니다(이하"ID"라 합니다).<br> 4. "비밀번호" : 회원이 부여 받은 ID와 일치된
								회원임을 확인하고, 회원 자신의 비밀을 보호하기 위하여 회원이 정한 문자와 숫자의 조합을 말합니다.<br>
								5. "서비스" : 회사가 회원을 위하여 유료 또는 무료로 제공하는 행위 또는 그 행위 대상인 유, 무형의 물건
								자체를 의미하며 온/오프라인에서 이루어지는 영화 관람, 포인트 적립, 사용, 할인, 이벤트 참여 등의 전반적인 고객
								서비스 프로그램을 말합니다.<br> 6. "멤버십 포인트" : 회사에서 재화/서비스 구매 시 적립/사용이
								가능하도록 제공하는 포인트를 말합니다.<br> 7. "이용중지" : 회사가 약관에 의거하여 회원의 서비스
								이용을 제한하는 것을 말합니다.<br> 8. "해지" : 회사 또는 회원이 서비스 사용 후 이용계약을
								해약하는 것을 말합니다.
							</p>
							<h2 id="article5" class="terms-article-title">제5조. 회원 가입 및
								카드 발급</h2>
							<p class="terms-article-text">
								1. 회원 가입은 회사가 운영하는 사이트를 통해 가능하며, 서비스 가입 신청 시 본 약관과 개인정보
								처리방침(‘개인정보수집 및 이용안내’ 및 ‘마케팅 활용 동의’ 등)에 동의함으로써 회원 가입을 신청합니다.<br>
								2. 고객으로부터 회원 가입 신청이 있는 경우 회사는 자체 기준에 따른 심사를 거친 후 고객에게 회원 자격을 부여
								할 수 있으며 회원 자격이 부여된 고객은 회사로부터 가입 완료 공지를 받은 시점부터 회원으로서의 지위를 취득하고
								멤버십 카드를 즉시 발급받을 수 있습니다.<br> 3. 관계 법령에 따라 만14세 미만의 아동은 온라인으로
								타인에게 개인정보를 보내기 전에 반드시 개인정보의 수집 및 이용목적에 대하여 충분히 숙지하고 법정대리인(부모)의
								동의를 받아야 합니다.
							</p>
							<h2 id="article6" class="terms-article-title">제6조. 멤버십 카드의
								이용 및 관리</h2>
							<p class="terms-article-text">
								1. 회원이 서비스를 이용하고자 할 경우에는 멤버십 카드를 제시하여야 합니다. 카드를 제시할 경우 회사는 회원에게
								본인 확인을 위한 식별 절차를 요청할 수 있습니다. 이 경우 회원은 회사의 요청을 준수하여야 정상적인 서비스를
								제공받을 수 있습니다.<br> 2. 멤버십 카드는 회원 본인이 직접 사용하여야 하며, 카드를 제3자에게
								임의적으로 대여 사용하게 하거나 양도 또는 담보의 목적으로 사용 할 수 없습니다.<br> 3. 전항의
								규정에도 불구하고, 회원이 당사의 사전 동의 없이 멤버십 카드를 타인에게 대여하거나, 그 사용을 위임하거나, 양도
								또는 담보의 목적으로 제공함으로써 발생한 손해와 타인이 멤버십 카드를 사용할 수 있음을 알았거나 쉽게 알 수
								있었음에도 불구하고 멤버십 카드를 방치함으로써 발생한 손해에 대하여는 회사는 어떠한 책임도 지지 않습니다.
							</p>
							<h2 id="article7" class="terms-article-title">제7조. 회원 탈퇴 및
								자격 상실</h2>
							<p class="terms-article-text">1. 회원이 이용 계약을 해지(탈퇴) 하고자 하는
								경우에는 회원 본인이 사이트나 무비오 고객센터 또는 E-MAIL등 기타 회사가 정하는 방법으로 회원탈퇴 또는
								이용약관 철회를 요청할 수 있으며, 회사는 회원의 요청에 따라 조속히 회원 탈퇴에 필요한 제반 절차를 수행합니다.
							</p>
							<h2 id="article8" class="terms-article-title">제8조. 회원에 대한 통지</h2>
							<p class="terms-article-text">
								1. 당사가 회원에 대한 통지를 하는 경우, 회원이 당사와 미리 약정하여 지정한 E-MAIL 주소, SMS,
								PUSH메세지 등으로 할 수 있습니다.<br> 2. 회사는 보다 나은 서비스 혜택 제공을 위해 다양한 전달
								방법(안내문, E-MAIL, SMS 등)을 통해 서비스 관련 정보를 제공할 수 있습니다.<br> 단,
								회사는 회원이 서비스 혜택 정보 제공을 원치 않는다는 의사를 밝히는 경우 정보 제공 대상에서 해당 회원을 제외하여야
								하며, 대상에서 제외되어 서비스 정보를 제공 받지 못해 불이익이 발생하더라도 이에 대해서는 회사가 책임지지
								않습니다.<br> 3. 당사는 불특정다수 회원에 대한 통지의 경우 1주일 이상 사이트 공지사항에
								게시함으로써 개별 통지에 갈음할 수 있습니다.
							</p>
							<h2 id="article9" class="terms-article-title">제9조. 회원 정보의 변경</h2>
							<p class="terms-article-text">
								1. 회원은 개인정보 처리방침를 통해 언제든지 본인의 개인정보를 열람하고 수정할 수 있습니다.<br> 2.
								회원은 이용 신청 시 기재한 사항이 변경되었을 경우 온라인으로 직접 수정을 하거나, 0000-0000으로 연락하시어
								수정 요청을 해야 하며, 회원정보를 변경하지 아니하여 발생되는 문제의 책임은 회원에게 있습니다.
							</p>
							<h2 id="article10" class="terms-article-title">제10조. 회사의 의무</h2>
							<p class="terms-article-text">
								1. 회사는 특별한 사정이 없는 한 회원이 서비스 이용을 신청한 날에 서비스를 이용할 수 있도록 합니다.<br>
								2. 회사는 본 약관에서 정한 바에 따라 계속적이고 안정적인 서비스의 제공을 지속적으로 노력하며, 설비에 장애가
								생기거나 멸실 된 때에는 지체 없이 이를 수리 복구하여야 합니다. 다만, 천재지변, 비상사태 또는 그 밖에 부득이한
								경우에는 그 서비스를 일시 중단하거나 중지할 수 있습니다.<br> 3. 회사는 회원으로부터 소정의 절차에
								의해 제기되는 의견이나 불만이 정당하다고 인정할 경우에는 적절한 절차를 거처 처리하여야 합니다. 처리 시 일정
								기간이 소요될 경우 회원에게 그 사유와 처리 일정을 알려주어야 합니다.<br> 4. 회사는 회원의 개인정보
								수집 및 이용에 관련 하여 ‘개인정보처리방침’을 준수합니다.<br> 5. 회사는 본 약관의 체결,
								계약사항의 변경 및 해지 등 이용고객과의 계약 관련 절차 및 내용 등에 있어 이용고객에게 편의를 제공하도록
								노력합니다.
							</p>
							<h2 id="article11" class="terms-article-title">제11조. 회원의 의무</h2>
							<p class="terms-article-text">
								1. 회원은 이 약관에서 규정하는 사항과 이용안내 또는 공지사항 등을 통하여 회사가 공지하는 사항을 준수하여야
								하며, 기타 회사의 업무에 방해되는 행위를 하여서는 안됩니다.<br> 2. 회원의 ID와 비밀번호에 관한
								모든 관리책임은 회원에게 있습니다. 회원에게 부여된 ID와 비밀번호의 관리 소홀, 부정 사용에 의하여 발생하는 모든
								결과에 대한 책임은 회원에게 있습니다.<br> 3. 회원은 자신의 ID나 비밀번호가 부정하게 사용되었다는
								사실을 발견한 경우에는 즉시 회사에 신고하여야 하며, 신고를 하지 않아 발생하는 모든 결과에 대한 책임은 회원에게
								있습니다.<br> 4. 회원은 회사의 사전승낙 없이는 서비스를 이용하여 영업활동을 할 수 없으며, 그
								영업활동의 결과와 회원이 약관에 위반한 영업활동을 하여 발생한 결과에 대하여 회사는 책임을 지지 않습니다. 회원은
								이와 같은 영업활동으로 회사가 손해를 입은 경우 회원은 회사에 대하여 손해배상의무를 집니다.<br> 5.
								회원은 회사의 명시적인 동의가 없는 한 서비스의 이용권한, 기타 이용 계약상 지위를 타인에게 양도, 증여할 수
								없으며, 이를 담보로 제공할 수 없습니다.
							</p>
							<h2 id="article12" class="terms-article-title">제12조. 회원 서비스
								혜택</h2>
							<p class="terms-article-text">
								1. 회원 가입을 통해 멤버십 카드를 발급 받은 회원은 회사의 상품을 구입하거나 서비스를 이용하고 본 약관 내
								고지된 바에 따라 멤버십 포인트를 회원 본인의 계정에 적립할 수 있습니다. 멤버십 포인트 적립 및 사용, 소멸에
								관한 상세 내용은 ‘제 13조. 포인트 안내’ 에 상세 기술합니다.<br> 2. 회원은 회사의 홈페이지,
								어플리케이션 등 온라인을 통하여 티켓을 예매할 수 있습니다. 단, 무분별한 서비스 이용 방지를 위하여 티켓
								예매/구매 내역이 회사가 정한 기준을 초과하는 경우 온라인 예매가 제한될 수 있습니다. 티켓 예매 제한 사항은
								회사의 홈페이지에 공지된 기준을 따르며, 회사의 내부 방침에 따라 사전 고지 후 변경될 수 있습니다.<br>
								3. 회원은 회사 홈페이지, ARS, 키오스크 및 모바일 앱 등을 이용하여 영화 티켓을 포함한 무비오에서 제공하는
								서비스를 이용할 수 있으며 E-MAIL 또는 SMS, 카카오 알림톡, 모바일 앱 푸쉬(APP PUSH)를 통한 영화
								및 극장, 구매 정보를 제공받습니다.<br> 4. 회원은 구매 또는 서비스 이용 실적에 따라 VIP
								회원으로 선정될 수 있습니다. VIP 회원 선정 기준 및 시기, VIP 자격 기간과 혜택은 별도의 회사 공지에
								따릅니다.<br> 5. 회원은 맞춤서비스를 위해 본인의 동의 과정을 통해 스페셜 멤버십에 가입할 수
								있습니다.<br> 6. 스페셜 멤버십은 기본적인 혜택은 동일하나, 별도의 공지를 통해 추가된 서비스를
								제공받을 수 있습니다. 스페셜 멤버십 혜택은 회사의 정책에 의거 공지를 통해 변경될 수 있습니다.<br>
								7. 회사는 가능한 한 회원에게 회사에서 계획하는 모든 행사에 참여할 수 있는 우선권을 부여토록 합니다.
							</p>
							<h2 id="article13" class="terms-article-title">제13조. 포인트 안내</h2>
							<p class="terms-article-text">
								1. 회원은 회원 본인이 티켓, 상품 및 서비스를 구입하고, 멤버십 카드를 제시하거나 회원을 식별할 수 있는 정보를
								제공하는 경우 포인트를 적립 받을 수 있습니다.<br> 2. 포인트는 티켓/상품을 구매하고 실제 결제한
								금액에 사전 고지된 적립률을 적용하여 산정합니다. 적립률은 회사의 홈페이지에서 확인 가능하며, 포인트 적립률 및
								적립 기준은 회사 내부 방침에 따라 사전 고지 후 변경될 수 있습니다.<br> 3. 포인트는 티켓/상품을
								결제한 시점에 회원 본인의 매출 금액에 대한 적립을 원칙으로 하며, 영화 상영 및 매점 상품 구매 이후 사후 적립은
								불가합니다.<br> 4. 포인트는 결제가 완료된 후 적립 예정 포인트로 적립되며 적립 예정 포인트는 사용
								가능 포인트에 포함되지 않습니다. 적립 예정 포인트는 상영일 및 구매일 익일 사용 가능 포인트로 전환되며 해당
								시점부터 포인트 사용이 가능합니다.<br> 5. 당사 및 제휴사에서 발행한 할인/관람 쿠폰 및 관람권 또는
								무비오 멤버십 포인트, 제휴사 포인트 등을 통해 할인을 받은 금액은 적립 금액에서 제외됩니다. 또한, 일부 상품,
								일부 극장/매장의 경우 적립이 되지 않거나 별도의 적립률이 적용될 수 있으며 상세 내용은 해당 쿠폰, 상품,
								극장/매장 등에 별도 공지합니다.<br> 6. 단체 관람을 통해 가격 할인을 받은 경우 포인트는 적립되지
								않습니다.<br> 7. 회원은 회사가 사전 공지한 행사, 이벤트 및 제휴 서비스를 통해 멤버십 포인트를
								추가로 적립 받을 수 있습니다. 이 경우 적립되는 멤버십 포인트는 행사, 이벤트 및 제휴 서비스 이용 시 별도로
								공지된 기준에 따라 적립되며, 해당 포인트는 VIP 선정기준에 제외됩니다.
							</p>
							<h2 id="article14" class="terms-article-title">제14조. 모바일 오더
								서비스</h2>
							<p class="terms-article-text">무비오 애플리케이션 이용 고객은 해당 애플리케이션에서
								제공되는 "모바일 오더 서비스"를 이용할 수 있습니다.</p>
							<h2 id="article15" class="terms-article-title">제15조. 기프트카드
								서비스</h2>
							<p class="terms-article-text">회사가 발행한 기프트카드(이하 "기프트카드"라고
								합니다.)를 구입 또는 정당한 방법으로 소지한 회원은 무비오가 제공하는 "기프트카드 서비스"를 이용할 수 있습니다.</p>
							<h2 id="article15" class="terms-article-title">제16조. 개인정보 수집 및 이용과 제공</h2>
							<p class="terms-article-text">
								1. 회사는 회원의 개인정보를 보호하고 존중합니다.<br> 2. 회사는 회원이 가입 신청을 할 때
								제공하거나 회사 서비스 이용 시 발생하는 각종 개인정보 외 사전에 회원으로부터 동의를 얻어 회원이 다양한 서비스
								이용 시 발생하는 정보를 수집하며, 회원의 개인정보는 본 이용 계약의 이행과 본 이용 계약상의 서비스 제공을 위한
								목적으로 사용됩니다. 또한 해당 정보를 분석하여 회원에게 보다 나은 서비스를 제공하고 고객 지향적인 마케팅 활동을
								하기 위해 사용합니다.<br> 3. 회사는 개인정보의 수집·이용·제공에 관한 동의란을 미리 선택한 것으로
								설정해 두지 않습니다. 또한, 개인정보의 수집·이용·제공에 관한 회원의 동의 거절 시 제한되는 서비스를 구체적으로
								명시하고, 필수 수집 항목이 아닌 개인 정보의 수집·이용·제공에 관한 회원의 동의 거절을 이유로 회원 가입 등
								서비스 제공을 제한하거나 거절하지 않습니다.<br> 4. 회원은 원하는 경우 언제든 회사에 제공한
								개인정보의 수집과 이용에 대한 동의를 철회할 수 있으며, 동의의 철회는 해지 신청을 하는 것으로 이루어집니다.
							</p>
							<h2 id="article17" class="terms-article-title">제17조. 개인정보 보유
								및 이용기간</h2>
							<p class="terms-article-text">회원이 가입 시 제공한 정보는 무분별한 회원 가입 방지
								및 고객 요구사항 처리 등을 위하여 회원 가입 시점부터 해지 완료 후 30일까지 보관할 수 있습니다. 법령의 규정에
								의하여 보존할 필요성이 있는 경우에는 예외로 합니다.</p>
							<h2 id="article18" class="terms-article-title">제18조. 회원의 게시물</h2>
							<p class="terms-article-text">
								1. 게시물에 대한 권리와 책임은 게시자에게 있으며 회사는 게시자의 동의 없이는 이를 서비스 내 게재 이외에 영리
								목적으로 사용할 수 없습니다. 단, 비영리적인 경우에는 그러지 아니하며 또한 회사는 서비스 내의 게재권을 갖습니다.<br>
								2. 회사는 서비스를 이용하여 얻은 정보를 가공, 판매하는 행위 등 서비스에 게재된 자료를 상업적으로 사용할 수
								없습니다.
							</p>
							<h2 id="article19" class="terms-article-title">제19조. 저작권 등의
								귀속</h2>
							<p class="terms-article-text">
								1. 회사가 작성한 저작물에 대한 저작권, 기타 지적재산권은 회사에 귀속합니다.<br> 2. 회사가
								제공하는 서비스 중 제휴 계약에 의해 제공되는 저작물에 대한 저작권, 기타 지적재산권은 해당 제공업체에 귀속합니다.<br>
								3. 회원은 회사의 서비스를 이용함으로써 얻은 정보를 회사의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타
								방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.<br> 4. 회원이 타인의
								저작권 등 지적재산권을 침해하였음을 이유로 타인으로부터 손해배상청구, 형사고소 등을 받은 경우 회원은 그로 인해
								발생하는 모든 손해를 배상하여야 하며 회사가 이로 인하여 입게 되는 손해(변호사 비용 포함)를 변상하여야 합니다.
							</p>
							<h2 id="article20" class="terms-article-title">제20조. 광고게재 및
								광고주와의 거래</h2>
							<p class="terms-article-text">
								1. 회사가 회원에게 서비스를 제공할 수 있는 서비스 투자기반의 일부는 광고게재를 통한 수익으로부터 나옵니다.
								서비스를 이용하고자 하는 자는 서비스 이용 시 노출되는 광고게재에 대해 동의하는 것으로 간주됩니다.<br>
								2. 회사는 본 서비스상에 게재되어 있거나 본 서비스를 통한 광고주의 판촉 활동에 회원이 참여하거나 교신 또는
								거래의 결과로서 발생하는 모든 손실 또는 손해에 대해 책임을 지지 않습니다.
							</p>
							<h2 id="article21" class="terms-article-title">제21조. 사이트의 연결</h2>
							<p class="terms-article-text">
								1. 회사는 사이트 내 하이퍼링크(하이퍼링크의 대상에는 문자, 그림 및 동화상 등이 포함됨)방식 등을 통해 타
								사이트를 연결시킬 수 있습니다.<br> 2. 회사는 회원이 해당 연결사이트와 독자적으로 상품 또는 용역을
								거래한 행위에 대해서는 아무런 책임을 부담하지 않습니다.
							</p>
							<h2 id="article22" class="terms-article-title">제22조. 서비스 이용
								책임</h2>
							<p class="terms-article-text">회원은 회사에서 권한 있는 사원이 서명한 명시적인 서면에
								구체적으로 허용한 경우를 제외하고는 서비스를 이용하여 상품을 판매하는 영업활동을 할 수 없으며 특히 해킹, 돈벌이
								광고, 음란 사이트 등을 통한 상업행위, 상용S/W 불법 배포 등을 할 수 없습니다. 이를 어기고 발생한 영업활동의
								결과 및 손실, 관계기관에 의한 구속 등 법적 조치 등에 관해서는 회사가 책임을 지지 않습니다.</p>
							<h2 id="article23" class="terms-article-title">제23조. 서비스 제공의
								중지</h2>
							<p class="terms-article-text">
								1. 회사는 다음 각 호에 해당하는 경우 서비스 제공을 중지할 수 있습니다.<br> 1) 서비스용 설비의
								보수 등 공사로 인한 부득이한 경우<br> 2) 전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를
								중지했을 경우<br> 3) 기타 불가항력적 사유가 있는 경우<br> 2. 회사는 국가비상사태,
								정전, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 정상적인 서비스 이용에 지장이 있는 때에는 서비스의 전부
								또는 일부를 제한하거나 중지할 수 있습니다.<br> 3. 회사는 제 1 항 및 2항의 규정에 의하여
								서비스의 이용을 제한하거나 중지한 때에는 그 사유 및 제한기간 등을 지체 없이 회원에게 알려야 합니다.
							</p>
							<h2 id="article24" class="terms-article-title">제24조. 손해배상</h2>
							<p class="terms-article-text">회사는 이용 요금이 무료인 서비스 이용과 관련하여
								회원에게 발생한 어떠한 손해에 관하여 회사의 고의 또는 중과실이 없는 한 책임을 지지 않습니다. 유료 서비스의
								경우는 서비스 별 이용약관에 따릅니다.</p>
							<h2 id="article25" class="terms-article-title">제25조. 면책</h2>
							<p class="terms-article-text">
								1. 회사는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한
								책임이 면제됩니다. 2. 회사는 아래 조항에 대하여 회사의 고의 또는 중과실이 없는 한 책임을 지지 않습니다.<br>
								1) 회원이 서비스를 이용하여 기대하는 수익을 상실한 것이나 서비스를 통하여 얻은 자료로 인해 손해가 발생할 경우<br>
								2) 회원이 사이트에 게재한 정보, 자료, 사실의 신뢰도, 정확성 등 내용에 관한 경우<br> 3. 회사는
								아래 조항에 대하여 회사의 고의 또는 과실이 없는 한 책임을 지지 않습니다.<br> 1) 회원의 귀책사유로
								인한 서비스 이용의 장애가 발생할 경우<br> 2) 서비스 이용과 관련하여 회원에게 발생한 손해 가운데
								회원의 고의, 과실에 의해 손해가 발생한 경우
							</p>
							<h2 id="article26" class="terms-article-title">제26조. 관할 법원</h2>
							<p class="terms-article-text">서비스 이용으로 발생한 분쟁에 대해 소송이 제기될 경우
								관할법원은 민사소송법상 규정에 따릅니다.</p>
							<h2 id="article27" class="terms-article-title">기타. 부칙</h2>
							<p class="terms-article-text">
								1. (시행일) 이 약관은 2024년 5월 10일부터 시행합니다.<br> 2. (변경) 종전의 약관은 본
								약관으로 대체합니다.
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../../footer.jsp"%>
</body>
</html>
