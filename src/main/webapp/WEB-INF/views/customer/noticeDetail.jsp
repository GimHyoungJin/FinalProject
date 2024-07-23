<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>공지사항 목록</title>
  <meta charset="utf-8">
  <!-- 공통 시작 -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
  <!-- 공통 끝 -->
  <link href="<c:url value='/css/customer/notice.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/customer/customer_sidebar.css' />" rel="stylesheet" type="text/css">
</head>
<body>
  <%@ include file="../../header.jsp" %>
   <!-- 메인 콘텐츠 시작 -->
  <div id="container" class="d-flex justify-content-center mt-3">
    <div id="main-content" class="d-flex">
      <div id="sidebar" class="me-3">
        <%@ include file="../customer/customer_sidebar.jsp" %>
      </div>
      <div class="content-wrapper">
        <h2>공지사항 상세보기</h2>
        <div class="notice-detail">
          <h3>${notice.title}</h3>
          <div class="notice-meta">
            <span>등록일: ${notice.regdate}</span>
            <span>조회수: ${notice.viewCount}</span>
          </div>
          <div class="notice-content">
            ${notice.content}
          </div>
          <div class="mt-3">
            <button class="btn btn-secondary" onclick="window.history.back()">목록으로</button>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="../../footer.jsp" %>
</body>
</html>