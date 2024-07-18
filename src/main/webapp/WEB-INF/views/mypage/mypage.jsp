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
  <link href="<c:url value='/css/mypage/mypage.css' />" rel="stylesheet" type="text/css"> <!-- 여기 경로를 확인하세요 -->
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
        </div>
      </div>
  
      <!-- 메인 콘텐츠 시작 -->
      <div class="col-md-9">
        <div class="profile-header">
          <img src="<c:url value='/images/poster/탈주.png' />" alt="프로필 이미지" width="100" height="100">
          <div class="user-info">
            <h1>안녕하세요! 강지천님</h1>
            <p>현재등급: FAMILY</p>
          </div>
          <div class="points">
            <h1>0 P</h1>
            <p>다음 Friends 등급까지 6,000 P 남았어요!</p>
          </div>
        </div>

        <div class="progress-bar-container">
          <div class="progress-bar">
            <div style="width: 0%;"></div>
          </div>
          <div class="progress-label">6,000 P 남았어요!</div>
        </div>

        <div class="card-container">
          <div class="card">
            <h5>포인트 이용내역</h5>
            <p>적립예정: 0 P</p>
            <p>당월소멸예정: 0 P</p>
          </div>
          <div class="card">
            <h5>선호하는 극장</h5>
            <p>선호극장을 설정하세요.</p>
          </div>
          <div class="card">
            <h5>관람권/쿠폰</h5>
            <p>영화관람권: 0매</p>
            <p>스토어교환권: 0매</p>
            
          </div>
         
        </div>

        <ul class="nav nav-tabs mt-3" id="myTab" role="tablist">
          <li class="nav-item" role="presentation">
            <a class="nav-link active" id="family-tab" data-bs-toggle="tab" href="#family" role="tab" aria-controls="family" aria-selected="true">FAMILY</a>
          </li>
          <li class="nav-item" role="presentation">
            <a class="nav-link" id="vip-tab" data-bs-toggle="tab" href="#vip" role="tab" aria-controls="vip" aria-selected="false">VIP</a>
          </li>
          <li class="nav-item" role="presentation">
            <a class="nav-link" id="vvip-tab" data-bs-toggle="tab" href="#vvip" role="tab" aria-controls="vvip" aria-selected="false">VVIP</a>
          </li>
          <li class="nav-item" role="presentation">
            <a class="nav-link" id="admin" data-bs-toggle="tab" href="#admin" role="tab" aria-controls="admin" aria-selected="false">ADMIN</a>
          </li>
        </ul>
        <div class="tab-content" id="myTabContent">
          <div class="tab-pane fade show active" id="family" role="tabpanel" aria-labelledby="family-tab">Family content</div>
          <div class="tab-pane fade" id="vip" role="tabpanel" aria-labelledby="vip-tab">VIP content</div>
          <div class="tab-pane fade" id="vvip" role="tabpanel" aria-labelledby="vvip-tab">VVIP content</div>
          <div class="tab-pane fade" id="admin" role="tabpanel" aria-labelledby="admin-tab">Admin content</div>
        </div>

         <div class="card mt-3">
          <div class="card-body">
            <h5 class="card-title">나의 예매내역</h5>
            <a href="<c:url value='/mypage/mypage/bookinglist' />" class="btn btn-link">더보기</a>
          </div>
        </div>
        
         <div class="card mt-3">
          <div class="card-body">
            <h5 class="card-title">나의 티켓내역</h5>
            <a href="#" class="btn btn-link">더보기</a>
          </div>
        </div>
      </div>
    </div>
  </div>
  <%@ include file="/WEB-INF/footer.jsp" %>
</body>
</html>
