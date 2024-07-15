<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>회원가입</title>
  <meta charset="UTF-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="<c:url value='/js/memberForm.js' />"></script> <!-- 자바스크립트 파일 포함 -->
  <link href="<c:url value='/css/member/memberForm.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/member/modal.css' />" rel="stylesheet" type="text/css">
</head>
<body>
<div class="container">
  <!-- 회원가입 폼 -->
  <form name="memfrm" id="memfrm" onsubmit="submitForm(); return false;">
    <div class="home-button" style="margin-bottom: 20px;">
      <!-- 홈 버튼 -->
      <a class="navbar-brand" href="<c:url value='/' />">
        <img id="logo-image" src="<c:url value='/images/logo/movio logo.png' />" alt="Movio" width="50">
      </a>
    </div>

    <!-- 아이디 입력 -->
    <div class="form-group">
      <label for="mem_id">*아이디</label>
      <input type="text" name="mem_id" id="mem_id" size="10" maxlength="20" required>
      <div id="id-check-result" class="text-danger"></div>
    </div>

    <!-- 비밀번호 입력 -->
    <div class="form-group">
      <label for="passwd">*비밀번호</label>
      <input type="password" name="passwd" id="passwd" size="10" maxlength="15" required>
    </div>

    <!-- 비밀번호 확인 -->
    <div class="form-group">
      <label for="repasswd">*비밀번호 확인</label>
      <input type="password" name="repasswd" id="repasswd" size="10" maxlength="15" required>
      <div id="password-check-result" class="text-danger"></div>
    </div>

    <!-- 이름 입력 -->
    <div class="form-group">
      <label for="username">*이름</label>
      <input type="text" name="username" id="username" size="20" maxlength="20" required>
      <div id="name-check-result" class="text-danger"></div>
    </div>

    <!-- 이메일 입력 -->
    <div class="form-group">
      <label for="email">*이메일</label>
      <input type="email" name="email" id="email" size="30" maxlength="100" required>
      <div id="email-check-result" class="text-danger"></div>
    </div>

    <!-- 전화번호 입력 -->
    <div class="form-group">
      <label for="phone">*전화번호</label>
      <input type="text" name="phone" id="phone" size="15" maxlength="13" required>
       <div id="phone-check-result"  class="text-danger"></div>
    </div>

    <!-- 생년월일 입력 -->
    <div class="form-group">
      <label for="birth">*생년월일 (8자리)</label>
      <input type="text" name="birth" id="birth" size="10" maxlength="8" required>
      <div id="birth-check-result" class="text-danger"></div>
    </div>

    <!-- 성별 선택 -->
    <div class="form-group">
      <label for="gender">*성별</label>
      <input type="radio" name="gender" id="gender_m" value="M" required> 남성
      <input type="radio" name="gender" id="gender_f" value="F" required> 여성
    </div>

    <!-- 주소 입력 -->
    <div class="form-group">
      <label for="zipcode">우편번호</label>
      <input type="text" name="zipcode" id="zipcode" size="7" readonly>
      <button type="button" onclick="DaumPostcode()">주소찾기</button>
    </div>
    <div class="form-group">
      <label for="address1">주소</label>
      <input type="text" name="address1" id="address1" size="45" readonly>
      <label for="address2">나머지주소</label>
      <input type="text" name="address2" id="address2" size="45">
    </div>

    <!-- SMS 수신동의 -->
    <div class="form-group">
      <label for="sms_agree">SMS 수신동의</label>
      <input type="radio" name="sms_agree" id="sms_agree_y" value="Y" required> 예
      <input type="radio" name="sms_agree" id="sms_agree_n" value="N" required> 아니오
    </div>

    <!-- 이메일 수신동의 -->
    <div class="form-group">
      <label for="email_agree">이메일 수신동의</label>
      <input type="radio" name="email_agree" id="email_agree_y" value="Y" required> 예
      <input type="radio" name="email_agree" id="email_agree_n" value="N" required> 아니오
    </div>

    <!-- 버튼들 -->
    <input type="submit" value="가입완료" class="btn btn-primary">
    <button type="button" class="btn btn-danger" onclick="window.location.href='<c:url value='/main' />'">취소</button>
  </form>
</div>

<!-- DAUM 우편번호 API 모달 -->
<div class="modal fade" id="postcodeModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document" style="max-width: 800px;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalLabel">우편번호 찾기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="modalBody" style="height: 600px;"></div>
    </div>
  </div>
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>
