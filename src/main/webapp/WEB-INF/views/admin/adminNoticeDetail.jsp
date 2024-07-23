<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>관리자 공지사항 상세보기</title>
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
        <div class="col-3">
            <%@ include file="../customer/customer_sidebar.jsp" %>
        </div>
        <div class="col-9 d-flex justify-content-center">
            <div class="content-wrapper">
                <h2>공지사항 상세보기</h2>
                  <c:if test="${not empty errorMessage}">
              <div class="alert alert-danger">${errorMessage}</div>
          </c:if>
                <div class="notice-detail">
                    <h3>${notice.title}</h3>
                    <div class="notice-meta">
                        <span>등록일: ${notice.regdate}</span>
                        <span>조회수: ${notice.viewCount}</span>
                    </div>
                    <div class="notice-content">
                        ${notice.content}
                    </div>
                    <div class="notice-actions">
                        <c:if test="${sessionScope.username == 'master1004'}">
                            <a href="/admin/notices?action=updateForm&noticeNum=${notice.noticeNum}" class="btn btn-sm btn-warning">수정</a>
                            <button class="btn btn-sm btn-danger" onclick="deleteNotice(${notice.noticeNum})">삭제</button>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
  <!-- 메인 콘텐츠 끝 -->
  <%@ include file="../../footer.jsp" %>
</body>
</html>