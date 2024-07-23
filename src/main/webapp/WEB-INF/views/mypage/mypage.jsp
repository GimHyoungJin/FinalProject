<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>mypage</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/admin/sidebar.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/mypage/mypage.css' />" rel="stylesheet" type="text/css">
</head>
<body>
  <%@ include file="/WEB-INF/header.jsp" %>
  <div class="container-fluid mypage-container">
    <div class="row">
      <div class="col-md-3 sidebar">
        <div class="list-group">
          <a href="<c:url value='/mypage/mypage' />" class="list-group-item header" aria-current="true">
            나의 무비오
          </a>
          <a href="<c:url value='/mypage/bookinglist' />" class="list-group-item list-group-item-action">예매/구매 내역</a>
          <a href="<c:url value='/mypage/inquiry' />" class="list-group-item list-group-item-action">나의 문의내역</a>
          <a href="<c:url value='/mypage/profile' />" class="list-group-item list-group-item-action">회원정보</a>
          <a href="<c:url value='/mypage/store_vouchers' />" class="list-group-item list-group-item-action">스토어 교환권</a>
        </div>
      </div>
  
      <!-- 메인 콘텐츠 시작 -->
      <div class="col-md-9">
        <div class="profile-header">
          <div class="user-info">
            <h2>안녕하세요! ${username}님</h2>
            <p><h1>현재등급: 
              <c:choose>
                  <c:when test="${mem_grade == 0}">관리자</c:when>
                  <c:when test="${mem_grade == 1}">일반 회원</c:when>
                  <c:when test="${mem_grade == 2}">우수 회원</c:when>
                  <c:otherwise>알 수 없음</c:otherwise>
              </c:choose>
            </h1></p>
          </div>
        </div>

        <div class="progress-bar-container">
          <div class="progress-bar">
            <div style="width: ${points / nextGradePoints * 100}%;"></div>
          </div>
        </div>

        <div class="card-container">
          
          <div class="card">
            <h5>관람권/쿠폰</h5>
            <p>영화관람권: 0매</p>
            <p>스토어교환권: 0매</p>
          </div>
        </div>

        <div class="card mt-3">
          <div class="card-body">
            <h5 class="card-title">나의 예매내역</h5>
            <a href="<c:url value='/mypage/bookinglist' />" class="btn btn-link">더보기</a>
          </div>
        </div>
      
      </div>
    </div>
  </div>
  <%@ include file="/WEB-INF/footer.jsp" %>
</body>
</html>
