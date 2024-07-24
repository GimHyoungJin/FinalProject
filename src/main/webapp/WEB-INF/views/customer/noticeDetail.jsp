<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
  <link href="<c:url value='/css/customer/customer_sidebar.css' />" rel="stylesheet" type="text/css">
  <script src="<c:url value='/js/notice.js' />"></script>
  <style>
    /* 전체 컨테이너 설정 */
    #container {
      padding: 20px;
    }

    /* 메인 콘텐츠 영역 설정 */
    #main-content {
      width: 100%;
      max-width: 900px;
      background-color: #fff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      display: flex;
      flex-direction: column;
    }

    /* 공지사항 상세보기 상단 설정 */
    .notice-detail {
      width: 100%;
    }

    /* 공지사항 제목 설정 */
    .notice-detail h3 {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 20px;
    }

    /* 공지사항 메타 정보 설정 */
    .notice-meta {
      display: flex;
      justify-content: space-between;
      color: #6c757d;
      margin-bottom: 20px;
    }

    /* 공지사항 메타 정보 항목 설정 */
    .notice-meta span {
      font-size: 14px;
    }

    /* 공지사항 내용 설정 */
    .notice-content {
      white-space: pre-wrap;
      line-height: 1.6;
      font-size: 16px;
      margin-bottom: 20px;
    }

    /* 관리자 버튼 설정 */
    .admin-button-container {
      display: flex;
      justify-content: flex-end;
      margin-top: 20px;
    }

    /* 관리자 버튼 스타일 설정 */
    .btn-warning, .btn-danger {
      margin-left: 10px;
    }

    /* 목록으로 버튼 설정 */
    .mt-3 {
      margin-top: 20px;
    }

    /* 보조 버튼 설정 */
    .btn-secondary {
      background-color: #6c757d;
      border: none;
      color: white;
      padding: 10px 20px;
      cursor: pointer;
    }

    .btn-secondary:hover {
      background-color: #5a6268;
    }
  </style>
</head>
<body>
  <%@ include file="../../header.jsp" %>
  <!-- 메인 콘텐츠 시작 -->
  <div id="container" class="d-flex mt-3">
    <div id="sidebar" class="me-3">
      <%@ include file="customer_sidebar.jsp" %>
    </div>
    <div id="main-content" class="d-flex flex-column align-items-center">
      <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
      </c:if>
      <h2>공지사항 상세보기</h2>
      <div class="notice-detail">
        <h3>${notice.title}</h3>
        <div class="notice-meta">
          <span>등록일: <fmt:formatDate value="${notice.regdate}" pattern="yyyy-MM-dd HH:mm" /></span>
          <span>조회수: ${notice.viewCount}</span>
        </div>
        <div class="notice-content">
          ${notice.content}
        </div>
        <div class="notice-actions">
          <div class="admin-button-container">
            <a href="/customer/noticeUpdateForm?noticeNum=${notice.noticeNum}" class="btn btn-sm btn-warning">수정</a>
            <button class="btn btn-sm btn-danger" onclick="deleteNotice(${notice.noticeNum})">삭제</button>
          </div>
        </div>
        <div class="mt-3">
          <button class="btn btn-secondary" onclick="location.href='<c:url value='/customer/noticeList' />'">목록으로</button>
        </div>
      </div>
    </div>
  </div>
  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="../../footer.jsp" %>
</body>
</html>
