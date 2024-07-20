<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>결제 완료</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/member/success.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
</head>
<body>
<%@ include file="../../header.jsp" %>
   <div class="content">
    <div class="header">
      <h1>결제</h1>
      <p>결제가 성공적으로 완료되었습니다.</p>
    </div>
    <div id="registration-container">
      <div id="status-block">
        <div id="icon-block">🎉</div>
        <div id="booking-details">
        <h2>예매 정보</h2>
        <p>예매번호: <c:out value="${reservation.reservation_id}" /></p>
        <p>예매한 영화: <c:out value="${reservation.movie_title}" /></p>
        <p>상영 날짜 및 시간: <c:out value="${reservation.play_date}" /> <c:out value="${reservation.start_time}" /> - <c:out value="${reservation.end_time}" /></p>
        <p>좌석: <c:out value="${reservation.seats}" /></p>
        <p>극장 이름: <c:out value="${reservation.theater_name}" /></p>
        <p>상영관 번호: <c:out value="${reservation.screen_num}" /></p>
        <p>결제 금액: <c:out value="${reservation.total_amount}" />원</p>
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
