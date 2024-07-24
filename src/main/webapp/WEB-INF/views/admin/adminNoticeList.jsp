<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>관리자 공지사항 리스트</title>
  <meta charset="utf-8">
  <!-- 공통 시작 -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<c:url value='/css/header.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/footer.css' />" rel="stylesheet" type="text/css">
  <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
  <!-- 공통 끝 -->
  <link href="<c:url value='/css/customer/adminNotice.css' />" rel="stylesheet" type="text/css">
  <link href="<c:url value='/css/customer/customer_sidebar.css' />" rel="stylesheet" type="text/css">
  <script src="<c:url value='/js/adminNotice.js' />"></script>
  
</head>
<body>
  <%@ include file="../../header.jsp" %>
  <!-- 메인 콘텐츠 시작 -->
<div class="container-fluid content-container">
    <div class="row">
        <!-- 사이드바 포함 -->
        <div class="col-3">
            <%@ include file="../customer/customer_sidebar.jsp" %>
        </div>
        <!-- 공지사항 목록 -->
        <div class="col-9 d-flex justify-content-center">
            <div class="content-wrapper">
                <h2>공지사항</h2>
                <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>
                <div class="notice-top">
                    <!-- 관리자만 공지사항 작성 가능 -->
                    <div class="admin-button-container" style="display: none;">
                        <button class="btn btn-primary" onclick="window.location.href='/admin/notices?action=createForm'">공지사항 작성</button>
                    </div>
                    <!-- 검색 바 -->
                    <div class="search-bar">
                        <select class="form-select">
                            <option value="title">제목</option>
                            <option value="content">내용</option>
                        </select>
                        <input type="text" class="form-control" placeholder="검색어를 입력하세요">
                        <button class="btn btn-secondary">검색</button>
                    </div>
                </div>
                <!-- 공지사항 테이블 -->
                <table class="table table-striped">
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
                                <td><a href="/admin/notices?action=detail&noticeNum=${notice.noticeNum}">${notice.title}</a></td>
                                <td>${notice.regdate}</td>
                                <td>${notice.viewCount}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <!-- 페이지네이션 -->
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
</div>
  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="../../footer.jsp" %>
</body>
</html>