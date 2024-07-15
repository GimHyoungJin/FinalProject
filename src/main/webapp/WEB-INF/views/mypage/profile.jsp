<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>개인정보 수정</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/admin/sidebar.css' />" rel="stylesheet" type="text/css">
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
         <a href="<c:url value='/mypage/bookinglist' />" class="list-group-item list-group-item-action">예매 내역</a>
          <a href="<c:url value='/mypage/vouchers' />" class="list-group-item list-group-item-action">영화 관람권</a>
          <a href="<c:url value='/mypage/store_vouchers' />" class="list-group-item list-group-item-action">스토어 교환권</a>
          <a href="<c:url value='/mypage/inquiry' />" class="list-group-item list-group-item-action">나의 문의내역</a>
          <a href="<c:url value='/mypage/profile' />" class="list-group-item list-group-item-action">회원정보</a>
        </div>
      </div>
  
  
  <!-- 메인 콘텐츠 시작 -->
  <div class="container-fluid mypage-container">
    <div class="row">
      
      <!-- 메인 콘텐츠 -->
      <div class="col-md-9">
        <h2>개인정보 수정</h2>
        <p>회원님의 정보를 정확히 입력해주세요.</p>
        <div class="mb-3 row">
          <label for="profileImage" class="col-sm-2 col-form-label">프로필 사진</label>
          <div class="col-sm-10">
            <img src="<c:url value='/images/profile-placeholder.png' />" alt="프로필 사진" class="img-thumbnail" style="max-width: 150px;">
            <button class="btn btn-secondary">이미지 등록</button>
            <p class="text-muted mt-2">※ 개인정보가 포함된 이미지 등록은 자제하여 주시기 바랍니다.</p>
          </div>
        </div>
        <div class="mb-3 row">
          <label for="username" class="col-sm-2 col-form-label">아이디</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" id="username" value="rkdxlwl1222">
          </div>
        </div>
        <h4>기본정보</h4>
        <div class="mb-3 row">
          <label for="name" class="col-sm-2 col-form-label">이름 *</label>
          <div class="col-sm-8">
            <input type="text" class="form-control" id="name" value="강지천">
          </div>
          <div class="col-sm-2">
            <button class="btn btn-secondary">이름변경</button>
          </div>
          <div class="col-sm-10 offset-sm-2">
            <p class="text-muted mt-2">※ 개명으로 이름이 변경된 경우, 회원정보의 이름을 변경하실 수 있습니다.</p>
          </div>
        </div>
        <div class="mb-3 row">
          <label for="birthdate" class="col-sm-2 col-form-label">생년월일 *</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" id="birthdate" value="1999년 12월 22일">
          </div>
        </div>
        <div class="mb-3 row">
          <label for="phone" class="col-sm-2 col-form-label">휴대폰 *</label>
          <div class="col-sm-8">
            <input type="text" class="form-control" id="phone" value="010-8481-7226">
          </div>
          <div class="col-sm-2">
            <button class="btn btn-secondary">휴대폰번호 변경</button>
          </div>
        </div>
        <div class="mb-3 row">
          <label for="email" class="col-sm-2 col-form-label">이메일 *</label>
          <div class="col-sm-10">
            <input type="email" class="form-control" id="email" value="rkdxlwl1222@naver.com">
          </div>
        </div>
        <div class="mb-3 row">
          <label for="password" class="col-sm-2 col-form-label">비밀번호 *</label>
          <div class="col-sm-10">
            <button class="btn btn-secondary">비밀번호 변경</button>
            <p class="text-muted mt-2">마지막 비밀번호 변경: 18일전에 함 (2024-06-13 17:51:11)</p>
          </div>
        </div>
        <div class="mb-3 row">
          <label for="address" class="col-sm-2 col-form-label">주소</label>
          <div class="col-sm-10">
            <button class="btn btn-secondary">우편번호 검색</button>
          </div>
        </div>
        <div class="mb-3 row">
          <div class="col-sm-10 offset-sm-2">
            <button class="btn btn-primary">저장</button>
            <button class="btn btn-danger">회원탈퇴</button>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="/WEB-INF/footer.jsp" %>
</body>
</html>
