<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>회원 수정</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
</head>
<body>
  <%@ include file="/WEB-INF/header.jsp" %>

  <div class="container mt-4">
    <h1>회원 수정</h1>
    <form class="mb-4" action="<c:url value='/admin/members/update' />" method="post">
      <input type="hidden" name="mem_id" value="${member.mem_id}">
      <div class="mb-3">
        <label for="username" class="form-label">이름</label>
        <input type="text" class="form-control" id="username" name="username" value="${member.username}" required>
      </div>
      <div class="mb-3">
        <label for="passwd" class="form-label">비밀번호</label>
        <input type="password" class="form-control" id="passwd" name="passwd" value="${member.passwd}" required>
      </div>
      <div class="mb-3">
        <label for="email" class="form-label">이메일</label>
        <input type="email" class="form-control" id="email" name="email" value="${member.email}" required>
      </div>
      <div class="mb-3">
        <label for="phone" class="form-label">전화번호</label>
        <input type="text" class="form-control" id="phone" name="phone" value="${member.phone}" required>
      </div>
      <div class="mb-3">
       <label for="birth" class="form-label">생년월일</label>
       <input type="date" class="form-control" id="birth" name="birth" value="${movie.birth}" required>
       </div>
      <div class="mb-3">
        <label for="gender" class="form-label">성별</label>
        <select class="form-select" id="gender" name="gender" required>
          <option value="M" <c:if test="${member.gender == 'M'}">selected</c:if>>남성</option>
          <option value="F" <c:if test="${member.gender == 'F'}">selected</c:if>>여성</option>
        </select>
      </div>
     <div class="mb-3">
                  <label for="zipcode" class="form-label">우편번호</label>
                  <input type="text" class="form-control" id="zipcode" name="zipcode" required>
              </div>
              <div class="mb-3">
                  <label for="address1" class="form-label">주소 1</label>
                  <input type="text" class="form-control" id="address1" name="address1" required>
              </div>
              <div class="mb-3">
                  <label for="address2" class="form-label">주소 2</label>
                  <input type="text" class="form-control" id="address2" name="address2" required>
              </div>
      <div class="mb-3">
        <label for="sms_agree" class="form-label">SMS 수신 동의</label>
        <select class="form-select" id="sms_agree" name="sms_agree" required>
          <option value="Y" <c:if test="${member.sms_agree == 'Y'}">selected</c:if>>예</option>
          <option value="N" <c:if test="${member.sms_agree == 'N'}">selected</c:if>>아니오</option>
        </select>
      </div>
      <div class="mb-3">
        <label for="email_agree" class="form-label">이메일 수신 동의</label>
        <select class="form-select" id="email_agree" name="email_agree" required>
          <option value="Y" <c:if test="${member.email_agree == 'Y'}">selected</c:if>>예</option>
          <option value="N" <c:if test="${member.email_agree == 'N'}">selected</c:if>>아니오</option>
        </select>
      </div>
      <div class="mb-3">
        <label for="mem_grade" class="form-label">회원 등급</label>
        <select class="form-select" id="mem_grade" name="mem_grade" required>
          <option value="1" <c:if test="${member.mem_grade == 1}">selected</c:if>>일반 회원</option>
          <option value="2" <c:if test="${member.mem_grade == 2}">selected</c:if>>우수 회원</option>
          <option value="0" <c:if test="${member.mem_grade == 0}">selected</c:if>>관리자</option>
        </select>
      </div>
      <button type="submit" class="btn btn-primary">수정</button>
    </form>
  </div>
  
  <%@ include file="/WEB-INF/footer.jsp" %>
</body>
</html>
