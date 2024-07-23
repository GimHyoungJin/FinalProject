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
        <h2>공지사항</h2>
        <div class="notice-top">
          <div class="search-bar">
            <select class="form-select" id="searchType">
              <option value="title">제목</option>
              <option value="content">내용</option>
            </select>
            <input type="text" class="form-control" id="searchKeyword" placeholder="검색어를 입력하세요">
            <button class="btn btn-secondary" onclick="searchNotices()">검색</button>
          </div>
        </div>
        <table class="table table-striped">
          <thead>
            <tr>
              <th>번호</th>
              <th>제목</th>
              <th>등록일</th>
              <th>조회수</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="notice" items="${notices}">
              <tr>
                <td>${notice.noticeNum}</td>
                <td><a href="/admin/notices?action=detail&noticeNum=${notice.noticeNum}">${notice.title}</a></td>
                <td>${notice.regdate}</td>
                <td>${notice.viewCount}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
        <nav>
          <ul class="pagination justify-content-center">
            <c:forEach var="i" begin="1" end="${totalPages}">
              <li class="page-item ${currentPage == i ? 'active' : ''}">
                <a class="page-link" href="?page=${i}">${i}</a>
              </li>
            </c:forEach>
          </ul>
        </nav>
      </div>
    </div>
  </div>
  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="../../footer.jsp" %>
  <script>
    function searchNotices() {
      var type = document.getElementById('searchType').value;
      var keyword = document.getElementById('searchKeyword').value;
      window.location.href = '/admin/notices?action=search&type=' + type + '&keyword=' + keyword;
    }
  </script>
</body>
</html>