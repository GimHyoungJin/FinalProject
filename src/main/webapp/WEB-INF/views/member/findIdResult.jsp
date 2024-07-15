<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>아이디 찾기 결과</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <style>
    .result-container {
      background-color: #f9f9f9;
      padding: 30px;
      border: 1px solid #e0e0e0;
      border-radius: 10px;
      margin-top: 50px;
      margin-bottom: 150px;
      
    }
    .result-header {
      font-size: 24px;
      font-weight: bold;
    }
    .result-content {
      font-size: 18px;
      margin-top: 20px;
    }
    .result-content strong {
      color: orange;
    }
    .result-buttons {
      margin-top: 30px;
    }
  </style>
</head>
<body>
  <%@ include file="../../header.jsp" %>

  <!-- 메인 콘텐츠 시작 -->
  <div class="container mt-5">
    <h2 class="text-center">아이디 확인</h2>
    <p class="text-center">입력하신 정보와 일치하는 아이디는 다음과 같습니다.</p>
    <div class="result-container text-center">
      <c:choose>
        <c:when test="${not empty userId}">
          <p class="result-header">회원님 아이디는 <strong>${userId}</strong> 입니다.</p>
          <p class="result-content">이메일 주소: <strong>${userEmail}</strong></p>
          <div class="result-buttons">
            <a href="<c:url value='/member/findIdPw' />" class="btn btn-outline-dark me-2">비밀번호 찾기</a>
            <a href="<c:url value='/' />" class="btn btn-dark">메인으로</a>
          </div>
        </c:when>
        <c:otherwise>
          <div class="alert alert-danger text-center" role="alert">
            입력하신 정보와 일치하는 아이디가 없습니다.
          </div>
          <div class="result-buttons">
            <a href="<c:url value='/member/findIdPw' />" class="btn btn-primary">다시 시도하기</a>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
  <!-- 메인 콘텐츠 끝 -->

  <%@ include file="../../footer.jsp" %>
</body>
</html>
