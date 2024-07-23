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
<!-- 메인 콘텐츠 영역 시작 -->
      <div class="col-md-9">
        <h1>공지사항</h1>
        
        <!-- 검색 섹션 시작 -->
        <div class="search-section">
          <input type="text" id="search" placeholder="검색어를 입력하세요">
          <button id="search-button">검색</button>
        </div>
        <!-- 검색 섹션 끝 -->

        <!-- 공지사항 목록 시작 -->
        <table class="table">
          <thead>
            <tr>
              <th>번호</th>
              <th>제목</th>
              <th>작성자</th>
              <th>작성일</th>
              <th>조회수</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="notice" items="${notices}">
              <tr>
                <td>${notice.noticeNum}</td>
                <td><a href="#" class="notice-link" data-id="${notice.noticeNum}">${notice.title}</a></td>
                <td>${notice.writer}</td>
                <td>${notice.regdate}</td>
                <td>${notice.viewCount}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
        <!-- 공지사항 목록 끝 -->

        <!-- 페이지네이션 시작 -->
        <div class="pagination">
          <c:if test="${currentPage > 1}">
            <a href="#" class="page-link" data-page="${currentPage - 1}">이전</a>
          </c:if>
          <c:forEach begin="1" end="${totalPages}" var="i">
            <a href="#" class="page-link" data-page="${i}">${i}</a>
          </c:forEach>
          <c:if test="${currentPage < totalPages}">
            <a href="#" class="page-link" data-page="${currentPage + 1}">다음</a>
          </c:if>
        </div>
        <!-- 페이지네이션 끝 -->
      </div>
      <!-- 메인 콘텐츠 영역 끝 -->
    </div>
  </div>
  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="../../footer.jsp" %>
</body>
</html>