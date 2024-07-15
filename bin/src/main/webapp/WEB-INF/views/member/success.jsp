<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>회원가입 완료</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/member/success.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
  <script>
    $(document).ready(function() {
    	//회원가입 폼에서 입력한 유저 이름을 세션에서 받아옴
        var userName = '<%= session.getAttribute("username") %>';
        if (userName) {
        	//받아온 이름을 바탕으로 알맞는 메세지를 출력
            $("#user-message").html(userName + '<span class="highlight">님</span>, 회원가입을 축하드립니다!<br>이제 Movio의 다양한 혜택을 누리실 수 있습니다.');
        } else {
            $("#user-message").html('회원가입을 축하드립니다!<br>이제 Movio의 다양한 혜택을 누리실 수 있습니다.');
        }
    });
  </script>
</head>
<body>
<%@ include file="../../header.jsp" %>
   <div class="content">
    <div class="header">
      <h1>회원가입</h1>
      <p>회원 가입이 성공적으로 완료되었습니다.</p>
      <img src="<c:url value='/images/logo/회원가입_logo.png' />" alt="회원가입 절차">
    </div>
    <div id="registration-container">
      <div id="status-block">
        <div id="icon-block">🎉</div>
        <div id="message-block">
          <span id="user-message"></span>
        </div>
      </div>
      <div id="button-block">
        <div class="btn-container">
          <a href="<c:url value='/main' />" class="btn">메인으로</a>
        </div>
      </div>
    </div>
    
    <!-- 분실물, 1:1 문의에 대한 블록 -->
    <div id="info-container">
      <div id="info-block1" class="info-block">
        <div id="info-icon1" class="info-icon">
          
          <a href="<c:url value='/customer/support/lost' />"><img src="<c:url value='/images/logo/분실물.png' />" alt="분실물문의"></a>
        </div>
        <div id="info-message1" class="info-message">
          <h2>분실물 문의</h2>
          <p>극장에서 잃어버린 물건이 없으신가요? <br> 분실물 문의에서 확인하세요.</p>
        </div>
      </div>
      <div id="info-block2" class="info-block">
        <div id="info-icon2" class="info-icon">
          <a href="<c:url value='/customer/support/inquiry' />"><img src="<c:url value='/images/logo/문의.png' />" alt="1:1문의"></a>
        </div>
        <div id="info-message2" class="info-message">
          <h2>1:1 문의</h2>
          <p>평일: 다음 날 답변 완료<br>토, 일, 공휴일: 휴일 이후 답변 완료</p>
        </div>
      </div>
    </div>
  </div>
  <%@ include file="../../footer.jsp" %>
</body>
</html>
