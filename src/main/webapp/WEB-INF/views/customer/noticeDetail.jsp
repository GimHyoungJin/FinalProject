<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>공지사항 상세보기</title>
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
  <script src="<c:url value='/js/notice.js' />"></script>
  
</head>
<body>
  <%@ include file="../../header.jsp" %>
  <!-- 메인 콘텐츠 시작 -->
      <div id="container" class="d-flex justify-content-center mt-3">
    <div id="main-content" class="d-flex">
      <div id="sidebar" class="me-3">
        <%@ include file="customer_sidebar.jsp" %>
      </div>
 <div class="content flex-grow-1">
        <h1>공지사항</h1>
        
        <!-- 공지사항 상세보기 시작 -->
        <div class="notice-detail">
          <h2>${notice.title}</h2>
          <p class="meta">
            작성자: ${notice.writer} | 등록일: ${notice.regdate} | 조회수: ${notice.viewCount}
          </p>
          <div class="content">
            <p>${notice.content}</p>
          </div>
        </div>
        <!-- 공지사항 상세보기 끝 -->
      </div>
    </div>
  </div>
  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="../../footer.jsp" %>
</body>
</html>