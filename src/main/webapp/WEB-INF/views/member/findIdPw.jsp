<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>아이디/비밀번호 찾기</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="<c:url value='/js/findIdPw.js' />"></script>
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/member/findIdPw.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
</head>
<body>
  <%@ include file="../../header.jsp" %>

  <!-- 메인 콘텐츠 시작 -->
  <div id="find-account-container" class="container mt-5">
    <h2 class="text-center">아이디/비밀번호 찾기</h2>
    <div class="d-flex justify-content-center">
      <ul class="nav nav-tabs mt-3" id="myTab" role="tablist">
        <li class="nav-item" role="presentation">
          <button class="nav-link active" id="find-id-tab" data-bs-toggle="tab" data-bs-target="#find-id" type="button" role="tab" aria-controls="find-id" aria-selected="true">아이디 찾기</button>
        </li>
        <li class="nav-item" role="presentation">
          <button class="nav-link" id="find-pw-tab" data-bs-toggle="tab" data-bs-target="#find-pw" type="button" role="tab" aria-controls="find-pw" aria-selected="false">비밀번호 찾기</button>
        </li>
      </ul>
    </div>
    <div class="tab-content">
      <div class="tab-pane fade show active" id="find-id" role="tabpanel" aria-labelledby="find-id-tab">
        <div class="form-container">
          <form id="find-id-form" action="${pageContext.request.contextPath}/member/findId" method="post">
            <div class="mb-3">
              <label for="username" class="form-label">이름</label>
              <input type="text" class="form-control" id="username" name="username" maxlength="15" required>
            </div>
            <div class="mb-3">
              <label for="phone-id" class="form-label">휴대폰 번호</label>
              <input type="text" class="form-control" id="phone-id" name="phone" maxlength="13" required>
              <div id="phone-check-result-id" class="invalid-feedback"></div>
            </div>
            <div class="d-flex justify-content-center">
              <button type="submit" class="btn btn-primary">인증확인</button>
            </div>
          </form>
        </div>
      </div>

      <div class="tab-pane fade" id="find-pw" role="tabpanel" aria-labelledby="find-pw-tab">
        <div class="form-container">
          <form id="find-pw-form" action="${pageContext.request.contextPath}/member/findPassword" method="post">
            <div class="mb-3">
              <label for="user-id" class="form-label">아이디</label>
              <input type="text" class="form-control" id="user-id" name="mem_id" required>
            </div>
            <div class="mb-3">
              <label for="email" class="form-label">이메일 주소</label>
              <input type="email" class="form-control" id="email" name="email" required>
              <div id="email-check-result-pw" class="invalid-feedback"></div>
            </div>
            <div class="mb-3">
              <label for="phone-pw" class="form-label">휴대폰 번호</label>
              <input type="text" class="form-control" id="phone-pw" name="phone" required>
              <div id="phone-check-result-pw" class="invalid-feedback"></div>
            </div>
            <div class="d-flex justify-content-center">
              <button type="submit" class="btn btn-primary">인증확인</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  
  <!-- 하단 링크 블록 추가 -->
  <div id="find-account-container-bottom" class="bottom-links">
    <a href="<c:url value='/member/agreement' />">회원가입</a>
    <a href="<c:url value='/faq' />">1:1 문의</a>
  </div>
  <!-- 메인 콘텐츠 끝 -->

  <%@ include file="../../footer.jsp" %>
</body>
</html>
